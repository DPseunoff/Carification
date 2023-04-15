import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_carification_app/common/error_receiver.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

enum ImagePickerType { camera, gallery }

class ImageController extends GetxController {
  var imagePath = '';
  var imageName = '';
  XFile? _currentImg;

  static const _base = "https://carification-service-goskurikhin.amvera.io";

  final isTakingPicture = false.obs;

  Future<void> takeImage({
    required Future Function() onSuccessCallback,
    required ImagePickerType type,
  }) async {
    final errorReceiver = Get.find<ErrorReceiver>();
    if (isTakingPicture.value) {
      return;
    }
    try {
      isTakingPicture.value = true;
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(
        source: type == ImagePickerType.camera
            ? ImageSource.camera
            : ImageSource.gallery,
      );
      if (file == null) {
        isTakingPicture.value = false;
        errorReceiver.onError('Image is null');
        return;
      }
      imagePath = file.path;
      imageName = file.name;
      _currentImg = file;
      isTakingPicture.value = false;
      await onSuccessCallback();
    } catch (e) {
      errorReceiver.onError('Image not picked');
      debugPrint(e.toString());
    }
  }

  File getImageFile() => File(imagePath);

  Future<void> onUseTap() async {
    await upload(_currentImg!);
    clearImage();
  }

  void clearImage() {
    imagePath = '';
    imageName = '';
    _currentImg = null;
  }

  Future<void> upload(XFile imageFile) async {
    isTakingPicture.value = true;

    final galleryController = Get.find<GalleryController>();
    final errorReceiver = Get.find<ErrorReceiver>();

    final dioInstance = dio.Dio();
    final uri = Uri.parse('$_base/predict_image');

    final formData = dio.FormData.fromMap({
      'image': await dio.MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.name,
      ),
    });

    late final dio.Response response;
    try {
      response = await dioInstance.post(
        uri.toString(),
        data: formData,
        options: dio.Options(responseType: dio.ResponseType.json),
      );
      debugPrint(response.statusCode.toString());

      final prediction = response.data['prediction'];

      debugPrint(prediction);

      await galleryController.onSaveImageToDevice(
        prediction: prediction,
        image: imageFile,
      );
    } on dio.DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        errorReceiver.onError('Dio request error');
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        errorReceiver.onError('Something went wrong');
        print(e.requestOptions);
        print(e.message);
      }
    } catch (e) {
      errorReceiver.onError('Unknown type of error');
    } finally {
      isTakingPicture.value = false;
    }
  }
}

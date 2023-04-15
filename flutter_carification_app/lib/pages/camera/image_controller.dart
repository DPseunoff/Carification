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

  static const _base = "http://carification.hopto.org";

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
        return;
      }
      imagePath = file.path;
      imageName = file.name;
      _currentImg = file;
      isTakingPicture.value = false;
      await onSuccessCallback();
    } catch (e) {
      errorReceiver.onError('Image pick error');
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
      switch (e.type) {
        case dio.DioErrorType.connectionTimeout:
          errorReceiver.onError('Connection timeout');
          break;
        case dio.DioErrorType.sendTimeout:
          errorReceiver.onError('Send timeout');
          break;
        case dio.DioErrorType.receiveTimeout:
          errorReceiver.onError('Receive timeout');
          break;
        case dio.DioErrorType.badCertificate:
          errorReceiver.onError('Bad certificate');
          break;
        case dio.DioErrorType.badResponse:
          errorReceiver.onError('Bad response');
          break;
        case dio.DioErrorType.cancel:
          errorReceiver.onError('Cancel response');
          break;
        case dio.DioErrorType.connectionError:
          errorReceiver.onError('Connection error');
          break;
        case dio.DioErrorType.unknown:
          errorReceiver.onError('Dio unknown type of error');
          break;
      }
    } catch (e) {
      errorReceiver.onError('Unknown type of error');
    } finally {
      isTakingPicture.value = false;
    }
  }
}

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

enum ImagePickerType { camera, gallery }

class ImageController extends GetxController {
  var imagePath = '';
  var imageName = '';
  XFile? _currentImg;

  static const _base = "https://carrification-service.onrender.com";

  final isTakingPicture = false.obs;

  Future<void> takeImage({
    required Future Function() onSuccessCallback,
    required ImagePickerType type,
  }) async {
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
    var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse('$_base/analyze');

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(imageFile.path),
    );

    request.files.add(multipartFile);
    final response = await request.send();
    debugPrint(response.statusCode.toString());
    response.stream.transform(utf8.decoder).listen((value) {
      debugPrint(value);
    });
  }
}

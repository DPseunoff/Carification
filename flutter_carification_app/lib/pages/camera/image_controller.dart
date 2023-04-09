import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerType { camera, gallery }

class ImageController extends GetxController {
  var imagePath = '';
  var imageName = '';

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
      isTakingPicture.value = false;
      await onSuccessCallback();
    } catch (e) {
      print(e);
    }
  }

  File getImageFile() => File(imagePath);

  void onUseTap() {
    clearImage();
  }

  void clearImage() {
    imagePath = '';
    imageName = '';
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    imagePath = file.path;
    imageName = file.name;
  }
}

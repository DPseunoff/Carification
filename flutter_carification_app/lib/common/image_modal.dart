import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/button.dart';

import '../utils/app_colors.dart';

typedef CameraCallback = void Function();
typedef GalleryCallback = void Function();

class ImageModal {
  static const _borderRadius = 20.0;

  Future<void> show(
    BuildContext context, {
    required CameraCallback cameraCallback,
    required GalleryCallback galleryCallback,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_borderRadius),
          topRight: Radius.circular(_borderRadius),
        ),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadius),
            topRight: Radius.circular(_borderRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            MainButton(
              buttonTitle: 'Camera',
              onTap: cameraCallback,
              padding: 10,
            ),
            const SizedBox(height: 15),
            MainButton(
              buttonTitle: 'Gallery',
              onTap: galleryCallback,
              padding: 10,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      enableDrag: false,
      isDismissible: true,
    );
  }
}

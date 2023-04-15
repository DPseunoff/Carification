import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/button.dart';

import '../utils/app_colors.dart';
import '../utils/app_textstyles.dart';

typedef CameraCallback = void Function();
typedef GalleryCallback = void Function();

class ImageMenus {
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

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Text(
            message,
            style: AppTextStyles.onBoardingDescription(height: 16),
          )
        ],
      ),
      duration: const Duration(milliseconds: 3000),
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.03 + 77),
      padding: const EdgeInsets.only(left: 21, top: 16, bottom: 16),
      elevation: 0,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

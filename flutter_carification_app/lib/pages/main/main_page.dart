import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/image_modal.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/navigation/app_router.gr.dart';
import 'package:flutter_carification_app/pages/camera/image_controller.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _imageController = Get.find<ImageController>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarTitle: 'Predictions',
      appBarAction: GestureDetector(
        onTap: () => context.router.push(const InfoRoute()),
        child: SvgPicture.asset(AppAssets.infoIcon),
      ),
      body: Positioned.fill(
        child: Column(
          children: [
            const Spacer(),
            _cameraButton(
              onTap: () => ImageModal().show(
                context,
                cameraCallback: () => _modalCallback(
                  context,
                  type: ImagePickerType.camera,
                ),
                galleryCallback: () => _modalCallback(
                  context,
                  type: ImagePickerType.gallery,
                ),
              ),
            ),
            const SizedBox(height: 73),
          ],
        ),
      ),
    );
  }

  Future<void> _modalCallback(BuildContext context,
      {required ImagePickerType type}) async {
    if (_imageController.isTakingPicture.value) {
      return;
    }
    await context.router.pop();
    await _imageController.takeImage(
      onSuccessCallback: () => context.router.push(const ImagePreviewRoute()),
      type: type,
    );
  }

  GestureDetector _cameraButton({required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 77,
        height: 77,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.additional1,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 20,
            ),
          ],
        ),
        child: Center(
          child: Obx(
            () {
              if (_imageController.isTakingPicture.value) {
                return const CircularProgressIndicator(color: AppColors.white);
              } else {
                return SvgPicture.asset(AppAssets.cameraIcon);
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/car_data.dart';
import 'package:flutter_carification_app/common/empty_bar.dart';
import 'package:flutter_carification_app/common/image_modal.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/navigation/app_router.gr.dart';
import 'package:flutter_carification_app/pages/camera/image_controller.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_controller.dart';
import 'package:flutter_carification_app/pages/main/ui/prediction_carousel.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_carification_app/utils/constants.dart';
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
  final _galleryController = Get.find<GalleryController>();

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
            const SizedBox(height: topAppbarPadding + 32),
            Expanded(
              flex: 467,
              child: Obx(
                () {
                  final items = _galleryController.lastPredictions.values
                      .toList();
                  if (items.isNotEmpty) {
                    return _carouselPreview(items);
                  } else {
                    return const EmptyBar(
                      text: 'Вы еще не загрузили ни одной фотографии',
                    );
                  }
                },
              ),
            ),
            const Spacer(flex: 82),
            _cameraButton(
              onTap: () => ImageMenus().show(
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

  Widget _carouselPreview(List<CarData> items) {
    return Column(
      children: [
        Expanded(
          child: PredictionsCarousel(
            items: items.reversed.toList(),
            likeCallback: _galleryController.onLikeTap,
            slideCallback: _galleryController.onSlide,
            controller: _galleryController.carouselController,
          ),
        ),
        const SizedBox(height: 16),
        CarouselIndicator(
          height: 4,
          count: _galleryController.lastPredictions.length,
          color: AppColors.grey,
          activeColor: AppColors.additional1,
          index: _galleryController.predictionsIndex.value,
        ),
      ],
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

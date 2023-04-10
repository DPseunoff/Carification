import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_controller.dart';
import 'package:flutter_carification_app/pages/gallery/ui/gallery_scroll_view.dart';
import 'package:flutter_carification_app/utils/constants.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

@RoutePage()
class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final _galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarTitle: 'Gallery',
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: topAppbarPadding),
                    GalleryScrollView(
                      items: _galleryController.gallery.values
                          .toList()
                          .reversed
                          .toList(),
                      upperPadding: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 173,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.white.withOpacity(0),
                        AppColors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

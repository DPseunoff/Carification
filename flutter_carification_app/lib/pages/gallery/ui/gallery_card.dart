import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_controller.dart';
import 'package:flutter_carification_app/pages/gallery/ui/gallery_preview.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_textstyles.dart';

class GalleryCard extends StatefulWidget {
  const GalleryCard({
    Key? key,
    required this.id,
    required this.imageAsset,
    required this.prediction,
  }) : super(key: key);

  final int id;
  final String imageAsset;
  final String prediction;

  @override
  State<GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final res = await Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => GalleryPreview(
              imagePath: widget.imageAsset,
              imagePrediction: widget.prediction,
            ),
          ),
        );
        if (res == true) {
          Get.find<GalleryController>().deleteImage(widget.id);
        }
      },
      child: Hero(
        tag: 'CarHero',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(4, 4),
                blurRadius: 7,
              ),
            ],
            image: DecorationImage(
              image: FileImage(File(widget.imageAsset)),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 45,
              margin: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 14,
              ),
              child: BlurryContainer(
                borderRadius: BorderRadius.circular(10),
                blur: 10,
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Text(
                    widget.prediction,
                    style: AppTextStyles.onBoardingDescription(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

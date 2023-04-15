import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/pages/gallery/gallery_controller.dart';
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
  Offset _tapPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu.builder(
      actions: [
        CupertinoContextMenuAction(
          child: Text(
            'Delete',
            style: AppTextStyles.onBoardingDescription(height: 16, color: Colors.black),
          ),
          onPressed: () async {
            await Get.find<GalleryController>().deleteImage(widget.id);
            await context.router.pop();
          },
        )
      ],
      builder: (context, animation) {
        return Container(
          height: animation.value < CupertinoContextMenu.animationOpensAt
              ? 300
              : 300,
          width: animation.value < CupertinoContextMenu.animationOpensAt
              ? 300
              : 300,
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
        );
      },
    );
  }

  void _showDeleteMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final overlayWidth = overlay?.paintBounds.size.width ?? 0;
    final overlayHeight = overlay?.paintBounds.size.height ?? 0;
    final result = await showMenu(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.additional1,
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 0, 0),
        Rect.fromLTWH(
            overlay?.paintBounds.left ?? 0, 0, overlayWidth, overlayHeight),
      ),
      items: [
        PopupMenuItem(
          value: true,
          child: Text(
            'Delete',
            style: AppTextStyles.onBoardingDescription(height: 16),
          ),
        ),
      ],
    );

    if (result == true) {
      Get.find<GalleryController>().deleteImage(widget.id);
    }
  }
}

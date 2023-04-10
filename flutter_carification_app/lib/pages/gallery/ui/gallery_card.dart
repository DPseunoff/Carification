import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_textstyles.dart';

class GalleryCard extends StatelessWidget {
  const GalleryCard({
    Key? key,
    required this.imageAsset,
    required this.prediction,
  }) : super(key: key);

  final String imageAsset;
  final String prediction;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          image: AssetImage(imageAsset),
          fit: BoxFit.fitWidth,
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
                prediction,
                style: AppTextStyles.onBoardingDescription(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

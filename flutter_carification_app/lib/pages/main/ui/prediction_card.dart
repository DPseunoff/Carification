import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_textstyles.dart';

typedef OnLikeCallback = void Function();

class PredictionCard extends StatelessWidget {
  const PredictionCard({
    Key? key,
    required this.imageAsset,
    required this.prediction,
    required this.liked,
    required this.onLikeCallback,
  }) : super(key: key);
  final String imageAsset;
  final String prediction;
  final bool liked;
  final OnLikeCallback onLikeCallback;

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
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 45,
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: BlurryContainer(
            borderRadius: BorderRadius.circular(10),
            blur: 10,
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  Text(
                    prediction,
                    style: AppTextStyles.onBoardingDescription(height: 16),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onLikeCallback,
                    behavior: HitTestBehavior.translucent,
                    child: SvgPicture.asset(
                      liked
                          ? AppAssets.heartEnabledIcon
                          : AppAssets.heartDisabledIcon,
                      colorFilter: const ColorFilter.mode(
                        AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

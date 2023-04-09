import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_textstyles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.buttonTitle,
    required this.onTap,
    this.padding,
    Key? key,
  }) : super(key: key);

  final String buttonTitle;
  final void Function() onTap;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 53,
        margin: EdgeInsets.symmetric(horizontal: padding ?? 0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: AppTextStyles.button(),
          ),
        ),
      ),
    );
  }
}

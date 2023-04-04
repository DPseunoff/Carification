import 'package:flutter/widgets.dart';

import '../../../utils/app_colors.dart';

class OnBoardingAppBar extends StatelessWidget {
  const OnBoardingAppBar({
    Key? key,
    required this.pageCount,
    required this.currentPageIndex,
    required this.elapsed,
  }) : super(key: key);

  final int pageCount;
  final int currentPageIndex;
  final double elapsed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.5),
          width: 110,
          height: 4,
          child: Stack(
            children: [
              Container(
                width: 110,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.5),
                  color: AppColors.grey,
                ),
              ),
              FractionallySizedBox(
                widthFactor: currentPageIndex < index
                    ? 0
                    : currentPageIndex == index
                        ? elapsed
                        : 1,
                child: Container(
                  width: 110,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.5),
                    color: AppColors.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

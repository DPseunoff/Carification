import 'package:flutter/material.dart';
import 'package:flutter_carification_app/utils/app_colors.dart';
import 'package:flutter_carification_app/utils/app_textstyles.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({
    Key? key,
    required this.body,
    this.appBarAction,
    this.appBarTitle,
    this.bottomNavigationBar,
  }) : super(key: key);

  final Widget body;
  final Widget? appBarAction;
  final String? appBarTitle;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.additional1,
                    AppColors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          if (appBarTitle != null)
            Positioned.fill(
              top: 18,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 52,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      Text(
                        appBarTitle ?? "",
                        style: AppTextStyles.appBar(),
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      appBarAction ?? const SizedBox.shrink(),
                      const SizedBox(width: 21),
                    ],
                  ),
                ),
              ),
            ),
          body,
          if (bottomNavigationBar != null)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: bottomNavigationBar,
              ),
            ),
        ],
      ),
    );
  }
}

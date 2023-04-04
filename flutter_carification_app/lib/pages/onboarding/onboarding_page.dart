import 'package:flutter/material.dart';
import 'package:flutter_carification_app/pages/onboarding/onboarding_controller.dart';
import 'package:flutter_carification_app/pages/onboarding/onboarding_data.dart';
import 'package:flutter_carification_app/pages/onboarding/ui/onboarding_appbar.dart';
import 'package:flutter_carification_app/utils/app_textstyles.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> with OnBoardingData {
  late OnBoardingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(OnBoardingController());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _controller.onWillPop,
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller.pageController,
                  onPageChanged: _controller.onPageChanged,
                  itemBuilder: _pageBackgroundPreview,
                ),
              ),
              Obx(
                () => Positioned.fill(
                  top: MediaQuery.of(context).viewPadding.top,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 52,
                      child: Center(
                        child: OnBoardingAppBar(
                          pageCount: onBoardingData.length,
                          elapsed: _controller.elapsed.value,
                          currentPageIndex: _controller.pageIndex,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _buildGestureAreas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGestureAreas() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: GestureDetector(onTap: _controller.onPageSlideLeft)),
        Expanded(child: GestureDetector(onTap: _controller.onPageSlideRight)),
      ],
    );
  }

  Widget _pageBackgroundPreview(BuildContext context, pageIndex) {
    final asset = onBoardingData[pageIndex].backgroundAsset;
    final title = onBoardingData[pageIndex].title;
    final prefix = onBoardingData[pageIndex].prefixTitle;
    final desc = onBoardingData[pageIndex].description;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              if (prefix != null && title != null) ...[
                Text(
                  prefix,
                  style: AppTextStyles.onBoardingDescription(
                    fontSize: 20,
                    height: 44,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyles.onBoardingTitle(),
                ),
                const SizedBox(height: 30),
              ] else if (title != null) ...[
                Text(
                  title,
                  style: AppTextStyles.onBoardingTitle(
                    fontSize: 36,
                    height: 30,
                  ),
                ),
              ],
              Text(
                desc,
                style: AppTextStyles.onBoardingDescription(
                  fontSize: pageIndex == 1 ? 20 : 16,
                  height: 26,
                ),
              ),
              SizedBox(height: pageIndex == 1 ? 120 : 97),
            ],
          ),
        ),
      ],
    );
  }
}

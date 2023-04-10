import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/navigation/app_router.gr.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_colors.dart';

@RoutePage()
class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({Key? key}) : super(key: key);

  @override
  State<HomeNavigationPage> createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends State<HomeNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        MainRoute(),
        GalleryRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return PageTemplate(
          body: child,
          bottomNavigationBar: _bottomNavigationBar(tabsRouter),
        );
      },
    );
  }

  Widget _bottomNavigationBar(TabsRouter tabsRouter) {
    return SizedBox(
      height: 73,
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            const SizedBox(width: 63),
            GestureDetector(
              onTap: () => tabsRouter.setActiveIndex(0),
              child: SvgPicture.asset(
                AppAssets.mainIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.primary.withOpacity(
                    tabsRouter.activeIndex == 0 ? 1 : 0.5,
                  ),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => tabsRouter.setActiveIndex(1),
              child: SvgPicture.asset(
                AppAssets.galleryIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.primary.withOpacity(
                    tabsRouter.activeIndex == 1 ? 1 : 0.5,
                  ),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 63),
          ],
        ),
      ),
    );
  }
}

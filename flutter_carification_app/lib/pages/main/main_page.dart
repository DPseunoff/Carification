import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/navigation/app_router.gr.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarTitle: 'Predictions',
      appBarAction: GestureDetector(
        onTap: () => context.router.push(const InfoRoute()),
        child: SvgPicture.asset(AppAssets.infoIcon),
      ),
      body: Container(),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarTitle: 'Information',
      appBarAction: GestureDetector(
        onTap: () => context.router.pop(),
        child: SvgPicture.asset(AppAssets.exitIcon),
      ),
      body: Container(),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/common/page_template.dart';
import 'package:flutter_carification_app/utils/app_assets.dart';
import 'package:flutter_carification_app/utils/app_textstyles.dart';
import 'package:flutter_carification_app/utils/constants.dart';
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
      body: Positioned.fill(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8.5 + topAppbarPadding),
              BlurryContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 35,
                ),
                blur: 10,
                width: MediaQuery.of(context).size.width - 30,
                color: Colors.black.withOpacity(0.3),
                child: Text(
                  '//nfsfg\nfsdfsd\nsdfgsfdg\nsdfgs\nfsdfsdfdsf\ndf\n\n\nsdfsdfdsfdfg\nsdfgsdfg',
                  style: AppTextStyles.appBar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

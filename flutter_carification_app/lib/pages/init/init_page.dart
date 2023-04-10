import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carification_app/navigation/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import '../../utils/constants.dart';

@RoutePage()
class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> with AfterLayoutMixin<InitPage> {
  final _q = UniqueKey();

  Future<void> _checkSeenOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    final seenOnBoarding = prefs.getBool(seenOnBoardingKey) ?? false;
    if (seenOnBoarding) {
      await context.router.replaceAll([const HomeNavigationRoute()]);
    } else {
      await context.router.replaceAll([const OnBoardingRoute()]);
    }
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async =>
      _checkSeenOnBoarding();

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: _q,
    );
  }
}

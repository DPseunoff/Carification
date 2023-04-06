import 'package:auto_route/auto_route.dart';
import 'package:flutter_carification_app/navigation/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: MainNavigationRoute.page,
      children: [
        AutoRoute(
          path: 'main',
          page: MainRoute.page,
        ),
        AutoRoute(
          path: 'gallery',
          page: GalleryRoute.page,
        ),
      ],
    ),
    AutoRoute(
      path: '/info',
      page: InfoRoute.page,
    ),
  ];
}

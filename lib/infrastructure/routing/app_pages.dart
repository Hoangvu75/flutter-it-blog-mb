import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../presentation/sign_in/sign_in.page.dart';
import '../../presentation/splash/splash.page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final navKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navKey,
    routes: <RouteBase>[
      _normalRoute(path: Routes.SPLASH, page: const SplashPage()),
      _normalRoute(path: Routes.SIGN_IN, page: const SignInPage()),
    ],
  );

  static GoRoute _normalRoute({
    required String path,
    required Widget page,
  }) {
    return GoRoute(
      path: path,
      builder: (c, s) => page,
    );
  }

  static GoRoute _swipeableRoute({
    required String path,
    required Widget page,
  }) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => SwipeablePage(
        builder: (context) {
          context.getSwipeablePageRoute<void>()!
            ..canOnlySwipeFromEdge = true
            ..backGestureDetectionWidth = 70;
          return page;
        },
      ),
    );
  }
}


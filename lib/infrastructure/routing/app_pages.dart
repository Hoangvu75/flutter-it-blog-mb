import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../presentation/create_post/create_post.page.dart';
import '../../presentation/create_profile/create_profile.page.dart';
import '../../presentation/email_sign_in/email_sign_in.page.dart';
import '../../presentation/email_sign_up/email_sign_up.page.dart';
import '../../presentation/follow_others/follow_others.page.dart';
import '../../presentation/main/main.page.dart';
import '../../presentation/other_profile/other_profile.page.dart';
import '../../presentation/pick_topics/pick_topics.page.dart';
import '../../presentation/read_post/read_post.page.dart';
import '../../presentation/sign_in/sign_in.page.dart';
import '../../presentation/splash/splash.page.dart';
import '../../presentation/upload_post/upload_post.page.dart';

part 'app_routes.dart';

final navContext = AppPages.navKey.currentContext;

class AppPages {
  AppPages._();
  static final navKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navKey,
    routes: [
      _normalRoute(path: Routes.SPLASH, page: const SplashPage()),
      _normalRoute(path: Routes.SIGN_IN, page: const SignInPage()),
      _swipeableRoute(path: Routes.EMAIL_SIGN_UP, page: const EmailSignUpPage()),
      _swipeableRoute(path: Routes.EMAIL_SIGN_IN, page: const EmailSignInPage()),
      _normalRoute(path: Routes.CREATE_PROFILE, page: const CreateProfilePage()),
      _normalRoute(path: Routes.PICK_TOPICS, page: const PickTopicsPage()),
      _normalRoute(path: Routes.FOLLOW_OTHERS, page: const FollowOthers()),
      _normalRoute(path: Routes.MAIN, page: MainPage()),
      _swipeableRoute(path: Routes.CREATE_POST, page: const CreatePostPage()),
      _swipeableRoute(path: Routes.UPLOAD_POST, page: const UploadPostPage()),
      _swipeableRoute(path: Routes.READ_POST, page: const ReadPostPage()),
      _swipeableRoute(path: Routes.OTHER_PROFILE, page: const OtherProfilePage())
    ],
  );

  static GoRoute _normalRoute({
    required String path,
    required Widget page,
  }) {
    return GoRoute(
      path: path,
      builder: (context, state) => page,
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


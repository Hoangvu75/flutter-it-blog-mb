part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const SIGN_IN = _Paths.SIGN_IN;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/';
  static const SIGN_IN = '/sign-in';
}

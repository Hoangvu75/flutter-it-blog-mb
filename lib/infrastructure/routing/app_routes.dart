part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const EMAIL_SIGN_UP = _Paths.EMAIL_SIGN_UP;
  static const EMAIL_SIGN_IN = _Paths.EMAIL_SIGN_IN;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/';
  static const SIGN_IN = '/sign-in';
  static const EMAIL_SIGN_UP = '/email-sign-up';
  static const EMAIL_SIGN_IN = '/email-sign-in';
}

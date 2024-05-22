part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const EMAIL_SIGN_UP = _Paths.EMAIL_SIGN_UP;
  static const EMAIL_SIGN_IN = _Paths.EMAIL_SIGN_IN;
  static const CREATE_PROFILE = _Paths.CREATE_PROFILE;
  static const PICK_TOPICS = _Paths.PICK_TOPICS;
  static const FOLLOW_OTHERS = _Paths.FOLLOW_OTHERS;
  static const MAIN = _Paths.MAIN;
  static const CREATE_POST = _Paths.CREATE_POST;
  static const UPLOAD_POST = _Paths.UPLOAD_POST;
  static const READ_POST = _Paths.READ_POST;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/';
  static const SIGN_IN = '/sign-in';
  static const EMAIL_SIGN_UP = '/email-sign-up';
  static const EMAIL_SIGN_IN = '/email-sign-in';
  static const CREATE_PROFILE = '/create-profile';
  static const PICK_TOPICS = '/pick-topic';
  static const FOLLOW_OTHERS = '/follow-others';
  static const MAIN = '/main';
  static const CREATE_POST = '/create-post';
  static const UPLOAD_POST = '/upload-post';
  static const READ_POST = '/read-post';
}

// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SIGNUP = _Paths.SIGNUP;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const OTP_SCREEN = _Paths.OTP_SCREEN;
  static const SETTINGS_SCREEN = _Paths.SETTINGS_SCREEN;
  static const PROFILE_SCREEN = _Paths.PROFILE_SCREEN;
  static const ACCOUNT_SCREEN = _Paths.ACCOUNT_SCREEN;
  static const HELP_SCREEN = _Paths.HELP_SCREEN;
  static const TERMS_AND_CONDITIONS_SCREEN = _Paths.TERMS_AND_CONDITIONS_SCREEN;
  static const PRIVACY_POLICY_SCREEN = _Paths.PRIVACY_POLICY_SCREEN;
  static const APP_INFO_SCREEN = _Paths.APP_INFO_SCREEN;

  ///Requires as argumets:
  ///[videoFile] & [sendVideoFunction]
  static const PICKED_VIDEO_SCREEN = _Paths.PICKED_VIDEO_SCREEN;

  ///Requires as argumets:
  /// [VideoMessage] & [VideoPlayerController] for the video
  static const VIDEO_VIEWER_SCREEN = _Paths.VIDEO_VIEWER_SCREEN;

  ///Requires: [Chat] as arguments
  static const CHAT_SCREEN = _Paths.CHAT_SCREEN;

  /// Arguments: chat object as arguments
  static const CHAT_DETAILS_SCREEN = _Paths.CHAT_DETAILS_SCREEN;

  static const SELECT_NEW_GROUP_MEMBERS = _Paths.SELECT_NEW_GROUP_MEMBERS;

  static const QR_CODE_SCREEN = _Paths.QR_CODE_SCREEN;

  /// Arguments:
  /// ```dart
  ///  List<User> selectedUsers
  /// ```
  static const NEW_GROUP_DETAILS = _Paths.NEW_GROUP_DETAILS;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const QR_CODE_SCREEN = '/Qr-code-screen';
  static const SIGNUP = '/SIGNUP';
  static const SIGN_IN = '/SIGN_IN';
  static const OTP_SCREEN = '/otp-screen';
  static const CHAT_SCREEN = '/chat-screen';
  static const VIDEO_VIEWER_SCREEN = '/video-viewer-screen';
  static const SETTINGS_SCREEN = '/Settings-screen';
  static const PROFILE_SCREEN = '/Profile-screen';
  static const ACCOUNT_SCREEN = '/Account-screen';
  static const HELP_SCREEN = '/Help-screen';
  static const PICKED_VIDEO_SCREEN = '/Picked-video-screen';
  static const TERMS_AND_CONDITIONS_SCREEN = '/Terms-And-Conditions-screen';
  static const PRIVACY_POLICY_SCREEN = '/Privacy-policy-screen';
  static const APP_INFO_SCREEN = '/App-Info-screen';
  static const CHAT_DETAILS_SCREEN = '/user-details';
  static const SELECT_NEW_GROUP_MEMBERS = '/add-new-group';
  static const NEW_GROUP_DETAILS = '/new-group-details';
}

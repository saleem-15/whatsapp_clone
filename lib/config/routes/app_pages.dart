import 'package:get/get.dart';
import 'package:whatsapp_clone/app/modules/add_new_group/views/group_details_screen.dart';

import '../../app/modules/add_new_group/views/select_group_members_screen.dart';
import '../../app/modules/auth/screens/otp_screen.dart';
import '../../app/modules/auth/screens/signin_screen.dart';
import '../../app/modules/auth/screens/signup_screen.dart';
import '../../app/modules/chat/screens/chat_screen.dart';
import '../../app/modules/home/views/home_screen.dart';
import '../../app/modules/settings/screens/account_screen.dart';
import '../../app/modules/settings/screens/app_info_screen.dart';
import '../../app/modules/settings/screens/help_screen.dart';
import '../../app/modules/settings/screens/privacy_policy_screen.dart';
import '../../app/modules/settings/screens/profile_screen.dart';
import '../../app/modules/settings/screens/qr_screen.dart';
import '../../app/modules/settings/screens/settings_screen.dart';
import '../../app/modules/settings/screens/terms_screen.dart';
import '../../app/modules/user_details/views/user_details_screen.dart';
import '../../app/modules/video/screens/picked_video_viewer.dart';
import '../../app/modules/video/screens/video_viewer_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SigninScreen(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: _Paths.OTP_SCREEN,
      page: () => OTPScreen(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => ChatScreen(),
    ),
    GetPage(
      name: _Paths.VIDEO_VIEWER_SCREEN,
      page: () => VideoViewerScreen(),
    ),
    GetPage(
      name: _Paths.SETTINGS_SCREEN,
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SCREEN,
      page: () => AccountScreen(),
    ),
    GetPage(
      name: _Paths.HELP_SCREEN,
      page: () => HelpScreen(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS_SCREEN,
      page: () => const TermsAndCondiotnsScreen(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY_SCREEN,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: _Paths.APP_INFO_SCREEN,
      page: () => const AppInfoScreen(),
    ),
    GetPage(
      name: _Paths.QR_CODE_SCREEN,
      page: () => QRCodeScreen(),
    ),
    GetPage(
      name: _Paths.CHAT_DETAILS_SCREEN,
      page: () => ChatDetailsScreen(),
    ),
    GetPage(
      name: _Paths.SELECT_NEW_GROUP_MEMBERS,
      page: () => SelectNewGroupMembersScreen(),
    ),
    GetPage(
      name: _Paths.NEW_GROUP_DETAILS,
      page: () => GroupDetailsScreen(),
    ),
    GetPage(
      name: _Paths.PICKED_VIDEO_SCREEN,
      page: () => PickedVideoScreen(),
    ),
  ];
}

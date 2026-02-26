
import 'package:charteur/features/views/admin/home/view_models/home_bindings.dart';
import 'package:charteur/features/views/admin/home/views/admin_home/admin_home_screen.dart';
import 'package:charteur/features/views/admin/home/views/assign_task/assign_task_screen.dart';
import 'package:charteur/features/views/admin/home/views/collaborator_details/collaborator_details_screen.dart';
import 'package:charteur/features/views/admin/home/views/site_details/site_details_screen.dart';
import 'package:charteur/features/views/auth/view_models/auth_bindings.dart';
import 'package:charteur/features/views/common/sites/view_models/sites_bindings.dart';
import 'package:charteur/features/views/common/sites/views/file_add_screen.dart';
import 'package:get/get.dart';

import 'package:charteur/features/views/admin/subscription/subscription_screen.dart';
import 'package:charteur/features/views/auth/views/change%20password/change_password.dart';
import 'package:charteur/features/views/auth/views/forget/forget_screen.dart';
import 'package:charteur/features/views/auth/views/login/log_in_screen.dart';
import 'package:charteur/features/views/auth/views/otp/otp_screen.dart';
import 'package:charteur/features/views/auth/views/reset_pass/reset_password_screen.dart';
import 'package:charteur/features/views/auth/views/sign_up/sign_up_screen.dart';
import 'package:charteur/features/views/common/notifications/notifications_screen.dart';
import 'package:charteur/features/views/common/setting/about_screen.dart';
import 'package:charteur/features/views/common/setting/change%20password/setting_change_password.dart';
import 'package:charteur/features/views/common/setting/language_screen.dart';
import 'package:charteur/features/views/common/setting/privacy_policy_screen.dart';
import 'package:charteur/features/views/common/setting/setting_screen.dart';
import 'package:charteur/features/views/common/setting/support_screen.dart';
import 'package:charteur/features/views/common/setting/terms_screen.dart';

import 'package:charteur/features/views/common/sites/views/files_screen.dart';
import 'package:charteur/features/views/common/sites/views/site_add_screen.dart';
import 'package:charteur/features/views/bottom_nav/bottom_nav.dart';
import 'package:charteur/features/views/common/profile/profile_screen.dart';
import 'package:charteur/features/views/common/sites/views/sites_screen.dart';
import 'package:charteur/features/views/splash_onboarding/onboarding_screen.dart';
import 'package:charteur/features/views/splash_onboarding/role_screen.dart';
import 'package:charteur/features/views/splash_onboarding/splash_screen.dart';

import 'app_router.dart';


class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.adminHome,
      page: () => const AdminHomeScreen(),
      transition: Transition.noTransition,
      binding: HomeBinding()
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.role,
      page: () => const RoleScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),

    // ── Auth ─────────────────────────────────────────────
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.forget,
      page: () => const ForgetScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),

    // ── Main ─────────────────────────────────────────────
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => const BottomNavScreen(),
      transition: Transition.noTransition,
    ),

    // ── Sites ─────────────────────────────────────────────
    GetPage(
      name: AppRoutes.sites,
      page: () => const SitesScreen(),
      transition: Transition.noTransition,
      binding: SitesBinding(),
    ),
    GetPage(
      name: AppRoutes.siteAdd,
      page: () => const SiteAddScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.siteDetails,
      page: () => const SiteDetailsScreen(),
      transition: Transition.noTransition,
    ),

    // ── Files ─────────────────────────────────────────────
    GetPage(
      name: AppRoutes.files,
      page: () => const FilesScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.fileAdd,
      page: () => const FileAddScreen(),
      transition: Transition.noTransition,
    ),

    // ── Task ──────────────────────────────────────────────
    GetPage(
      name: AppRoutes.task,
      page: () => const TaskScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.collaboratorDetails,
      page: () => const CollaboratorDetailsScreen(),
      transition: Transition.noTransition,
    ),

    // ── Notifications ─────────────────────────────────────
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      transition: Transition.noTransition,
    ),

    // ── Profile ───────────────────────────────────────────
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      transition: Transition.noTransition,
    ),

    // ── Setting ───────────────────────────────────────────
    GetPage(
      name: AppRoutes.setting,
      page: () => const SettingScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.settingChangePassword,
      page: () => const SettingChangePasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.language,
      page: () => const LanguageScreen(),
      transition: Transition.noTransition,
    ),

    // ── Static / Info ─────────────────────────────────────
    GetPage(
      name: AppRoutes.subscription,
      page: () => const SubscriptionScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.terms,
      page: () => const TermsScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.support,
      page: () => const SupportScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
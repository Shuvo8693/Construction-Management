import 'package:auto_route/auto_route.dart';
import 'package:charteur/features/views/admin/home/admin_home_screen.dart';
import 'package:charteur/features/views/admin/home/assign_task_screen.dart';
import 'package:charteur/features/views/admin/home/collaborator_details_screen.dart';
import 'package:charteur/features/views/admin/home/site_details_screen.dart';
import 'package:charteur/features/views/admin/subscription/subscription_screen.dart';
import 'package:charteur/features/views/common/notifications/notifications_screen.dart';
import 'package:charteur/features/views/common/setting/about_screen.dart';
import 'package:charteur/features/views/common/setting/change%20password/setting_change_password.dart';
import 'package:charteur/features/views/common/setting/language_screen.dart';
import 'package:charteur/features/views/common/setting/privacy_policy_screen.dart';
import 'package:charteur/features/views/common/setting/setting_screen.dart';
import 'package:charteur/features/views/common/setting/support_screen.dart';
import 'package:charteur/features/views/common/setting/terms_screen.dart';
import 'package:charteur/features/views/common/sites/file_add_screen.dart';
import 'package:charteur/features/views/common/sites/files_screen.dart';
import 'package:charteur/features/views/common/sites/site_add_screen.dart';
import 'package:charteur/features/views/auth/change%20password/change_password.dart';
import 'package:charteur/features/views/auth/forget/forget_screen.dart';
import 'package:charteur/features/views/auth/login/log_in_screen.dart';
import 'package:charteur/features/views/auth/otp/otp_screen.dart';
import 'package:charteur/features/views/auth/reset_pass/reset_password_screen.dart';
import 'package:charteur/features/views/auth/sign_up/sign_up_screen.dart';
import 'package:charteur/features/views/bottom_nav/bottom_nav.dart';
import 'package:charteur/features/views/common/profile/profile_screen.dart';
import 'package:charteur/features/views/common/sites/sites_screen.dart';
import 'package:charteur/features/views/splash_onboarding/onboarding_screen.dart';
import 'package:charteur/features/views/splash_onboarding/role_screen.dart';
import 'package:charteur/features/views/splash_onboarding/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
   //AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: SplashRoute.page),
    AutoRoute(page: AdminHomeRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: RoleRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: ForgetRoute.page),
    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: BottomNavRoute.page,initial: true),
    AutoRoute(page: SiteAddRoute.page),
    AutoRoute(page: NotificationsRoute.page),
    AutoRoute(page: SubscriptionRoute.page),
    AutoRoute(page: SettingRoute.page),
    AutoRoute(page: AboutRoute.page),
    AutoRoute(page: TermsRoute.page),
    AutoRoute(page: PrivacyPolicyRoute.page),
    AutoRoute(page: SupportRoute.page),
    AutoRoute(page: SettingChangePasswordRoute.page),
    AutoRoute(page: LanguageRoute.page),
    AutoRoute(page: FileAddRoute.page),
    AutoRoute(page: FilesRoute.page),
    AutoRoute(page: TaskRoute.page),
    AutoRoute(page: CollaboratorDetailsRoute.page),
    AutoRoute(page: SiteDetailsRoute.page),
  ];
}
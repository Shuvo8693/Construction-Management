import 'package:auto_route/auto_route.dart';
import 'package:charteur/features/views/auth/change%20password/change_password.dart';
import 'package:charteur/features/views/auth/forget/forget_screen.dart';
import 'package:charteur/features/views/auth/login/log_in_screen.dart';
import 'package:charteur/features/views/auth/otp/otp_screen.dart';
import 'package:charteur/features/views/auth/reset_pass/reset_password_screen.dart';
import 'package:charteur/features/views/auth/sign_up/sign_up_screen.dart';
import 'package:charteur/features/views/splash_onboarding/onboarding_screen.dart';
import 'package:charteur/features/views/splash_onboarding/role_screen.dart';
import 'package:charteur/features/views/splash_onboarding/splash_screen.dart';
import 'package:charteur/features/views/user/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: RoleRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: ForgetRoute.page),
    AutoRoute(page: ChangePasswordRoute.page),
  ];
}
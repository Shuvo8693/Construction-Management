import 'package:auto_route/auto_route.dart';
import 'package:charteur/features/views/splash_onboarding/splash_screen.dart';
import 'package:charteur/features/views/user/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
  ];
}
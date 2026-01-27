import 'package:charteur/core/provider/provider_config.dart';
import 'package:charteur/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (_,__) {
        return MultiProvider(
          providers: ProviderConfig.providers,
          child: MaterialApp.router(
            theme: AppThemeData.lightThemeData,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            title: 'charteur',
            routerConfig: appRouter.config(),
          ),
        );
      }
    );
  }
}


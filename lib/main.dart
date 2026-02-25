import 'package:charteur/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/router/app_router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          theme: AppThemeData.lightThemeData,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          title: 'charteur',
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
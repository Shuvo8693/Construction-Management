import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/features/views/splash_onboarding/widgets/circle_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF117C6F),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(),
          Center(child: Assets.icons.slpashLogo.svg(height: 44.h, width: 299.w)),
          CircleLoader(),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/config/app_constants.dart';
import 'package:charteur/core/helpers/prefs_helper.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/widgets/jwt_decoder/payload_value.dart';
import 'package:charteur/features/views/splash_onboarding/widgets/circle_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    navigateToNextScreen();
    super.initState();
  }

  void navigateToNextScreen() async {
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    await Future.delayed(const Duration(seconds: 3));
    if(!mounted) return;
    if ( token.isNotEmpty) {
      final value = await getPayloadValue();
      String role = value['role']??'';
      Get.offAllNamed(AppRoutes.adminHome);
    }else{
      Get.offNamed(AppRoutes.onboarding);
    }
  }

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

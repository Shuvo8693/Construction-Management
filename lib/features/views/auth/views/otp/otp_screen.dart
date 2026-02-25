import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


@RoutePage()
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key,});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),

            AuthTitleWidgets(title: 'Enter verification Code',
            subtitle: 'Please enter the 6-digit verification code sent to your email'),
            SizedBox(height: 50.h),

            ///==============Pin code Field============<>>>>

            Form(
              key: _globalKey,
              child: CustomPinCodeTextField(
                  textEditingController: otpController),
            ),

            SizedBox(height: 24.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: CustomText(
                  textAlign: TextAlign.start,
                  text: 'Didn’t get the code?',)),
                InkWell(
                  onTap: () {
                    // Resend OTP logic here
                  },
                  child: CustomText(
                    textAlign: TextAlign.end,
                    text: 'Resend',
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),                ),

              ],
            ),

            SizedBox(height: 36.h),
            CustomButton(
              label: "Verify",
              onPressed: _onTapNextScreen,
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }

  void _onTapNextScreen()async {
    if (_globalKey.currentState!.validate()) return;
    Get.toNamed(AppRoutes.resetPassword);
  }
}

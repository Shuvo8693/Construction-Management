import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
      appBar: const CustomAppBar(title: 'Verify'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h),

            AuthTitleWidgets(title: 'Please enter the verification code sent to your e-mail'),
            SizedBox(height: 44.h),

            ///==============Pin code Field============<>>>>

            Form(
              key: _globalKey,
              child: CustomPinCodeTextField(
                  textEditingController: otpController),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: CustomText(
                  textAlign: TextAlign.start,
                  text: 'Didn’t get the code?',top: 10.h,)),

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
    if (!_globalKey.currentState!.validate()) return;

  }
}

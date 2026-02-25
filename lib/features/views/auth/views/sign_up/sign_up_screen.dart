import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/auth/view_models/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 final  _authController = Get.find<AuthController>();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 44.h),
              AuthTitleWidgets(),
              SizedBox(height: 82.h),
              CustomTextField(
                prefixIcon: Assets.icons.person.svg(),
                controller: _authController.nameCtrl,
                hintText: "Name",
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                prefixIcon: Assets.icons.phone.svg(),
                controller: _authController.phoneNumberCtrl,
                hintText: "number",
                keyboardType: TextInputType.number,
              ),

              CustomTextField(
                prefixIcon: Assets.icons.email.svg(),
                controller: _authController.emailCtrl,
                hintText: "E-mail",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),


              CustomTextField(
               prefixIcon: Assets.icons.lock.svg(),
                controller: _authController.passCtrl,
                hintText: "Password",
                isPassword: true,
              ),
              CustomTextField(
                prefixIcon: Assets.icons.lock.svg(),
                controller: _authController.confirmPassCtrl,
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != _authController.passCtrl.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 36.h),
              Obx(()=>
                 CustomButton(
                  isLoading: _authController.isLoading.value,
                  label: "Sign Up", onPressed: _onSignUp,
                ),
              ),
              SizedBox(height: 18.h),

              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.appGreyColor,
                    fontSize: 14.sp,
                  ),
                  text: "Already have an account? ",
                  children: [
                    TextSpan(
                      style: TextStyle(color: AppColors.primaryColor),
                      text: ' Sign In',
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                        Get.toNamed(AppRoutes.login);
                            },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUp() async {
    if (!_globalKey.currentState!.validate()) return;
    await _authController.register();
  }
}

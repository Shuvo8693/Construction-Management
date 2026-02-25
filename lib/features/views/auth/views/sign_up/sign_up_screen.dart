import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                controller: nameController,
                hintText: "Name",
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                prefixIcon: Assets.icons.phone.svg(),
                controller: numberController,
                hintText: "number",
                keyboardType: TextInputType.number,
              ),

              CustomTextField(
                prefixIcon: Assets.icons.email.svg(),
                controller: emailController,
                hintText: "E-mail",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),


              CustomTextField(
               prefixIcon: Assets.icons.lock.svg(),
                controller: passwordController,
                hintText: "Password",
                isPassword: true,
              ),
              CustomTextField(
                prefixIcon: Assets.icons.lock.svg(),
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 36.h),
              CustomButton(
                label: "Sign Up", onPressed: _onSignUp,
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
                        context.router.pop();
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

  void _onSignUp() {
    if (!_globalKey.currentState!.validate()) return;

  }
}

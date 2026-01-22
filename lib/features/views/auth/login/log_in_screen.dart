import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Sign In'),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              SizedBox(height: 24.h),
              AuthTitleWidgets(
                title: 'Make sure that you already have an account.',
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                //prefixIcon: Assets.icons.email.svg(),
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),

              CustomTextField(
                //prefixIcon: Assets.icons.password.svg(),
                controller: passwordController,
                hintText: "Password",
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                  },
                  child: CustomText(text: "Forgot Password",decoration: TextDecoration.underline,),
                ),
              ),
              SizedBox(height: 111.h),
              CustomButton(label: "Sign In", onPressed: _onLogin),
              SizedBox(height: 18.h),
              RichText(text: TextSpan(
                style: TextStyle(
                  color: AppColors.appGreyColor,
                  fontSize: 14.sp
                ),
                text: "Don't have an account?",
                children: [
                  TextSpan(
                      style: TextStyle(
                          color: AppColors.primaryColor,
                      ),
                      text: ' Sign Up',
                      recognizer: TapGestureRecognizer()..onTap = (){

                      }
                  )
                ]
              )),
              SizedBox(height: 16.h),

            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    if (!_globalKey.currentState!.validate()) return;
  }
}

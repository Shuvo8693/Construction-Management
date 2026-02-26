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
import 'package:get/get_navigation/src/extension_navigation.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            children: [
              SizedBox(height: 100.h),
              AuthTitleWidgets(),
              SizedBox(height: 82.h),
              CustomTextField(
                prefixIcon: Assets.icons.email.svg(),
                controller: _authController.emailCtrl,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),

              CustomTextField(
                prefixIcon: Assets.icons.lock.svg(),
                controller: _authController.passCtrl,
                hintText: "Password",
                isPassword: true,
                validator: (value){
                  if(value!.isEmpty){
                    return "Password is required";
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.forget);
                  },
                  child: CustomText(text: "Forgot Password",decoration: TextDecoration.underline,),
                ),
              ),
              SizedBox(height: 32.h),
              Obx(()=> CustomButton(isLoading: _authController.isLoading.value,label: "Sign In", onPressed: _onLogin)),
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
                        Get.toNamed(AppRoutes.signUp);
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

  void _onLogin() async{
    if (!_globalKey.currentState!.validate()) return;
   await _authController.login();
  }
}

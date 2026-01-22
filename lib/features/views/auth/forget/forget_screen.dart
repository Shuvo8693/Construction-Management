import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


@RoutePage()
class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Forget Password'),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              AuthTitleWidgets(title: 'Please enter your email to reset your password.'),
              SizedBox(height: 56.h),
              CustomTextField(
                autofocus: true,
                controller: emailController,
                hintText: "Email",
                isEmail: true,
              ),
              SizedBox(height: 44.h),
              CustomButton(
                label: "Get Verification Code",
                onPressed: _onGetVerificationCode,
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }


  void _onGetVerificationCode(){
    if(!_globalKey.currentState!.validate()) return;
  }


}

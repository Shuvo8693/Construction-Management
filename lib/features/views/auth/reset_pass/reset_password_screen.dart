import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();


  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              AuthTitleWidgets(),
              SizedBox(height: 70.h),
        
              CustomTextField(
                prefixIcon: Assets.icons.lock.svg(),
                controller: passController,
                hintText: "New Password",
                isPassword: true,
              ),

              CustomTextField(
                prefixIcon: Assets.icons.lock.svg(),
                controller: confirmPassController,
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != passController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
        
        
              SizedBox(height: 36.h),
            CustomButton(
              label: "Reset",
              onPressed: _onResetPassword,
            ),
              SizedBox(height: 18.h),
        
            ],
          ),
        ),
      ),
    );
  }



  void _onResetPassword()async{
    if(!_globalKey.currentState!.validate()) return;
    context.router.popUntilRoot();
  }

}

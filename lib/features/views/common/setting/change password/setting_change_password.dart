import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



@RoutePage()
class SettingChangePasswordScreen extends StatefulWidget {
  const SettingChangePasswordScreen({super.key});

  @override
  State<SettingChangePasswordScreen> createState() => _SettingChangePasswordScreenState();
}

class _SettingChangePasswordScreenState extends State<SettingChangePasswordScreen> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _oldPassTEController = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Change Password',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            spacing: 10.h,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              CustomTextField(
                labelText: 'Old Password',
                controller: _oldPassTEController,
                hintText: "Old Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required ';
                  } else if ( _oldPassTEController.text.length < 8) {
                    return 'Password must be 8+ chars';
                  }
                  return null;
                },
              ),
              CustomTextField(
                labelText: 'New Password',
                controller: _newPassword,
                hintText: "New Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (_newPassword.text.length < 8) {
                    return 'Password must be 8+ chars';
                  }
                  return null;
                },
              ),
              CustomTextField(
                labelText: 'Confirm Password',
                controller: _confirmPassword,
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != _confirmPassword.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              SizedBox(height: 32.h,),
              CustomButton(
                label: "Update",
                onPressed: _onChangePassword,
              ),
              SizedBox(
                height:32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _onChangePassword(){
    if(!_globalKey.currentState!.validate()) return;
  }
}

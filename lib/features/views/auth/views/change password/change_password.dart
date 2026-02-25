import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:charteur/core/widgets/widgets.dart';


@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPassTEController = TextEditingController();
  final TextEditingController passTEController = TextEditingController();
  final TextEditingController rePassTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Change Password'),
      body: Form(
        key: _globalKey,
        child: Column(
          spacing: 10.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
            ),
            CustomTextField(
              controller: oldPassTEController,
              hintText: "Old Password",
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (oldPassTEController.text.length < 8) {
                  return 'Password must be 8+ chars';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: passTEController,
              hintText: "New Password",
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (passTEController.text.length < 8) {
                  return 'Password must be 8+ chars';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: rePassTEController,
              hintText: "Confirm Password",
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm password is required';
                } else if (value != passTEController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const Spacer(),
            CustomButton(
              label: "Change Password",
              onPressed: _onChangePassword,
            ),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }

  void _onChangePassword() {
    if (!_globalKey.currentState!.validate()) return;
  }
}

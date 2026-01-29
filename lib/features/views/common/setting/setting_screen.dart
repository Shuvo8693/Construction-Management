import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/setting/widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(
        title: 'Settings'),
      body: Column(
        children: [
          SizedBox(height: 32.h),


          ProfileListTile(
            icon: Assets.icons.password.svg(),
            title: 'Change Password',
            onTap: () {
            },
          ),



          ProfileListTile(
            icon: Assets.icons.terms.svg(),
            title: 'Terms & Condition',
            onTap: () {
              Get.toNamed(AppRoutes.termsScreen);
            },
          ),



          ProfileListTile(
            icon: Assets.icons.policy.svg(),
            title: 'Privacy Policy',
            onTap: () {
              Get.toNamed(AppRoutes.policyScreen);
            },
          ),



          ProfileListTile(
            icon: Assets.icons.about.svg(),
            title: 'About Us',
            onTap: () {
              Get.toNamed(AppRoutes.aboutScreen);
            },
          ),




          Spacer(),
          ProfileListTile(
            textColor: AppColors.errorColor,
            color:  AppColors.errorColor,
            icon: Assets.icons.delete.svg(),
            title: 'Delete Account',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  title: "Do you want to delete your account?",
                  confirmButtonText: 'Delete',
                  confirmButtonColor: AppColors.errorColor,
                  onCancel: () {
                  },
                  onConfirm: () {
                    //Get.offAllNamed(AppRoutes.signUpScreen);
                  },
                ),
              );
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

}

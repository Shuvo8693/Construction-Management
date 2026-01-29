import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/setting/widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


@RoutePage()
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
          SizedBox(height: 16.h),


          CustomContainer(
            marginAll: 16.r,
            paddingVertical: 10.h,
            radiusAll: 8.r,
            color: Colors.white,
            child: Column(
              children: [
                ProfileListTile(
                  icon: Assets.icons.lock.svg(),
                  title: 'Change Password',
                  onTap: () {
                    context.router.push(const SettingChangePasswordRoute());
                  },
                ),



                ProfileListTile(
                  icon: Assets.icons.terms.svg(),
                  title: 'Terms & Condition',
                  onTap: () {
                    context.router.push(const TermsRoute());
                  },
                ),



                ProfileListTile(
                  icon: Assets.icons.privacy.svg(),
                  title: 'Privacy Policy',
                  onTap: () {
                    context.router.push(const PrivacyPolicyRoute());
                  },
                ),



                ProfileListTile(
                  icon: Assets.icons.about.svg(),
                  title: 'About Us',
                  onTap: () {
                    context.router.push(const AboutRoute());
                  },
                ),
              ],
            ),
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
          SizedBox(height: 44.h),
        ],
      ),
    );
  }

}

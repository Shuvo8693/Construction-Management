import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/config/app_constants.dart';
import 'package:charteur/core/helpers/prefs_helper.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File?   imageFile;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: BottomNavScreen(menuIndex: 3),
      appBar: CustomAppBar(title: 'Profile'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 28.h),
          CustomImageAvatar(
            fileImage: imageFile,
            onImagePicked: (file) {
              imageFile = File(file.path);
              setState(() {
              });
            },
            showBorder: true,
            image: '',
            radius: 50.r,
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: 'John Doe',
          ),
          CustomText(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
            text: 'Office Admin'
          ),

          SizedBox(height: 24.h),

          CustomContainer(
            paddingAll: 16.r,
            radiusAll: 8.r,
            color: Colors.white,
            child: Column(
              spacing: 12.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               _buildCustomListTile(title: 'Edit Profile', leadingIcon: Assets.icons.profileEdit.svg(), onTap: (){}),
               _buildCustomListTile(title: 'Subscription', leadingIcon: Assets.icons.subscription.svg(), onTap: (){
                 Get.toNamed(AppRoutes.subscription);
               }),
               _buildCustomListTile(title: 'Settings', leadingIcon: Assets.icons.settings.svg(), onTap: (){
                 Get.toNamed(AppRoutes.setting);
               }),
               _buildCustomListTile(title: 'Language', leadingIcon: Assets.icons.language.svg(), onTap: (){
                 Get.toNamed(AppRoutes.language);
               }),



            ]
               ),
          ),

          Spacer(),
          _buildCustomListTile(title: 'Logout', leadingIcon: Assets.icons.logout.svg(),
            color: AppColors.errorColor,
            onTap: () {
            showDialog(
              context: context,
              builder: (context) => CustomDialog(
                title: "Do you want to logout your account?",
                confirmButtonText: 'Logout',
                confirmButtonColor: AppColors.errorColor,
                onCancel: () {
                  Get.back();
                },
                onConfirm: () async{
                 await PrefsHelper.remove(AppConstants.bearerToken);
                  Get.offAllNamed(AppRoutes.login);
                },
              ),
            );
          },
          ),
          SizedBox(height: 90.h),
        ],
      ),
    );
  }

  Widget _buildCustomListTile({required String title, required Widget leadingIcon,required onTap,Color? color}) {
    return CustomContainer(
      paddingLeft: 8.r,
      radiusAll: 12.r,
      bordersColor: color ?? AppColors.primaryColor,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        leading: leadingIcon,
        trailing: Icon(Icons.arrow_right, color: color ?? AppColors.textSecondary,size: 24.r,),
        title: CustomText(
          color: color,
          textAlign: TextAlign.start,
          text: title,
        ),
      ),
    );
  }}
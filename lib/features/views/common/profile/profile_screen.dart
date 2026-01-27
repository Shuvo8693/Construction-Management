import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        titleWidget: CustomListTile(
          contentPaddingHorizontal: 16.w,
          titleFontSize: 14.sp,
          subtitleFontSize: 16.sp,
          titleColor: AppColors.appGreyColor,
          title: 'Welcome back,',
          subTitle: 'Savannah Nguyen',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icons.notification.svg(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          CustomContainer(
            radiusAll: 8.r,
              width: double.infinity,
            paddingAll: 12.r,
            bordersColor: AppColors.primaryColor.withAlpha(102),
            linearColors: [
              Colors.white.withAlpha(0),
              AppColors.primaryColor.withAlpha(102),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Manage Your Construction Projects Effortlessly',
                        color: AppColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 4.h,),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'From interactive site maps to task tracking and PDF plans, streamline construction management with instant updates and secure role-based access.',
                        color: AppColors.appGreyColor,
                        fontSize: 10.sp,
                        bottom: 12.h,
                        top: 6.h,
                      ),
                      CustomButton(
                        width: 186.w,
                        height: 34.h,
                        elevation: true,
                        onPressed: (){
                        },label: 'Get Start',)
                    ],
                  ),
                ),
                Assets.images.getStart.image(width: 120.w, height: 145.h,fit: BoxFit.cover),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
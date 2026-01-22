import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Assets.icons.logo.svg(),
          SizedBox(height: 70.h),
          CustomContainer(
            height: 524.h,
            width: double.infinity,
            linearColors: AppColors.onboardingLinear,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  CustomText(
                    color: AppColors.textSecondary,
                    bottom: 6.h,
                      text: 'Choose Your Role to Get Start'),
                  Divider(
                    endIndent: 44.w,
                    indent: 44.w,
                      color: AppColors.primaryColor.withAlpha(26)),


                  SizedBox(height: 44.h),
                  CustomButton(onPressed: (){},label: 'Collaborator'),

                  CustomText(
                      color: AppColors.textSecondary,
                      bottom: 8.h,
                      top: 8.h,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      text: 'or'),

                  CustomButton(
                    backgroundColor: Colors.transparent,
                      bordersColor: AppColors.primaryColor,
                      foregroundColor: AppColors.textSecondary,
                      onPressed: (){},label: 'Office Admin'),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

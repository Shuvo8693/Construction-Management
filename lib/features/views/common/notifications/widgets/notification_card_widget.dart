import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      marginBottom: 12,
      //paddingAll: 16,
      paddingVertical: 8.h,
      paddingHorizontal: 12.w,
      radiusAll: 8,
      bordersColor: Colors.grey.withAlpha(50),
      child: Row(
        children: [
          CustomContainer(
            width: 40.w,
            height: 40.w,
            radiusAll: 20.w,
            color: AppColors.primaryColor.withAlpha(51),
            child: Icon(
              Icons.notifications_active_outlined,
              color: AppColors.primaryColor,
              size: 24.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  text: 'New Project Assigned',
                ),
                CustomText(
                  maxline: 2,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  text:
                      'You have been assigned to the "Downtown Mall Projects". Please check the details and get started.',
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          CustomText(
            left: 6.w,
              text: '30 Mins ago', fontSize: 10.sp, color: AppColors.textPrimary),
        ],
      ),
    );
  }
}

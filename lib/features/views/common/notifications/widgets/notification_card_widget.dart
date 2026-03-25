import 'package:charteur/core/helpers/time_format.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/notifications/models/notification_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key, required this.notificationData});
  final NotificationData notificationData;

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
                // Type
                CustomText(
                  textAlign: TextAlign.start,
                  text: notificationData.type??'',
                ),
                // Message
                CustomText(
                  maxline: 2,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  text: notificationData.message ?? '',
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          // date time
          CustomText(
            left: 6.w,
              text: TimeFormatHelper.getTimeAgo(DateTime.parse(notificationData.createdAt.toString())), fontSize: 10.sp, color: AppColors.textPrimary),
        ],
      ),
    );
  }
}

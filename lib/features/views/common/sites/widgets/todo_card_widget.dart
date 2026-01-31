import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? projectName;
  final String? assigneeName;
  final String? category;
  final String? status;
  final String? description;
  final Color? statusColor;

  const TodoCardWidget({
    super.key,
    this.imageUrl,
    this.title,
    this.projectName,
    this.assigneeName,
    this.category,
    this.status,
    this.description,
    this.statusColor = Colors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      marginBottom: 12.h,
      paddingAll: 6.r,
      color: Colors.white,
      radiusAll: 4.r,
      bordersColor: AppColors.primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          CustomNetworkImage(
            borderRadius: 4.r,
            imageUrl: imageUrl ?? '',
            width: 83.w,
            height: 120.h,
            fit: BoxFit.cover,
          ),

          SizedBox(width: 12.w),

          // Content Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  text: title ?? 'N/A',
                  maxline: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10.w),
                // Project Name and Assignee Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.start,
                        text: projectName ?? '',
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    CustomText(
                      text: category ?? '',
                      textAlign: TextAlign.end,
                      fontSize: 12.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.start,
                        text: assigneeName ?? '',
                        fontSize: 12.sp,
                      ),
                    ),
                    CustomContainer(
                      paddingVertical: 2.h,
                      paddingHorizontal: 6.w,
                      radiusAll: 4.r,
                      bordersColor: statusColor,
                      child: CustomText(
                        text: status ?? '',
                        textAlign: TextAlign.end,
                        fontSize: 12.sp,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Description
                CustomContainer(
                  paddingVertical: 4.h,
                  paddingHorizontal: 6.w,
                  radiusAll: 4.r,
                  borderWidth: 0.5,
                  width: double.infinity,
                  bordersColor: Color(0xFF92C3BD),
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: description ?? '',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,

                    maxline: 3,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProfileListTile extends StatelessWidget {
  const ProfileListTile(
      {super.key,
      this.color,
      this.textColor,
      this.noIcon,
      required this.title,
      required this.onTap, required this.icon});

  final Color? color;
  final Color? textColor;
  final bool? noIcon;
  final String title;
  final VoidCallback onTap;
   final Widget icon;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      verticalMargin: 7.h,
      horizontalMargin: 24.w,
      paddingHorizontal: 10.w ,
      paddingVertical: 14.h,
     radiusAll: 12.r,
     bordersColor: color ?? AppColors.primaryColor.withOpacity(0.2),
     color:  AppColors.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 12.w),
          Expanded(
            child: CustomText(
              text: title,
              textAlign: TextAlign.start,
              color: textColor ?? Color(0xff999999),
              fontSize: 14.sp,
            ),
          ),
          if (noIcon != true)
            Icon(Icons.arrow_right,color: color ??  Color(0xff999999),),
        ],
      ),
    );
  }
}

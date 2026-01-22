import 'package:charteur/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:charteur/core/theme/app_colors.dart';
import '../widgets/widgets.dart';


class AuthTitleWidgets extends StatelessWidget {
  const AuthTitleWidgets(
      {super.key,
       this.title,
      this.subtitle,
      this.titleColor,
      this.subTitleColor,
      this.titleFontSize,
      this.subTitleFontSize});

  final String? title;
  final String? subtitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final double? titleFontSize;
  final double? subTitleFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.icons.logo.svg(),
        if(title != null && title!.isNotEmpty)
        CustomText(
          top: 24.h,
          text: title!,
          fontSize:titleFontSize?? 20.sp,
          color: titleColor ?? Colors.black,
        ),
        if(subtitle != null)...[
          SizedBox(height: 8.h),
          SizedBox(
            width: 244.w,
            child: CustomText(
              textAlign: TextAlign.center,
              text: subtitle ?? '',
              fontSize:subTitleFontSize?? 14.sp,
              color: subTitleColor ?? Color(0xFF636363),
              textOverflow: TextOverflow.fade,
              fontName: 'Inter',
            ),
          ),
        ],
      ],
    );
  }
}

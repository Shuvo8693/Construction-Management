import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class ClickableRichText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;

  final Color? normalColor;
  final Color? actionColor;
  final double? fontSize;

  const ClickableRichText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
    this.normalColor,
    this.actionColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: CustomText(
              text: normalText,
              color: normalColor,
              fontSize: fontSize ?? 14.sp,
            ),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: onTap,
              child: CustomText(
                text: actionText,
                color: actionColor,
                fontSize: fontSize ?? 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
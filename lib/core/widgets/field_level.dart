// ── Field Label ───────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import 'custom_text.dart';

class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      fontSize: 12.sp,
      color: AppColors.textSecondary,
      bottom: 4.h,
    );
  }
}
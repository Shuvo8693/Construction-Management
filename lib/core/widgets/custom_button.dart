import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:charteur/core/theme/app_colors.dart';
import '../widgets/widgets.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.suffixIcon,
    this.child,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.fontWeight,
    this.fontSize,
    this.fontName,
    required this.onPressed,
    this.radius,
    this.prefixIcon,
    this.bordersColor,
    this.suffixIconShow = false,
    this.prefixIconShow = false,
    this.title,
    this.iconHeight,
    this.iconWidth,
    this.elevation = false,
    this.isLoading = false,               // ← new
    this.loadingColor,                    // ← new
  });

  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final Widget? child;
  final String? label;
  final Widget? title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? radius;
  final String? fontName;
  final VoidCallback? onPressed;
  final Color? bordersColor;
  final bool suffixIconShow;
  final bool prefixIconShow;
  final double? iconHeight;
  final double? iconWidth;
  final bool elevation;
  final bool isLoading;
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      elevation: elevation,
      onTap: isLoading ? null : onPressed, // ← disabled when loading
      color: backgroundColor ?? AppColors.primaryColor,
      height: height ?? 48.h,
      width: width ?? double.infinity,
      radiusAll: radius ?? 4.r,
      bordersColor: bordersColor,
      child: isLoading
          ? _buildLoader()
          : child ?? _buildContent(),
    );
  }

  // ── Loader ────────────────────────────────────────────
  Widget _buildLoader() {
    return Center(
      child: SizedBox(
        height: 22.r,
        width: 22.r,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: loadingColor ?? foregroundColor ?? Colors.white,
        ),
      ),
    );
  }

  // ── Content ───────────────────────────────────────────
  Widget _buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Prefix Icon
        if (prefixIcon != null || prefixIconShow == true) ...[
          Icon(
            prefixIcon ?? Icons.arrow_back,
            size: 18.r,
            color: foregroundColor ?? AppColors.darkColor,
          ),
          SizedBox(width: 8.w),
        ],

        if (title != null) title!,

        /// Label Text
        if (label != null)
          Flexible(
            child: CustomText(
              text: label ?? '',
              color: foregroundColor ?? Colors.white,
              fontName: fontName ?? 'Inter',
              fontWeight: fontWeight ?? FontWeight.w700,
              fontSize: fontSize ?? 16.sp,
            ),
          ),

        /// Suffix Icon
        if (suffixIcon != null || suffixIconShow == true) ...[
          SizedBox(width: 8.w),
          suffixIcon ?? const Icon(Icons.arrow_forward_ios),
        ],
      ],
    );
  }
}
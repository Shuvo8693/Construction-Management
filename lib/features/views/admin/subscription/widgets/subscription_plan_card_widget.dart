import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionPlanCardWidget extends StatelessWidget {
  const SubscriptionPlanCardWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.pricePerMonth,
    required this.price,
    required this.duration,
  });

  final bool isSelected;
  final String pricePerMonth;
  final String price;
  final String duration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        color: isSelected ? AppColors.primaryColor : Colors.white,
        radiusAll: 8.r,
        bordersColor: isSelected
            ? AppColors.primaryColor
            : AppColors.textSecondary.withAlpha(51),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: AppColors.primaryColor.withAlpha(102),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          else
            BoxShadow(
              color: Colors.black.withAlpha(16),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],

        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: duration,
                textAlign: TextAlign.center,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : AppColors.textSecondary.withAlpha(204),
              ),

              SizedBox(height: 8.h),

              CustomText(
                text: price,
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),

              SizedBox(height: 6.h),

              // Price per month
              CustomContainer(
                paddingHorizontal: 8.w,
                paddingVertical: 3.h,
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.grey[100],
                radiusAll: 10.r,
                child: CustomText(
                  text: pricePerMonth,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

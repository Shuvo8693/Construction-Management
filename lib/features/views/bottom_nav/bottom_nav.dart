import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavScreen extends StatelessWidget {
  final int menuIndex;

  const BottomNavScreen({super.key, this.menuIndex = 0});

  static const List<Map<String, dynamic>> _navItems = [
    {"label": "Home"},
    {"label": "Sites"},
    {"label": "Profile"},
  ];

  void _onItemTapped(int index, int selectedIndex) {
    if (selectedIndex == index) return;

    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.adminHome);
        break;
      case 1:
        Get.offAllNamed(AppRoutes.sites);
        break;
      case 2:
        Get.offAllNamed(AppRoutes.profile);
        break;
    }
  }

  String _getIcon(int index, bool isSelected) {
    final icons = [
      isSelected ? Assets.icons.homeF.path : Assets.icons.home.path,
      isSelected ? Assets.icons.planF.path : Assets.icons.plan.path,
      isSelected ? Assets.icons.personF.path : Assets.icons.person.path,
    ];
    return icons[index];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navItems.length,
                  (index) => _buildNavItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final bool isSelected = menuIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index, menuIndex),
      child: CustomContainer(
        paddingAll: 4.r,
        shape: BoxShape.circle,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              _getIcon(index, isSelected),
              width: 20.r,
              height: 20.r,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.primaryColor : AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            CustomText(
              text: _navItems[index]["label"],
              fontSize: 12.sp,
              top: 2.h,
              color: isSelected ? AppColors.primaryColor : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
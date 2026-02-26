import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class BottomNavScreen extends StatefulWidget {
  final int menuIndex;
  const BottomNavScreen({super.key, this.menuIndex = 0});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.menuIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

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

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Assets.icons.home.path, "label": "Home"},
    {"icon": Assets.icons.plan.path, "label": "Sites"},
    // {"icon": Assets.icons.assing.path, "label": "Assign Task"},
    {"icon": Assets.icons.person.path, "label": "Profile"},
  ];

  final List<Map<String, dynamic>> _navItemsF = [
    {"icon": Assets.icons.homeF.path, "label": "Home"},
    {"icon": Assets.icons.planF.path, "label": "Sites"},
    // {"icon": Assets.icons.assingF.path, "label": "Assign Task"},
    {"icon": Assets.icons.personF.path, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }

  Widget _buildNavItem(int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CustomContainer(
        paddingAll: 4.r,
        shape: BoxShape.circle,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? _navItemsF[index]["icon"] : _navItems[index]["icon"],
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
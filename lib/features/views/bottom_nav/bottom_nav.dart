import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/view_models/bottom_nav/bottom_nav_provider.dart';
import 'package:charteur/features/views/admin/home/admin_home_screen.dart';
import 'package:charteur/features/views/common/profile/profile_screen.dart';
import 'package:charteur/features/views/common/sites/sites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {



  final List<Widget> _screens =  [
    AdminHomeScreen(),
    SitesScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      //extendBody: true,
      body: Stack(
        children: [

          // Main screen content
          Selector<BottomNavProvider,int>(
            selector: (context, provider) => provider.selectedIndex,
            builder: (context, selectedIndex, child) {
              return _screens[selectedIndex];
            }
          ),



          Positioned(
            bottom: 20.h,
            left: 6.w,
            right: 6.w,
            child: CustomContainer(
              bordersColor: AppColors.primaryColor,
              radiusAll: 100.r,
              paddingVertical: 10.h,
              color: AppColors.bgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    _navItems.length, (index) => _buildNavItem(index)),
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildNavItem(int index) {
    return Selector<BottomNavProvider,int>(
      selector: (context, provider) => provider.selectedIndex,
      builder: (context, selectedIndex, child) {
        bool isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => context.read<BottomNavProvider>().setSelectedIndex(index),
          child: CustomContainer(
            paddingAll: 4.r,
            shape: BoxShape.circle,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  isSelected ? _navItemsF[index]["icon"]  : _navItems[index]["icon"],
                  width: 20.r,
                  height: 20.r,
                ),


                CustomText(text: _navItems[index]["label"],
                  fontSize: 12.sp,
                  top: 2.h,
                  color: isSelected ?   AppColors.primaryColor : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Assets.icons.home.path, "label": "Home"},
    {"icon": Assets.icons.plan.path, "label": "Sites"},
    {"icon": Assets.icons.assing.path, "label": "Assign Task"},
    {"icon": Assets.icons.person.path, "label": "Profile"},
  ];

  final List<Map<String, dynamic>> _navItemsF = [
    {"icon": Assets.icons.homeF.path, "label": "Home"},
    {"icon": Assets.icons.planF.path, "label": "Sites"},
    {"icon": Assets.icons.assingF.path, "label": "Assign Task"},
    {"icon": Assets.icons.personF.path, "label": "Profile"},
  ];
}

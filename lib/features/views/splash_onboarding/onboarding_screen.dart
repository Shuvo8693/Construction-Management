import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/helpers/helper_data.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  bool en = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        backgroundColor: AppColors.bgColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Eng',
                  color: !en ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.5),
                  fontWeight: !en ? FontWeight.w600 : FontWeight.w400,
                ),
                SizedBox(width: 4.w),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: en,
                    thumbColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        return AppColors.primaryColor;
                      },
                    ),
                    trackColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        return AppColors.primaryColor.withOpacity(0.3);
                      },
                    ),
                    trackOutlineColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 0,
                    onChanged: (bool value) {
                      setState(() {
                        en = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 4.w),
                CustomText(
                  text: 'French',
                  color: en ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.5),
                  fontWeight: en ? FontWeight.w600 : FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          /// PageView
          PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            itemCount: HelperData.onboardingData.length,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (context, index) {
              final data = HelperData.onboardingData[index];
              return Stack(
                children: [
                  /// Background image
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomContainer(
                        height: 287.h,
                        width: 345.w,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(data['image']),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      CustomText(
                        left: 24.w,
                        right: 24.w,
                        textAlign: TextAlign.center,
                        text: data['title'],
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        left: 24.w,
                        right: 24.w,
                        textAlign: TextAlign.center,
                        text: data['subtitle'],
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),

                  /// Gradient overlay
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CustomContainer(
                      height: 524.h,
                      linearColors: AppColors.onboardingLinear,
                    ),
                  ),

                ],
              );
            },
          ),

          /// Bottom Controls
          Positioned(
            left: 30.w,
            right: 24.w,
            bottom: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(currentIndex == HelperData.onboardingData.length - 1)
                SizedBox.shrink(),
                /// Page Indicator
                if (currentIndex < HelperData.onboardingData.length - 1)
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: HelperData.onboardingData.length,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 2,
                      dotColor: const Color(0xffA1A1A1),
                      activeDotColor: AppColors.primaryColor,
                      dotHeight: 10.r,
                      dotWidth: 10.r,
                    ),
                  ),

                /// Button
                currentIndex == HelperData.onboardingData.length - 1
                    ? _buildGetStartedButton()
                    : _buildNextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Next Button
  Widget _buildNextButton() {
    return CustomContainer(
      paddingAll: 16.r,
      shape: BoxShape.circle,
      color: AppColors.primaryColor,
      onTap: _handleNext,
      child: Icon(Icons.arrow_forward_ios_sharp, color: AppColors.bgColor),
    );
  }

  /// Get Started Button
  Widget _buildGetStartedButton() {
    return CustomContainer(
      alignment: Alignment.center,
      width: 149.w,
      radiusAll: 30.r,
      color: AppColors.primaryColor.withOpacity(0.3),
      onTap: _handleNext,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          FittedBox(
            child: CustomText(
              text: 'Get started',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomContainer(
            paddingAll: 16.r,
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
            child: Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.bgColor,
            ),
          ),
        ],
      ),
    );
  }



  /// Handle Next Button
  void _handleNext() {
    if (currentIndex < HelperData.onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed(AppRoutes.role);
    }
  }

}
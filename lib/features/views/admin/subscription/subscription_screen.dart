import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/helpers/helper_data.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/admin/subscription/widgets/subscription_plan_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedPlanIndex = 1;



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Subscription Plan'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  Assets.icons.subscriptionIcon.svg(height: 80.h, width: 80.w),
                  CustomText(
                    top: 16.h,
                    text: 'Get Premium',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            Row(
              children: List.generate(
                HelperData.plans.length,
                    (index) {
                  final plan = HelperData.plans[index];
                  final isSelected = _selectedPlanIndex == index;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index < HelperData.plans.length - 1 ? 12.w : 0,
                      ),
                      child: SubscriptionPlanCardWidget(
                        duration: plan.duration,
                        price: plan.price,
                        pricePerMonth: plan.pricePerMonth,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedPlanIndex = index;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomContainer(
        elevation: true,
        paddingAll: 16.r,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Subscribe Button
              CustomButton(
                radius: 16.r,
                onPressed: () {
                  _handleSubscribe();
                },
                label: 'Subscribe Now',
              ),

              SizedBox(height: 12.h),

              // Terms Text
              CustomText(
                text:
                'By subscribing, you agree to our Terms & Conditions',
                fontSize: 12.sp,
                color: AppColors.textSecondary,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _handleSubscribe() {
    final selectedPlan = HelperData.plans[_selectedPlanIndex];
    // TODO: Implement subscription logic
  }
}


// features/profile/views/office_information_screen.dart

import 'package:charteur/core/widgets/search_bottom_sheet.dart';
import 'package:charteur/features/views/admin/home/view_models/home_controller.dart';
import 'package:charteur/features/views/admin/home/views/company_profile/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';


class CompanyInformationScreen extends StatefulWidget {
   const CompanyInformationScreen({super.key});

  @override
  State<CompanyInformationScreen> createState() => _CompanyInformationScreenState();
}

class _CompanyInformationScreenState extends State<CompanyInformationScreen> {
final _globalKey = GlobalKey<FormState>();
final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        title: CustomText(
          text: 'Office Information',
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Company Info Card ──────────────────
                    CustomText(
                      text: 'Company Info',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 12.h,
                    ),
                    InfoCard(controller: controller),
                  ],
                ),
              ),
            ),

            // ── Update Button ──────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w)
                  .copyWith(bottom: 24.h, top: 12.h),
              child: Obx(() => CustomButton(
                label: 'Update Profile',
                isLoading: controller.isLoading.value,
                onPressed: (){
                  if(_globalKey.currentState!.validate()){
                    controller.addCompanyInfo();
                  }
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}



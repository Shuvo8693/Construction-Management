

// ── Info Card ──────────────────────────────────────────────
import 'package:charteur/core/helpers/menu_show_helper.dart';
import 'package:charteur/core/widgets/field_level.dart';
import 'package:charteur/core/widgets/search_bottom_sheet.dart';
import 'package:charteur/features/views/admin/home/view_models/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';


class InfoCard extends StatelessWidget {
  final HomeController controller;
  const InfoCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      paddingAll: 16.r,
      radiusAll: 8.r,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Company Name ─────────────────────────────
          FieldLabel('Company Name'),
          CustomTextField(
            controller: controller.companyNameCtrl,
            hintText: 'Charteur',
            validator: (v) => v!.isEmpty ? 'Required' : null,
            borderColor: Colors.grey,
          ),
          SizedBox(height: 12.h),

          // ── Location ─────────────────────────────────
          FieldLabel('Location'),
          CustomTextField(
            controller: controller.locationCtrl,
            hintText: '123/45 Street Road, UK',
            validator: (v) => v!.isEmpty ? 'Required' : null,
            suffixIcon: const Icon(Icons.location_on_outlined),
            borderColor: Colors.grey,
            onTap: () {
              // open your searchBottomSheet here
              searchBottomSheet(
                context,
                controller: controller.locationCtrl,
                hintText: 'Search location...',
                onSelected: (String description) {
                    print('Selected description: $description');
                  },
              );
            },
            readOnly: true,
          ),
          SizedBox(height: 12.h),

          // ── Phone Number ──────────────────────────────
          FieldLabel('Phone Number'),
          CustomTextField(
            controller: controller.phoneCtrl,
            hintText: '+012 234 567',
            keyboardType: TextInputType.phone,
            validator: (v) => v!.isEmpty ? 'Required' : null,
            borderColor: Colors.grey,
          ),
          SizedBox(height: 12.h),

          // ── Email ─────────────────────────────────────
          FieldLabel('Email'),
          CustomTextField(
            controller: controller.emailCtrl,
            hintText: 'example@email.com',
            keyboardType: TextInputType.emailAddress,
            validator: (v) => v!.isEmpty ? 'Required' : null,
            borderColor: Colors.grey,
          ),
          SizedBox(height: 12.h),

          // ── Work Type Dropdown ────────────────────────
          FieldLabel('Work Type'),
        GestureDetector(
          onTapDown: (details) async {
            final value = await MenuShowHelper.showCustomMenu(
              context: context,
              details: details,
              options: ['Residential', 'Commercial', 'Industrial', 'Mixed-Use', 'Infrastructure', 'Other'],      // enumValues: [Residential, Commercial, Industrial, Mixed-Use, Infrastructure, Other]
            );
            if (value != null) {
              controller.selectedWorkType.text = value;
            }

          },
          child: AbsorbPointer(
            child: CustomTextField(
              labelText: 'Types of Building',
              hintText: 'Apartment',
              controller: controller.selectedWorkType,
              borderColor: Colors.grey,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 24.r,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
          SizedBox(height: 12.h),

          // ── Website ───────────────────────────────────
          FieldLabel('website (Optional)'),
          CustomTextField(
            controller: controller.websiteCtrl,
            hintText: 'example@email.com',
            keyboardType: TextInputType.url,
            validator: (_) => null,
            borderColor: Colors.grey,
          ),
          SizedBox(height: 12.h),

          // ── Description ───────────────────────────────
          FieldLabel('Description'),
          CustomTextField(
            controller: controller.descriptionCtrl,
            hintText: 'Our company is dedicated to...',
            borderColor: Colors.grey,
            maxLines: 5,
            maxLength: 100,
            validator: (_) => null,
          ),
        ],
      ),
    );
  }
}
// core/widgets/search_bottom_sheet.dart

import 'package:charteur/features/view_models/location/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';


void searchBottomSheet(
    BuildContext context, {
      required TextEditingController controller,
      required String hintText,
      required Function(String description) onSelected,  // ← callback when item tapped
    }) {
  final locationController = Get.put(LocationController());

  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.bgColor,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    context: context,
    builder: (_) {
      return CustomContainer(
        paddingHorizontal: 16.w,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Handle ──────────────────────────────────
              Center(
                child: SizedBox(
                  width: 32.w,
                  child: Divider(
                    color: AppColors.textSecondary,
                    thickness: 4.h,
                  ),
                ),
              ),

              // ── Search Row ───────────────────────────────
              Row(
                children: [
                  Flexible(
                    child: Obx(() => CustomTextField(
                      controller: controller,
                      autofocus: true,
                      validator: (_) => null,
                      hintText: hintText,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: locationController.searchQuery.value.isNotEmpty
                          ? IconButton(
                        onPressed: () {
                          controller.clear();
                          locationController.clearSuggestions();
                        },
                        icon: const Icon(Icons.clear),
                      )
                          : null,
                      onChanged: (value) {
                        locationController.searchQuery.value = value;
                        if (value.trim().isNotEmpty) {
                          locationController.fetchSuggestions(value.trim());
                        } else {
                          locationController.clearSuggestions();
                        }
                      },
                    )),
                  ),
                  CustomText(
                    onTap: () {
                      locationController.clearSuggestions();
                      Get.back();
                    },
                    left: 8.w,
                    text: 'Cancel',
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // ── Suggestions List ─────────────────────────
              Expanded(
                child: Obx(() {
                  if (locationController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (locationController.suggestions.isEmpty) {
                    return Center(
                      child: Text(
                        'No results',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: locationController.suggestions.length,
                    separatorBuilder: (_, __) => Divider(
                      color: AppColors.textSecondary.withAlpha(50),
                    ),
                    itemBuilder: (_, index) {
                      final suggestion = locationController.suggestions[index];
                      return ListTile(
                        onTap: () {
                          controller.text = suggestion['description']!;
                          onSelected(suggestion['description']!); // ← callback
                          locationController.clearSuggestions();
                          Get.back();
                        },
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: AppColors.textPrimary,
                        ),
                        title: CustomText(
                          text: suggestion['title'] ?? '',
                          textAlign: TextAlign.left,
                        ),
                        subtitle: CustomText(
                          text: suggestion['subtitle'] ?? '',
                          textAlign: TextAlign.left,
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  );
                }),
              ),

              SizedBox(height: 8.h),
            ],
          ),
        ),
      );
    },
  );
}
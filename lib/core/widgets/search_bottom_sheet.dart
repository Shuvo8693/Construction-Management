import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/view_models/location/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void searchBottomSheet(
  BuildContext context, {
  required TextEditingController controller,
  required String hintText,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.bgColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    context: context,
    builder: (context) {
      return CustomContainer(
        paddingHorizontal: 16.w,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 32.w,
                  child: Divider(
                    color: AppColors.textSecondary,
                    thickness: 4.h,
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child:
                        Selector<LocationProvider, List<Map<String, String>>>(
                          selector: (_, provider) => provider.suggestionsLocation,
                          builder: (context, suggestions, child) {
                            final locationProvider = context.read<LocationProvider>();
                            return CustomTextField(
                              controller: controller,
                              autofocus: true,
                              validator: (_) => null,
                              hintText: hintText,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: controller.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        controller.clear();
                                        locationProvider.suggestionsLocation.clear();
                                      },
                                      icon: const Icon(Icons.clear),
                                    )
                                  : null,
                              onChanged: (value) {
                                if (value.trim().isNotEmpty) {
                                  locationProvider.fetchSuggestions(value.trim());
                                } else {
                                  locationProvider.suggestionsLocation.clear();
                                }
                              },
                            );
                          },
                        ),
                  ),
                  CustomText(
                    onTap: () => context.pop(),
                    left: 8.w,
                    text: 'Cancel',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Reactive List of Suggestions
              Expanded(
                child: Selector<LocationProvider, List<Map<String, String>>>(
                  selector: (_, provider) => provider.suggestionsLocation,
                  builder: (context, suggestions, child) {
                    if (suggestions.isEmpty) {
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
                      itemCount: suggestions.length,
                      separatorBuilder: (_, __) => Divider(
                        color: AppColors.textSecondary.withAlpha(50),
                      ),
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          onTap: () {
                            controller.text = suggestion['description']!;
                            context.pop();
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
                  },
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      );
    },
  );
}

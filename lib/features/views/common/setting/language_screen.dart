import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/setting/widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


@RoutePage()
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguageCode = 'en';

  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'locale': 'en_US'},
    {'code': 'fr', 'name': 'French', 'locale': 'fr_FR'},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(title: 'language'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Select language',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // Build language list dynamically
          ...languages.map((language) {
            bool isSelected = selectedLanguageCode == language['code'];

            return ProfileListTile(
              color: AppColors.textSecondary.withAlpha(26),
              textColor: isSelected ? AppColors.primaryColor : AppColors.textPrimary,
              icon: Icon(
                Icons.language,
                color:  AppColors.primaryColor,
              ),
              noIcon: true,
              title: language['name']!,
              onTap: () async {
                if (!isSelected) {
                  setState(() {
                    selectedLanguageCode = language['code']!;
                  });
                  // TODO: Implement actual language change logic here
                  // e.g., await localization.setLocale(language['locale']);
                }
              },
              trailing: isSelected
                  ? CustomContainer(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                paddingAll: 4.r,
                child: Icon(
                  Icons.check,
                  size: 16.r,
                  color: Colors.white,
                ),
              )
                  : null,
            );
          }),
        ],
      ),
    );
  }
}
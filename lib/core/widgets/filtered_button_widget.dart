import 'package:charteur/core/helpers/menu_show_helper.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilteredButtonWidget extends StatefulWidget {
  const FilteredButtonWidget({
    super.key,
    required this.categoryItem,
    this.selectedValue = '',
    this.onStatusChanged,
  });

  final List<Map<String, dynamic>> categoryItem;
  final String selectedValue;
  final Function(String)? onStatusChanged;

  @override
  State<FilteredButtonWidget> createState() => _FilteredButtonWidgetState();
}

class _FilteredButtonWidgetState extends State<FilteredButtonWidget> {
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(FilteredButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      setState(() {
        selectedValue = widget.selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      bordersColor: AppColors.primaryColor,
      paddingVertical: 6.h,
      paddingHorizontal: 6.h,
      radiusAll: 8.w,
      verticalMargin: 10.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.categoryItem.map((item) {
            final isSelected = selectedValue == item["title"];

            return CustomContainer(
              onTap: () {
                setState(() {
                  selectedValue = item["title"];
                });
                widget.onStatusChanged?.call(selectedValue);
              },
              horizontalMargin: 4.w,
              paddingVertical: 4.h,
              paddingHorizontal: 10.w,
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              radiusAll: 4.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: item["title"],
                    color: isSelected
                        ? AppColors.bgColor
                        : AppColors.textSecondary,
                  ),
                  if (item["items"] != null &&
                      item["items"] is List &&
                      (item["items"] as List).isNotEmpty &&
                      isSelected)
                    GestureDetector(
                      onTapDown: (details) {
                        MenuShowHelper.showCustomMenu(
                          context: context,
                          details: details,
                          options: List<String>.from(item["items"]),
                        );
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.bgColor,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildFilePathContainer(String? filePath, VoidCallback onTapRemove) {
  final fileName = filePath?.split('/').last ?? 'No file selected';
  final extension = fileName.split('.').last.toLowerCase();

  IconData _getFileIcon() {
    switch (extension) {
      case 'pdf':  return Icons.picture_as_pdf;
      case 'doc':
      case 'docx': return Icons.description;
      case 'xls':
      case 'xlsx': return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png':  return Icons.image;
      default:     return Icons.insert_drive_file;
    }
  }

  Color _getFileColor() {
    switch (extension) {
      case 'pdf':  return Colors.red;
      case 'doc':
      case 'docx': return Colors.blue;
      case 'xls':
      case 'xlsx': return Colors.green;
      case 'jpg':
      case 'jpeg':
      case 'png':  return Colors.orange;
      default:     return AppColors.primaryColor;
    }
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: AppColors.bgColor,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: AppColors.primaryColor.withOpacity(0.4)),
    ),
    child: filePath == null
        ? Row(
      children: [
        Icon(Icons.attach_file, color: AppColors.textSecondary, size: 20.r),
        SizedBox(width: 8.w),
        CustomText(
          text: 'No file selected',
          fontSize: 13.sp,
          color: AppColors.textSecondary,
        ),
      ],
    ) : Row(
      children: [
        // File type icon
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: _getFileColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            _getFileIcon(),
            color: _getFileColor(),
            size: 22.r,
          ),
        ),
        SizedBox(width: 10.w),

        // File name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: fileName,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                maxline: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              CustomText(
                text: filePath,
                fontSize: 10.sp,
                color: AppColors.textSecondary,
                maxline: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),

        // Remove file button
        GestureDetector(
          onTap: onTapRemove,
          child: Icon(
            Icons.close,
            color: AppColors.textSecondary,
            size: 18.r,
          ),
        ),
      ],
    ),
  );
}
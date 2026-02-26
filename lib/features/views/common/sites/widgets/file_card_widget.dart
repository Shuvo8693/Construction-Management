import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/sites/models/filelist_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileCardWidget extends StatelessWidget {
  final FileData fileData;
  final VoidCallback onTap;

  const FileCardWidget({
    super.key, required this.onTap, required this.fileData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      marginTop: 12.h,
      paddingAll: 12.r,
      color: Colors.white,
      radiusAll: 8.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Assets.icons.pdf.svg(
                width: 32.w,
                height: 32.h,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 12.w),
              CustomText(
                fontWeight: FontWeight.w500,
                text: fileData.fileName,
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Assets.icons.threeDot.svg(),
          ),
        ],
      ),
    );
  }
}
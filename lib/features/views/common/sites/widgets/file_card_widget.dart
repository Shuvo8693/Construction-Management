import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileCardWidget extends StatelessWidget {
  const FileCardWidget({
    super.key,
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
                text: 'Project Plan.pdf',
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Assets.icons.threeDot.svg(),
          ),
        ],
      ),
    );
  }
}
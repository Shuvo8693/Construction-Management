import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/custom_container.dart';
import 'package:charteur/core/widgets/custom_network_image.dart';
import 'package:charteur/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SiteCardWidget extends StatelessWidget {
  const SiteCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      marginTop: 10.h,
      radiusAll: 8.r,
      paddingAll: 12.r,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomNetworkImage(
            border: Border.all(color: AppColors.primaryColor.withAlpha(20)),
            imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y29uc3RydWN0aW9uJTIwc2l0ZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60', width: 90.w, height: 82.h, borderRadius: 12.r,),

          SizedBox(width: 12.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  maxline: 2,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    text: 'Downtown Mall Projects'),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      color: AppColors.textSecondary,
                        fontSize: 12.sp,
                        textAlign: TextAlign.start,
                        text: 'Apartment'),
                    CustomContainer(
                      paddingAll: 4.r,
                      radiusAll: 11.r,
                      bordersColor: AppColors.primaryColor,
                      color: AppColors.primaryColor.withAlpha(77),
                        child: CustomText(
                          textAlign: TextAlign.end,
                          text: 'In Progress',fontSize: 10.sp)),
                  ],
                ),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    Flexible(
                      child: CustomText(
                        maxline: 1,
                        textOverflow: TextOverflow.ellipsis,
                          right: 8.w,
                          textAlign: TextAlign.start,
                          text: '36 Park Street Road'),
                    ),
                    Assets.icons.location.svg(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

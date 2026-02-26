import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SiteCardWidget extends StatelessWidget {
  final SiteData _siteData;
  const SiteCardWidget({super.key, required SiteData siteData}) : _siteData = siteData;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: (){
        Get.toNamed(AppRoutes.files,arguments: {"siteId":_siteData.id});
      },
      marginTop: 10.h,
      radiusAll: 8.r,
      paddingAll: 12.r,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            border: Border.all(color: AppColors.primaryColor.withAlpha(20)),
            imageUrl: _siteData.photos.first, width: 90.w, height: 82.h, borderRadius: 12.r,),

          SizedBox(width: 12.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // site title
                CustomText(
                  maxline: 2,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    text: _siteData.siteTitle),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //building type
                    CustomText(
                      color: AppColors.textSecondary,
                        fontSize: 12.sp,
                        textAlign: TextAlign.start,
                        text: _siteData.buildingType),
                    // status
                    CustomContainer(
                      paddingAll: 4.r,
                      radiusAll: 11.r,
                      bordersColor: AppColors.primaryColor,
                      color: AppColors.primaryColor.withAlpha(77),
                        child: CustomText(
                          textAlign: TextAlign.end,
                          text: _siteData.status ,fontSize: 10.sp)),
                  ],
                ),
                SizedBox(height: 8.h,),
                // site location
                Row(
                  children: [
                    Flexible(
                      child: CustomText(
                        maxline: 1,
                        textOverflow: TextOverflow.ellipsis,
                          right: 8.w,
                          textAlign: TextAlign.start,
                          text: _siteData.location.address),
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

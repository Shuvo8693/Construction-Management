import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/view_models/bottom_nav/bottom_nav_provider.dart';
import 'package:charteur/features/views/admin/home/view_models/home_controller.dart';
import 'package:charteur/features/views/bottom_nav/bottom_nav.dart';
import 'package:charteur/features/views/common/sites/widgets/site_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final  _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _homeController.getSite();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: BottomNavScreen(menuIndex: 0),
      appBar: CustomAppBar(
        titleWidget: CustomListTile(
          contentPaddingHorizontal: 16.w,
          titleFontSize: 14.sp,
          subtitleFontSize: 16.sp,
          titleColor: AppColors.appGreyColor,
          title: 'Welcome back,',
          subTitle: 'Billal',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.notifications);
            },
            icon: Assets.icons.notification.svg(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          CustomContainer(
            radiusAll: 8.r,
              width: double.infinity,
            paddingAll: 12.r,
            bordersColor: AppColors.primaryColor.withAlpha(102),
            linearColors: [
              Colors.white.withAlpha(0),
              AppColors.primaryColor.withAlpha(102),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Manage Your Construction Projects Effortlessly',
                        color: AppColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 4.h,),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'From interactive site maps to task tracking and PDF plans, streamline construction management with instant updates and secure role-based access.',
                        color: AppColors.appGreyColor,
                        fontSize: 10.sp,
                        bottom: 12.h,
                        top: 6.h,
                      ),
                      CustomButton(
                        width: 186.w,
                        height: 34.h,
                        elevation: true,
                        onPressed: (){
                          Get.toNamed(AppRoutes.siteAdd);
                        },label: 'Get Start',)
                    ],
                  ),
                ),
                Assets.images.getStart.image(width: 120.w, height: 145.h,fit: BoxFit.cover),
              ],
            ),
          ),



          SizedBox(height: 20.h),
          Row(
            children: [
              CustomText(text: 'Your Sites', fontSize: 16.sp, color: AppColors.textPrimary),
              Spacer(),
              InkWell(
                  onTap: () {
                    context.read<BottomNavProvider>().setSelectedIndex(1);
                  },
                  child: CustomText(text: 'See All', fontSize: 16.sp, color: AppColors.textPrimary)),
            ],
          ),

          Obx((){
           final siteData = _homeController.siteListModel.value?.data;
            if(_homeController.isLoading.value){
              return Center(child: CircularProgressIndicator());
            }else if(siteData == null && siteData!.isEmpty){
              return Center(child: Text('No Data Found'));
            }
            return  Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                 await _homeController.getSite();
                },
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: siteData.length,
                  itemBuilder: (context, index) {
                    return AnimatedListItemWraper(
                      index: index,
                      child: SiteCardWidget(siteData: siteData[index],),
                    );
                  },
                ),
              ),
            );
          }
          ),
        ],
      ),
    );
  }
}
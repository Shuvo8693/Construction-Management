
import 'package:charteur/core/widgets/custom_text.dart';
import 'package:charteur/features/views/admin/home/view_models/home_controller.dart';
import 'package:charteur/features/views/admin/home/views/site_details/widgets/add_remark_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RemarkScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String remarkText;
  final VoidCallback? onBack;

  const RemarkScreen({
    super.key,
    this.title = "Repair Living Room's Electric Line",
    this.imageUrl = '',
    this.remarkText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    this.onBack,
  });

  @override
  State<RemarkScreen> createState() => _RemarkScreenState();
}

class _RemarkScreenState extends State<RemarkScreen> {
  final _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      await _homeController.getRemark();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            /// ── Header ─────────────────────────────────────────────
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
                SizedBox(width: 8.w),
                CustomText(
                  text: 'Completed Work',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  textAlign: TextAlign.start,
                ),
              ],
            ),

            /// ── Content ─────────────────────────────────────────────
            Obx(() {
              final remarkData =
                  _homeController.remarkDetailsModel.value?.data;

              if (_homeController.isLoading.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (remarkData == null) {
                return const Expanded(
                  child: Center(
                    child: CustomText(
                      text: 'No remark Available',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return Expanded(
                child: SingleChildScrollView(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      /// ── Card ─────────────────────────────────────
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Title
                            Padding(
                              padding:
                              EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                              child: CustomText(
                                text: widget.title,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                textAlign: TextAlign.start,
                              ),
                            ),

                            /// Image
                            ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: remarkData.images?.isNotEmpty == true
                                  ? Image.network(
                                remarkData.images?.first ?? '',
                                width: double.infinity,
                                height: 200.h,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                    _buildPlaceholderImage(),
                              )
                                  : _buildPlaceholderImage(),
                            ),

                            SizedBox(height: 16.h),

                            /// Remark Description
                            Padding(
                              padding:
                              EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(14.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFF4CAF93),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: CustomText(
                                  text: remarkData.description ?? '',
                                  fontSize: 13.sp,
                                  color: Colors.black87,
                                  textHeight: 1.6,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            /// ── Add Remark Panel ───────────────────────────────────
            const AddRemarkPanel(),
          ],
        ),
      ),
    );
  }

  /// Placeholder Image
  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: 200.h,
      color: Colors.grey[300],
      child: Icon(
        Icons.image_outlined,
        size: 48,
        color: Colors.grey[500],
      ),
    );
  }
}
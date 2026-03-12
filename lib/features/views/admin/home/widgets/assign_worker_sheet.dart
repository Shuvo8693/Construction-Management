import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/features/views/admin/home/view_models/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:charteur/core/widgets/custom_text.dart';

class AssignWorkerSheet extends StatefulWidget {
  const AssignWorkerSheet({super.key});

  @override
  State<AssignWorkerSheet> createState() => _AssignWorkerSheetState();
}

class _AssignWorkerSheetState extends State<AssignWorkerSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  final _homeController = Get.find<HomeController>();

  String _selectedFilter = 'all';
  final List<String> _filters = ['all', 'office_admin', 'worker'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      await _homeController.getWorkersOrAdmins();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setInner) {
          return Container(
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                CustomText(
                  text: 'Filter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 12.h),
                ..._filters.map((role) {
                  final isSelected = _selectedFilter == role;
                  return Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() => _selectedFilter = role);
                        setInner(() {});
                        Navigator.pop(ctx);
                        await _homeController.getWorkersOrAdmins(role: role);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF2E7D6B)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF2E7D6B)
                                : const Color(0xFFE0E0E0),
                          ),
                        ),
                        child: Center(
                          child: CustomText(
                            text: role,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: TextField(
                        controller: _searchCtrl,
                        onChanged: (_) => setState(() {}),
                        style: TextStyle(fontSize: 13.sp),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                          prefixIcon: Icon(Icons.search, size: 18.sp, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: _showFilterSheet,
                    child: Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: _selectedFilter != 'all'
                            ? const Color(0xFF2E7D6B)
                            : const Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Icon(
                        Icons.tune,
                        size: 20.sp,
                        color: _selectedFilter != 'all' ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedFilter != 'all')
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 8.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D6B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: _selectedFilter,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2E7D6B),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () async {
                              setState(() => _selectedFilter = 'all');
                              await _homeController.getWorkersOrAdmins();
                            },
                            child: Icon(Icons.close, size: 12.sp, color: const Color(0xFF2E7D6B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 12.h),
            Expanded(
              child: Obx(() {
                if (_homeController.isLoading.value) {
                  return const Center(child: CupertinoActivityIndicator());
                }

                final allWorkers = _homeController.workerListModel.value?.data ?? [];

                final workersData = allWorkers.where((w) {
                  final query = _searchCtrl.text.toLowerCase();
                  if (query.isEmpty) return true;
                  return (w.name?.toLowerCase().contains(query) ?? false) ||
                      (w.expertiseArea?.toLowerCase().contains(query) ?? false);
                }).toList();

                if (workersData.isEmpty) {
                  return const Center(child: CustomText(text: 'No workers available'));
                }

                return ListView.separated(
                  controller: scrollCtrl,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: workersData.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (_, i) {
                    final worker = workersData[i];
                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26.r,
                            backgroundImage: NetworkImage(worker.profileImage ?? ''),
                            onBackgroundImageError: (_, __) {},
                            child: worker.profileImage == null ? const Icon(Icons.person) : null,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: worker.name ?? '',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1A1A2E),
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.toNamed(
                                        AppRoutes.collaboratorDetails,
                                        arguments: {'worker': worker},
                                      ),
                                      child: CustomText(
                                        text: 'Details',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF2E7D6B),
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color(0xFF2E7D6B),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Charteur · ',
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                    ),
                                    CustomText(
                                      text: worker.role ?? '',
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: worker.expertiseArea ?? 'Constructor',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1A1A2E),
                                    ),
                                    Obx(() {
                                      if (_homeController.isAssignLoading[i] == true) {
                                        return const Center(child: CupertinoActivityIndicator());
                                      }
                                      return GestureDetector(
                                        onTap: () async {
                                          await _homeController.assignTask(
                                            i: i,
                                            fileId: _homeController.fileDetailsModel.value?.data?.id,
                                            assignedTo: worker.id,
                                            fileName: _homeController.fileDetailsModel.value?.data?.fileName,
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2E7D6B).withOpacity(0.12),
                                            borderRadius: BorderRadius.circular(20.r),
                                          ),
                                          child: CustomText(
                                            text: 'Assign Task',
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF2E7D6B),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
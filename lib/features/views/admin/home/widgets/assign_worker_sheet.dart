
import 'package:auto_route/auto_route.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignWorkerSheet extends StatefulWidget {
  const AssignWorkerSheet({super.key});

  @override
  State<AssignWorkerSheet> createState() => _AssignWorkerSheetState();
}

class _AssignWorkerSheetState extends State<AssignWorkerSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = ['Office Admin', 'Collaborator', 'All'];

  final List<Map<String, String>> _workers = [
    {'name': 'Leslie Alexander', 'role': 'Collaborator', 'trade': 'Painter', 'image': 'https://randomuser.me/api/portraits/men/32.jpg'},
    {'name': 'Jane Cooper', 'role': 'Collaborator', 'trade': 'Plumber', 'image': 'https://randomuser.me/api/portraits/men/45.jpg'},
    {'name': 'Kristin Watson', 'role': 'Collaborator', 'trade': 'Electrician', 'image': 'https://randomuser.me/api/portraits/men/65.jpg'},
    {'name': 'Robert Fox', 'role': 'Office Admin', 'trade': 'Supervisor', 'image': 'https://randomuser.me/api/portraits/men/22.jpg'},
    {'name': 'Cody Fisher', 'role': 'Office Admin', 'trade': 'Manager', 'image': 'https://randomuser.me/api/portraits/men/11.jpg'},
  ];

  List<Map<String, String>> get _filtered {
    return _workers.where((w) {
      final matchFilter = _selectedFilter == 'All' || w['role'] == _selectedFilter;
      final matchSearch = w['name']!.toLowerCase().contains(_searchCtrl.text.toLowerCase()) ||
          w['trade']!.toLowerCase().contains(_searchCtrl.text.toLowerCase());
      return matchFilter && matchSearch;
    }).toList();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setInner) => Container(
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),
              Text('Filter', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 12.h),
              ..._filters.map((f) {
                final isSelected = _selectedFilter == f;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedFilter = f);
                      setInner(() {});
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2E7D6B) : Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2E7D6B) : const Color(0xFFE0E0E0),
                        ),
                      ),
                      child: Center(
                        child: Text(f,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
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
            // Handle
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

            // Search + Filter row
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
                        color: _selectedFilter != 'All'
                            ? const Color(0xFF2E7D6B)
                            : const Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Icon(
                        Icons.tune,
                        size: 20.sp,
                        color: _selectedFilter != 'All' ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Active filter chip
            if (_selectedFilter != 'All')
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
                          Text(
                            _selectedFilter,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF2E7D6B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () => setState(() => _selectedFilter = 'All'),
                            child: Icon(Icons.close, size: 12.sp, color: const Color(0xFF2E7D6B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 12.h),

            // Worker list
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                child: Text('No workers found',
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
              )
                  : ListView.separated(
                controller: scrollCtrl,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, i) {
                  final w = _filtered[i];
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
                        // Avatar
                        CircleAvatar(
                          radius: 26.r,
                          backgroundImage: NetworkImage(w['image']!),
                        ),
                        SizedBox(width: 12.w),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    w['name']!,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1A1A2E),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.router.push(const CollaboratorDetailsRoute());
                                    },
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF2E7D6B),
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color(0xFF2E7D6B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Text(
                                    'Chartuer  ',
                                    style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                                  ),
                                  Text(
                                    w['role']!,
                                    style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    w['trade']!,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1A1A2E),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context, w),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2E7D6B).withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Text(
                                        'Assign Task',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: const Color(0xFF2E7D6B),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
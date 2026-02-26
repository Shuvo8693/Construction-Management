import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/admin/home/views/remarks/remarks_screen.dart';
import 'package:charteur/features/views/common/sites/widgets/file_card_widget.dart';
import 'package:charteur/features/views/common/sites/widgets/todo_card_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

@RoutePage()
class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'All Files'),
      body: Column(
        children: [
          // Tab Bar
          CustomContainer(
            verticalMargin: 12.h,
              color: AppColors.primaryColor.withAlpha(20),
            radiusAll: 8.r,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(text: 'Files'),
                Tab(text: 'To-do'),
                Tab(text: 'In Progress'),
                Tab(text: 'Done'),
                Tab(text: 'Remarks'),
              ],
            ),
          ),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Files Tab
                _buildFilesList(),
                // To-do Tab
                _buildTodoList(status: 'To-do'),
                // In Progress Tab
                _buildTodoList(status: 'In Progress'),
                // Done Tab
                _buildTodoList(status: 'Done'),
                // Remarks Tab
                RemarksScreen(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (context, _) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _tabController.index == 4
                ? const SizedBox.shrink()
                : FloatingActionButton.extended(
              key: const ValueKey('fab'),
              onPressed: () => Get.toNamed(AppRoutes.fileAdd),
              backgroundColor: AppColors.primaryColor,
              label: const CustomText(
                text: 'Add File',
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              icon: Assets.icons.addIcon.svg(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilesList() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh logic here
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return FileCardWidget(
              onTap: () {
                Get.toNamed(AppRoutes.task);

          });
        },
      ),
    );
  }

  Widget _buildTodoList({String? status}) {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh logic here
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.siteDetails);
            },
            child: TodoCardWidget(
              title: 'Repair Living Room’s  Electric Line',
              category: 'Design',
              projectName: 'Downtown Mall Projects',
              assigneeName: 'Leslie Alexander',
              description: 'Applying a smooth or protective layer of cement, lime, or gypsum on a wall or ceiling Applying a smooth or protective layer of cement, l',
              status: status,
              imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y29uc3RydWN0aW9uJTIwc2l0ZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',

            ),
          );
        },
      ),
    );
  }
}


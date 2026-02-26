import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/admin/home/views/remarks/remarks_screen.dart';
import 'package:charteur/features/views/common/sites/view_models/sites_controller.dart';
import 'package:charteur/features/views/common/sites/widgets/file_card_widget.dart';
import 'package:charteur/features/views/common/sites/widgets/todo_card_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final  _sitesController = Get.find<SitesController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((__)async{
     await _sitesController.getSiteFiles();
      _tabController.addListener((){
        switch (_tabController.index) {
          case 0:
            _sitesController.getSiteFiles();
            break;
          case 1:
            _sitesController.getSiteTask(status: "To-Do");
            break;
          case 2:
            _sitesController.getSiteTask(status: "In-Progress");
            break;
          case 3:
            _sitesController.getSiteTask(status: "Done");
            break;
        }
      });
    });
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
                _buildTodoList(status: 'To-Do'),
                // In Progress Tab
                _buildTodoList(status: 'In-Progress'),
                // Done Tab
                _buildTodoList(status: 'Done'),
                // Remarks Tab
                RemarksScreen(status: 'Remarks'),
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
    return Obx((){
      final fileData = _sitesController.fileListModel.value?.data;
      if(_sitesController.isLoading.value){
        return Center(child: CircularProgressIndicator());
      }
      else if(fileData == null && fileData!.isEmpty){
        return Center(child: Text('No Data Found'));
      }
      return RefreshIndicator(
        onRefresh: () async {
          await _sitesController.getSiteFiles();
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: fileData.length,
          itemBuilder: (BuildContext context, int index) {
            return FileCardWidget(
                onTap: () {
                  Get.toNamed(AppRoutes.task);

                }, fileData: fileData[index]
            );
          },
        ),
      );
     }
    );
  }
  Widget _buildTodoList({String? status }) {
    return Obx(() {
      // Get task list from controller
      final taskData = _sitesController.taskListModel.value?.data ?? [];

      // Show empty indicator if no tasks
      if (_sitesController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (taskData.isEmpty) {
        return const Center(child: Text("No tasks available"));
      }

      return RefreshIndicator(
        onRefresh: () async {
          // Call API again to refresh tasks
          await _sitesController.getSiteTask(status: status??'');
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: taskData.length,
          itemBuilder: (BuildContext context, int index) {
            final task = taskData[index];

            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.siteDetails);
              },
              child: TodoCardWidget(
                title: task.title,
                category: task.fileId.fileType,
                projectName: task.siteId.siteTitle,
                assigneeName: task.assignedTo.name,
                description: task.description,
                status: task.status,
                imageUrl: task.images.isNotEmpty ? task.images.first : '',
              ),
            );
          },
        ),
      );
    });
  }


}


import 'package:auto_route/auto_route.dart';
import 'package:charteur/assets/assets.gen.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/theme/app_colors.dart';
import 'package:charteur/core/widgets/jwt_decoder/payload_value.dart';
import 'package:charteur/core/widgets/widgets.dart';
import 'package:charteur/features/views/common/sites/view_models/sites_controller.dart';
import 'package:charteur/features/views/common/sites/widgets/file_card_widget.dart';
import 'package:charteur/features/views/common/sites/widgets/todo_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> with TickerProviderStateMixin {
   TabController? _tabController;
  final _sitesController = Get.find<SitesController>();

  String _siteId = '';
  String myId = '';
  String myRole = '';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _getSiteId();

    // Temporary controller to avoid LateInitializationError
    // _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getMyInfo();
      _setupTabController();
    });
  }

  void _getSiteId() {
    final siteId = Get.arguments?['siteId'] ?? '';
    setState(() => _siteId = siteId);
  }

  Future<void> _getMyInfo() async {
    final payloads = await getPayloadValue();
    setState(() {
      myId = payloads['userId'];
      myRole = payloads['role'];
    });
  }

  void _setupTabController() {
    // Dispose old temp controller
    _tabController?.dispose();

    final isAdmin = myRole == 'office_admin';
    final tabCount = isAdmin ? 4 : 3;

    _tabController = TabController(length: tabCount, vsync: this);

    // Load data for initial tab
    _loadDataForTab(0);

    // Load data on tab change
    _tabController?.addListener(() {
      if (!_tabController!.indexIsChanging) {
        _loadDataForTab(_tabController!.index);
      }
    });

    setState(() => _isInitialized = true);
  }

  void _loadDataForTab(int index) {
    final isAdmin = myRole == 'office_admin';

    // ✅ Clear data before loading new tab data
    _sitesController.fileListModel.value = null;
    _sitesController.taskListModel.value = null;

    if (isAdmin) {
      switch (index) {
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
    } else {
      // Worker role
      switch (index) {
        case 0:
          _sitesController.getSiteTask(status: "To-Do");
          break;
        case 1:
          _sitesController.getSiteTask(status: "In-Progress");
          break;
        case 2:
          _sitesController.getSiteTask(status: "Done");
          break;
      }
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  /// Build tabs based on role
  List<Tab> get _tabs {
    final isAdmin = myRole == 'office_admin';
    return [
      if (isAdmin) const Tab(text: 'Files'),
      const Tab(text: 'To-Do'),
      const Tab(text: 'In Progress'),
      const Tab(text: 'Done'),
    ];
  }

  /// Build tab views based on role
  List<Widget> get _tabViews {
    final isAdmin = myRole == 'office_admin';
    return [
      if (isAdmin) _buildFilesList(),
      _buildTodoList(status: 'To-Do'),
      _buildTodoList(status: 'In-Progress'),
      _buildTodoList(status: 'Done'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Show loader until role is fetched and controller is ready
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isAdmin = myRole == 'office_admin';

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
              tabs: _tabs,
            ),
          ),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabViews,
            ),
          ),
        ],
      ),
      floatingActionButton: isAdmin
          ? AnimatedBuilder(
        animation: _tabController!,
        builder: (context, _) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton.extended(
              key: const ValueKey('fab'),
              onPressed: () => Get.toNamed(
                AppRoutes.fileAdd,
                arguments: {"siteId": _siteId},
              ),
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
      ) : const SizedBox.shrink(),
    );
  }

  Widget _buildFilesList() {
    return Obx(() {
      final fileData = _sitesController.fileListModel.value?.data ?? [];

      if (_sitesController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (fileData.isEmpty) {
        return const Center(child: Text('No Data Found'));
      }

      return RefreshIndicator(
        onRefresh: () async => await _sitesController.getSiteFiles(),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: fileData.length,
          itemBuilder: (context, index) {
            return FileCardWidget(
              onTap: () => Get.toNamed(
                AppRoutes.task,
                arguments: {"fileId": fileData[index].id},
              ),
              fileData: fileData[index],
            );
          },
        ),
      );
    });
  }

  Widget _buildTodoList({required String status}) {
    return Obx(() {
      final taskData = _sitesController.taskListModel.value?.data ?? [];

      if (_sitesController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (taskData.isEmpty) {
        return const Center(child: Text("No tasks available"));
      }

      return RefreshIndicator(
        onRefresh: () async => await _sitesController.getSiteTask(status: status),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: taskData.length,
          itemBuilder: (context, index) {
            final task = taskData[index];
            return GestureDetector(
              onTap: () => Get.toNamed(
                AppRoutes.siteDetails,
                arguments: {"taskId": task.id},
              ),
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
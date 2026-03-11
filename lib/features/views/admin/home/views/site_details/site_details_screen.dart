import 'package:auto_route/annotations.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/widgets/custom_button.dart';
import 'package:charteur/core/widgets/jwt_decoder/payload_value.dart';
import 'package:charteur/features/views/admin/home/models/site_details_responsemodel.dart';
import 'package:charteur/features/views/admin/home/views/site_details/widgets/comment_tile.dart';
import 'package:charteur/features/views/admin/home/views/site_details/widgets/pdf_viewer_sheet.dart';
import 'package:charteur/features/views/admin/home/views/site_details/widgets/show-status_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../view_models/home_controller.dart';

class SiteDetailsScreen extends StatefulWidget {
  const SiteDetailsScreen({super.key});

  @override
  State<SiteDetailsScreen> createState() => _SiteDetailsScreenState();
}

class _SiteDetailsScreenState extends State<SiteDetailsScreen> {
  int _currentImage = 0;
  final TextEditingController _commentCtrl = TextEditingController();
  final _homeController = Get.find<HomeController>();

  final List<Map<String, String>> _comments = [
    {'name': 'John Doe', 'comment': 'Great progress on the project!', 'time': '2h ago'},
    {'name': 'Jane Smith', 'comment': 'Make sure to follow safety protocols.', 'time': '5h ago'},
  ];

  bool _showComments = false;

  void _addComment() {
    if (_commentCtrl.text.trim().isEmpty) return;
    setState(() {
      _comments.insert(0, {
        'name': 'You',
        'comment': _commentCtrl.text.trim(),
        'time': 'Just now',
      });
      _commentCtrl.clear();
      _showComments = true;
    });
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      await getMyInfo();
      await _homeController.getSiteTaskDetails();
      await _homeController.getComment();
    });
  }

  String myId = '';
  String myRole = '';

  Future<void> getMyInfo() async {
    final payloads = await getPayloadValue();
    myId = payloads['userId'];
    myRole = payloads['role'];
    setState(() {});
  }

  // ── Full-screen image dialog ───────────────────────────────────────────────
  void _showImageDialog(BuildContext context, List<String> images, int initialIndex) {
    int dialogCurrentImage = initialIndex;
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(12.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    width: double.infinity,
                    height: 360.h,
                    child: PageView.builder(
                      controller: PageController(initialPage: initialIndex),
                      itemCount: images.length,
                      onPageChanged: (i) => setDialogState(() => dialogCurrentImage = i),
                      itemBuilder: (_, i) => Image.network(
                        images[i],
                        fit: BoxFit.contain,
                        loadingBuilder: (_, child, progress) => progress == null
                            ? child
                            : const Center(child: CircularProgressIndicator(color: Colors.white)),
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
                        ),
                      ),
                    ),
                  ),
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 10.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                            (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: dialogCurrentImage == i ? 18.w : 8.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: dialogCurrentImage == i
                                ? const Color(0xFF2E7D6B)
                                : Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                      child: Icon(Icons.close, color: Colors.white, size: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── PDF bottom sheet ───────────────────────────────────────────────────────
  //
  // Replaces the old _showFileDialog. Streams the PDF directly from the URL
  // using SfPdfViewer.network — no download step needed for view-only.
  void _showPdfBottomSheet(BuildContext context, String fileUrl, String fileName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PdfViewerSheet(fileUrl: fileUrl, fileName: fileName),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: const Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'See More',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E)),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final task = _homeController.taskDetailsModel.value?.data;
        // final comments = _homeController.commentsResponseModel.value;

        if (task == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final siteName   = task.siteId?.siteTitle ?? 'N/A';
        final description = task.description ?? '';
        final status     = task.status ?? 'Unknown';
        final images     = (task.images?.isNotEmpty == true) ? task.images! : (task.siteId?.photos ?? []);
        final fileId     = task.fileId;
        final assignedTo = task.assignedTo?.id;

        Color statusColor;
        switch (status) {
          case 'Done':       statusColor = const Color(0xFF2E7D6B); break;
          case 'To-Do':      statusColor = const Color(0xFFF9A825); break;
          case 'In-Progress':statusColor = const Color(0xFFE65100); break;
          default:           statusColor = const Color(0xFFE65100);
        }


        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Site Details ──────────────────────────────────────
                    Text('Site Details',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _richRow('Site Name : ', siteName),
                          SizedBox(height: 8.h),
                          _richRow('Title : ', task.title ?? 'N/A'),
                          SizedBox(height: 8.h),
                          _richRow('Assigned To : ', task.assignedTo?.name ?? 'N/A'),
                          SizedBox(height: 8.h),
                          _richRow('Due Date : ', task.dueDate != null
                              ? '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}'
                              : 'N/A'),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.siteLocation, arguments: {'siteId': task.siteId?.id}),
                            child: Text('See Site Location',
                                style: TextStyle(color: Colors.blue, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Image Slider ──────────────────────────────────────
                    if (images.isNotEmpty) ...[
                      Container(
                        height: 200.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: images.length,
                              onPageChanged: (i) => setState(() => _currentImage = i),
                              itemBuilder: (_, i) => GestureDetector(
                                onTap: () => _showImageDialog(context, images, i),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(images[i], fit: BoxFit.cover,
                                          loadingBuilder: (_, child, progress) =>
                                          progress == null ? child : const Center(child: CircularProgressIndicator()),
                                          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 40))),
                                      Positioned(
                                        top: 8.h, right: 8.w,
                                        child: Container(
                                          padding: EdgeInsets.all(4.w),
                                          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(6.r)),
                                          child: Icon(Icons.fullscreen, color: Colors.white, size: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 36.h, right: 12.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(6.r)),
                                child: Text(status,
                                    style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                              ),
                            ),
                            if (images.length > 1)
                              Positioned(
                                bottom: 10.h, left: 0, right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(images.length, (i) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                                    width: _currentImage == i ? 18.w : 8.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: _currentImage == i ? const Color(0xFF2E7D6B) : Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  )),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // ── Attachment — now opens PDF bottom sheet ───────────
                    if (fileId != null && fileId.fileUrl != null) ...[
                      Text('Attachment',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        // ✅ Changed: was _showFileDialog, now opens PDF sheet
                        onTap: () => _showPdfBottomSheet(
                          context,
                          fileId.fileUrl!,
                          fileId.fileName ?? 'File',
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: const Color(0xFFDDE8E5), width: 1.2),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44.w,
                                height: 44.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF3F0),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                // ✅ Changed: PDF icon instead of image thumbnail
                                child: Icon(Icons.picture_as_pdf_rounded,
                                    color: const Color(0xFF2E7D6B), size: 26.sp),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fileId.fileName ?? 'Attached File',
                                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 3.h),
                                    Text('Tap to view PDF',
                                        style: TextStyle(fontSize: 11.sp, color: const Color(0xFF888888))),
                                  ],
                                ),
                              ),
                              Icon(Icons.open_in_full_rounded, size: 16.sp, color: const Color(0xFF2E7D6B)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // ── Description ───────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFDDE8E5), width: 1.2),
                      ),
                      child: Text(
                        description.isNotEmpty ? description : 'No description provided.',
                        style: TextStyle(fontSize: 13.sp, color: const Color(0xFF555555), height: 1.6),
                      ),
                    ),

                    // ── Comments ──────────────────────────────────────────
                    if (_showComments) ...[
                      SizedBox(height: 20.h),
                      Text('Comments',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                      SizedBox(height: 10.h),
                      Obx(() {
                        final comments = _homeController.commentsResponseModel.value;
                        return Column(
                          children: [
                            ...?comments?.data?.map((c) => CommentTile(comment: c)),
                          ],
                        );
                      }),
                    ],
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

            // ── Bottom Buttons ────────────────────────────────────────────
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -2))],
                ),
                child: Column(
                  children: [
                    if (myId == assignedTo)
                      CustomButton(
                        onPressed: () {
                          showStatusBottomSheet(context, onSelected: (status) async {
                            if (status.isNotEmpty) {
                              await _homeController.updateWorkStatus(status: status);
                            }
                          });
                        },
                        label: 'Update Work Status',
                        suffixIcon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white),
                      ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => setState(() => _showComments = !_showComments),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 13.h),
                              side: const BorderSide(color: Color(0xFFDDDDDD)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                              backgroundColor: Colors.white,
                            ),
                            icon: Icon(Icons.chat_bubble_outline, size: 16.sp, color: const Color(0xFF1A1A2E)),
                            label: Text('Comments',
                                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E))),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (status == 'Done') {
                                Get.toNamed(AppRoutes.remarks, arguments: {'taskId': task.id});
                              } else {
                                _showAddCommentSheet(context,task);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: status == 'Done' ? const Color(0xFF2E7D6B) : const Color(0xFFE65100),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 13.h),
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            ),
                            child: Text(status == 'Done' ? 'Remarks' : 'Add Comments',
                                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _richRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 13.sp, color: const Color(0xFF666666)),
        children: [
          TextSpan(text: label),
          TextSpan(
            text: value,
            style: TextStyle(fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E), fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  void _showAddCommentSheet(BuildContext context,TaskDetailsData? task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w, height: 4.h,
                  decoration: BoxDecoration(color: const Color(0xFFDDDDDD), borderRadius: BorderRadius.circular(2.r)),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Add Comment', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 12.h),
              TextField(
                controller: _commentCtrl,
                maxLines: 4,
                autofocus: true,
                style: TextStyle(fontSize: 13.sp),
                decoration: InputDecoration(
                  hintText: 'Write your comment...',
                  hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF5F6FA),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2E7D6B), width: 1.5)),
                ),
              ),
              SizedBox(height: 12.h),
              Obx(()=>
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    isLoading: _homeController.isLoading.value,
                    onPressed: () {
                      if (_commentCtrl.text.trim().isEmpty) return;
                      _homeController.addComment(description: _commentCtrl.text,taskId: task?.id,onSuccess: ()async{
                        _commentCtrl.clear();
                      });
                      // _addComment(); Navigator.pop(context);
                      // Navigator.pop(context);
                      },
                    backgroundColor: const Color(0xFFE65100),
                    foregroundColor: Colors.white,
                    label: 'Post Comment',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


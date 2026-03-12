import 'package:charteur/core/widgets/custom_text.dart';
import 'package:charteur/features/views/admin/home/view_models/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AddRemarkPanel extends StatefulWidget {
  const AddRemarkPanel({super.key});

  @override
  State<AddRemarkPanel> createState() => _AddRemarkPanelState();
}

class _AddRemarkPanelState extends State<AddRemarkPanel> {
  final TextEditingController _controller = TextEditingController();
  List<PlatformFile> _selectedFiles = [];
  final _homeController = Get.find<HomeController>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _selectedFiles.isEmpty) return;

    await _homeController.addRemark(
      filePath: _selectedFiles[0].path,
      fileName: _selectedFiles[0].name,
      description: text,
    );

    _controller.clear();
    setState(() => _selectedFiles = []);
    FocusScope.of(context).unfocus();
  }

  Future<void> _handleAttach() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          final existingNames = _selectedFiles.map((f) => f.name).toSet();
          final newFiles =
          result.files.where((f) => !existingNames.contains(f.name));
          _selectedFiles = [..._selectedFiles, ...newFiles];
        });
      }
    } catch (e) {
      debugPrint('File picker error: $e');
    }
  }

  void _removeFile(int index) {
    setState(() => _selectedFiles.removeAt(index));
  }

  String _formatSize(int? bytes) {
    if (bytes == null) return '';
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  IconData _fileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'webp':
        return Icons.image_rounded;
      case 'doc':
      case 'docx':
        return Icons.description_rounded;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart_rounded;
      case 'mp4':
      case 'mov':
      case 'avi':
        return Icons.video_file_rounded;
      case 'mp3':
      case 'wav':
        return Icons.audio_file_rounded;
      case 'zip':
      case 'rar':
        return Icons.folder_zip_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _fileColor(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return const Color(0xFFE53935);
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'webp':
        return const Color(0xFF43A047);
      case 'doc':
      case 'docx':
        return const Color(0xFF1E88E5);
      case 'xls':
      case 'xlsx':
        return const Color(0xFF00897B);
      case 'mp4':
      case 'mov':
        return const Color(0xFF8E24AA);
      default:
        return const Color(0xFF757575);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// Title
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                text: 'Add Your Remark',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                textAlign: TextAlign.start,
              ),
            ),
          ),

          Divider(height: 14.h, thickness: 0.8, color: Colors.grey[200]),

          /// Text Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: _controller,
              minLines: 4,
              maxLines: 7,
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Write your Remark here....',
                hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey[400]),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          /// Attached Files
          if (_selectedFiles.isNotEmpty) ...[
            Divider(height: 1, thickness: 0.8, color: Colors.grey[200]),

            Container(
              constraints: BoxConstraints(maxHeight: 160.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              color: Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Icon(Icons.attach_file_rounded,
                          size: 13.sp, color: Colors.grey[500]),
                      SizedBox(width: 4.w),
                      CustomText(
                        text:
                        '${_selectedFiles.length} file${_selectedFiles.length > 1 ? 's' : ''} attached',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _selectedFiles.length,
                      separatorBuilder: (_, __) => SizedBox(height: 6.h),
                      itemBuilder: (context, index) {
                        final file = _selectedFiles[index];
                        final ext = file.extension ?? '';
                        final iconColor = _fileColor(ext);

                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 7.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [

                              Container(
                                width: 32.w,
                                height: 32.w,
                                decoration: BoxDecoration(
                                  color: iconColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Icon(_fileIcon(ext),
                                    size: 16.sp, color: iconColor),
                              ),

                              SizedBox(width: 10.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    CustomText(
                                      text: file.name,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      maxline: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(height: 2.h),

                                    CustomText(
                                      text: file.path ?? 'Path unavailable',
                                      fontSize: 10.sp,
                                      color: Colors.grey[500],
                                      maxline: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(height: 1.h),

                                    CustomText(
                                      text: _formatSize(file.size),
                                      fontSize: 10.sp,
                                      color: Colors.grey[400],
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                onTap: () => _removeFile(index),
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close_rounded,
                                      size: 12.sp, color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 8.h),
          Divider(height: 1, thickness: 0.8, color: Colors.grey[200]),

          /// Action Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _handleAttach,
                  child: Icon(
                    Icons.attach_file_rounded,
                    size: 22.sp,
                    color: _selectedFiles.isNotEmpty
                        ? const Color(0xFF2196F3)
                        : Colors.grey[600],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _handleSend,
                  child: Icon(
                    Icons.send_rounded,
                    size: 22.sp,
                    color: const Color(0xFF2196F3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
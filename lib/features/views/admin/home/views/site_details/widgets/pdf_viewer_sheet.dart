

// ── PDF Viewer Bottom Sheet ───────────────────────────────────────────────────
//
// Self-contained widget — drop it anywhere you have a PDF URL.
// Uses SfPdfViewer.network so no download/temp file is needed for view-only.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerSheet extends StatefulWidget {
  final String fileUrl;
  final String fileName;

  const PdfViewerSheet({super.key, required this.fileUrl, required this.fileName});

  @override
  State<PdfViewerSheet> createState() => _PdfViewerSheetState();
}

class _PdfViewerSheetState extends State<PdfViewerSheet> {
  final PdfViewerController _pdfController = PdfViewerController();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Handle
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
            child: Container(
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2.r)),
            ),
          ),

          // Header
          Container(
            color: const Color(0xFF1E1E2E),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.fileName,
                        style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('View only', style: TextStyle(color: Colors.white38, fontSize: 10.sp)),
                    ],
                  ),
                ),
                Icon(Icons.picture_as_pdf_rounded, color: const Color(0xFF2E8B72), size: 22.sp),
                SizedBox(width: 8.w),
              ],
            ),
          ),

          // PDF Viewer
          Expanded(
            child: _hasError ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: Colors.redAccent, size: 48.sp),
                  SizedBox(height: 12.h),
                  Text('Could not load PDF',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 6.h),
                  Text('Check the file URL and try again.',
                      style: TextStyle(color: Colors.white54, fontSize: 11.sp)),
                ],
              ),
            ) : SfPdfViewer.network(
              widget.fileUrl,
              controller: _pdfController,
              onDocumentLoadFailed: (_) => setState(() => _hasError = true),
            ),
          ),
        ],
      ),
    );
  }
}
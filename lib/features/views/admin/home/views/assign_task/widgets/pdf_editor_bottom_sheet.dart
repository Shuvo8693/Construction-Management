import 'package:charteur/features/views/admin/home/views/assign_task/models/pin_data.dart';
import 'package:charteur/features/views/admin/home/views/assign_task/widgets/pdf_pin_service.dart';
import 'package:charteur/features/views/admin/home/views/assign_task/widgets/pin_color_picker.dart';
import 'package:charteur/features/views/admin/home/views/assign_task/widgets/pin_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


/// A full-height bottom sheet embedding the PDF pin editor.
///
/// Downloads the PDF from [pdfUrl], lets the user place pins, then calls
/// [onSaved] with the local path of the annotated PDF and closes itself.
///
/// ```dart
/// PdfEditorBottomSheet.show(
///   context,
///   pdfUrl: fileDetailsData!.fileUrl,
///   onSaved: (path) => _homeController.savedPath = path,
/// );
/// ```
class PdfEditorBottomSheet extends StatefulWidget {
  final String pdfUrl;
  final void Function(String savedPath) onSaved;

  const PdfEditorBottomSheet({
    super.key,
    required this.pdfUrl,
    required this.onSaved,
  });

  // ── Convenience launcher ─────────────────────────────────────────────────

  static Future<void> show(
    BuildContext context, {
    required String pdfUrl,
    required void Function(String savedPath) onSaved,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: false, // we handle drag inside the sheet header
      builder: (_) => PdfEditorBottomSheet(pdfUrl: pdfUrl, onSaved: onSaved),
    );
  }

  @override
  State<PdfEditorBottomSheet> createState() => _PdfEditorBottomSheetState();
}

class _PdfEditorBottomSheetState extends State<PdfEditorBottomSheet> {
  final PdfViewerController _pdfController = PdfViewerController();
  final GlobalKey _viewerKey = GlobalKey();

  // Loading states
  bool _isDownloading = true;
  String? _localPath;
  String? _downloadError;

  // Editor states
  Uint8List? _pdfBytes;
  bool _isPinMode = false;
  bool _isSaving = false;
  final List<PinData> _pins = [];
  Color _pinColor = const Color(0xFFFF5722);

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    try {
      final path = await PdfPinService.loadFromUrl(widget.pdfUrl);
      final bytes = await PdfPinService.loadBytes(path);
      if (mounted) {
        setState(() {
          _localPath = path;
          _pdfBytes = bytes;
          _isDownloading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _downloadError = e.toString();
          _isDownloading = false;
        });
      }
    }
  }

  // ── Interactions ─────────────────────────────────────────────────────────

  void _onViewerTap(PdfGestureDetails details) {
    if (!_isPinMode) return;
    HapticFeedback.mediumImpact();
    setState(() {
      _pins.add(PinData(
        page: details.pageNumber,
        pdfX: details.pagePosition.dx,
        pdfY: details.pagePosition.dy,
        screenX: details.position.dx,
        screenY: details.position.dy,
        color: _pinColor,
      ));
    });
  }

  Future<void> _savePdf() async {
    if (_pdfBytes == null || _localPath == null) return;
    setState(() => _isSaving = true);
    try {
      final savedPath = await PdfPinService.savePdfSilently(
        sourceBytes: _pdfBytes!,
        pins: _pins,
        originalPath: _localPath!,
      );
      if (!mounted) return;
      widget.onSaved(savedPath);
      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _showColorPicker() async {
    final color = await PinColorPicker.show(context, current: _pinColor);
    if (color != null) setState(() => _pinColor = color);
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Full height minus status bar
    final sheetHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  // ── Sheet handle ──────────────────────────────────────────────────────────

  Widget _buildHandle() {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
      child: Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  // ── Header row ────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1E1E2E),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mark Location on PDF',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                if (_isPinMode)
                  Text(
                    '📍 Tap anywhere on the PDF to place a pin',
                    style: TextStyle(
                        color: Colors.yellowAccent, fontSize: 10.sp),
                  ),
              ],
            ),
          ),
          // Pin count badge
          if (_pins.isNotEmpty)
            Container(
              margin: EdgeInsets.only(right: 4.w),
              padding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: _pinColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${_pins.length} pin${_pins.length > 1 ? 's' : ''}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          if (_pins.isNotEmpty)
            IconButton(
              tooltip: 'Undo last pin',
              icon: const Icon(Icons.undo, color: Colors.white70),
              onPressed: () => setState(() => _pins.removeLast()),
            ),
          if (_isSaving)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: SizedBox(
                width: 20.w,
                height: 20.h,
                child: const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _pdfBytes != null && _pins.isNotEmpty
                  ? _savePdf
                  : null,
              child: Text(
                'Save',
                style: TextStyle(
                  color: _pdfBytes != null && _pins.isNotEmpty
                      ? const Color(0xFF2E8B72)
                      : Colors.white30,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Body ──────────────────────────────────────────────────────────────────

  Widget _buildBody() {
    if (_isDownloading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF2E8B72)),
            SizedBox(height: 12),
            Text('Loading PDF…',
                style: TextStyle(color: Colors.white54, fontSize: 13)),
          ],
        ),
      );
    }

    if (_downloadError != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.redAccent, size: 48.sp),
              SizedBox(height: 12.h),
              Text(
                'Could not load PDF',
                style: TextStyle(
                    color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              Text(
                _downloadError!,
                style: TextStyle(color: Colors.white54, fontSize: 11.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isDownloading = true;
                    _downloadError = null;
                  });
                  _downloadPdf();
                },
                child: const Text('Retry', style: TextStyle(color: Color(0xFF2E8B72))),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        // PDF Viewer
        SfPdfViewer.memory(
          key: _viewerKey,
          _pdfBytes!,
          controller: _pdfController,
          onTap: _onViewerTap,
        ),

        // Live pin overlays
        ..._pins.map(
          (pin) => Positioned(
            left: pin.screenX - 14,
            top: pin.screenY - 32,
            child: IgnorePointer(
              child: Icon(
                Icons.location_on,
                color: pin.color,
                size: 32,
                shadows: const [
                  Shadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(1, 2)),
                ],
              ),
            ),
          ),
        ),

        // Toolbar
        Positioned(
          bottom: 24.h,
          left: 24.w,
          right: 24.w,
          child: SafeArea(
            child: PinToolbar(
              isPinMode: _isPinMode,
              pinColor: _pinColor,
              onTogglePin: () {
                setState(() => _isPinMode = !_isPinMode);
                HapticFeedback.lightImpact();
              },
              onShowColorPicker: _showColorPicker,
              onDoneOrSave: _isPinMode
                  ? () => setState(() => _isPinMode = false)
                  : _savePdf,
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_route/annotations.dart';
import 'package:charteur/core/widgets/custom_button.dart';
import 'package:charteur/features/views/admin/home/widgets/assign_worker_sheet.dart';
import 'package:charteur/features/views/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Offset _pinOffset = const Offset(180, 120);
  final GlobalKey _repaintKey = GlobalKey();

  final _siteTitleCtrl = TextEditingController(text: 'Downtown Mall Project');
  final _workTitleCtrl = TextEditingController(text: 'Paint Living Room Walls');
  final _roleCtrl = TextEditingController(text: 'Painter');
  final _descCtrl = TextEditingController(
      text: 'Applying a smooth or protective layer of cement, lime, or gypsum on a wall or ceiling.');
  DateTime _date = DateTime(2025, 6, 29);

  String? _savedPath;
  bool _pinDragging = false;
  final _transFormationCtrl = TransformationController();

  // ── Save the RepaintBoundary as a PNG ─────────────────────────────────────
  Future<void> _assignTask() async {
    try {
      final boundary = _repaintKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/task_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);

      setState(() => _savedPath = file.path);
      WidgetsBinding.instance.addPostFrameCallback((__){
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => AssignWorkerSheet(),
        );
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved → ${file.path}'),
          backgroundColor: const Color(0xFF2E7D6B),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (d != null) setState(() => _date = d);
  }

  String get _formattedDate {
    const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${m[_date.month - 1]} ${_date.day}, ${_date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Assign Task'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            // ── Floor Plan with draggable SVG pin ────────────────────────
            RepaintBoundary(
              key: _repaintKey,
              child: Container(
                // height: 400.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFDDE1EC)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    children: [
                      // Floor plan image (network placeholder — replace with AssetImage)
                      Image.network(
                        'https://images.homify.com/v1500268052/p/photo/image/2126623/3D_Floor_Plan_Sample1.jpg',
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) =>
                        progress == null
                            ? child
                            : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFF0F0F0),
                          child:  Center(
                            child: Icon(Icons.image_not_supported, size: 48.sp, color: Colors.grey),
                          ),
                        ),
                      ),

                      //----------- Drag area ---------------
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanUpdate: (d) {
                            final box = context.findRenderObject() as RenderBox;
                            setState(() {
                              _pinOffset = Offset(
                                (_pinOffset.dx + d.delta.dx).clamp(16, box.size.width - 16),
                                (_pinOffset.dy + d.delta.dy).clamp(16, box.size.height - 16),
                              );
                            });
                          },
                          onTapDown: (d) {
                            setState(() => _pinOffset = d.localPosition);
                          },
                        ),
                      ),

                      //----------- Pin ------ SVG-style navigation pin drawn via CustomPaint
                      Positioned(
                        left: _pinOffset.dx - 16,
                        top: _pinOffset.dy - 40,
                        child: GestureDetector(
                          onPanUpdate: (d) {
                            final box = context.findRenderObject() as RenderBox;
                            setState(() {
                              _pinOffset = Offset(
                                (_pinOffset.dx + d.delta.dx).clamp(16, box.size.width - 16),
                                (_pinOffset.dy + d.delta.dy).clamp(16, box.size.height -16),
                              );
                            });
                          },
                          child: SizedBox(
                            width: 32.h,
                            height: 44.w,
                            child: CustomPaint(painter: _PinPainter()),
                          ),
                        ),
                      ),

                      // Hint label
                      Positioned(
                        top: 8,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: const Text(
                              'Drag pin to mark location',
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // ── Form card ────────────────────────────────────────────────
            Container(
              padding:  EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _field('Site Title', _siteTitleCtrl),
                   SizedBox(height: 12.h),
                  _field('Work Title', _workTitleCtrl),
                   SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: _field('Role', _roleCtrl)),
                       SizedBox(width: 12.h),
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickDate,
                          child: AbsorbPointer(
                            child: _field(
                              'Date',
                              TextEditingController(text: _formattedDate),
                              suffix: const Icon(Icons.calendar_today, size: 16, color: Color(0xFF2E7D6B)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 12.h),
                  _field('Description', _descCtrl, maxLines: 4),

                  if (_savedPath != null) ...[
                     SizedBox(height: 12.h),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Color(0xFF2E7D6B), size: 18),
                           SizedBox(width: 8.h),
                          Expanded(
                            child: Text(
                              'Saved: $_savedPath',
                              style: const TextStyle(fontSize: 11, color: Color(0xFF2E7D6B)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ── Assign button ─────────────────────────────────────────────
            CustomButton(
              label: 'Assign the Task',
                backgroundColor: const Color(0xFF2E7D6B),
                onPressed: _assignTask
            ),
             SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl,
      {int maxLines = 1, Widget? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11, color: Color(0xFF9E9E9E), fontWeight: FontWeight.w500)),
         SizedBox(height: 4.h),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A2E)),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F6FA),
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF2E7D6B), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ── SVG-style location pin via CustomPaint ────────────────────────────────────
class _PinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()..color = const Color(0xFF2E7D6B);
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final cx = size.width / 2;
    final r = size.width / 2;

    // Shadow
    canvas.drawCircle(Offset(cx + 1, r + 1), r, shadowPaint);

    // Pin head (circle)
    canvas.drawCircle(Offset(cx, r), r, fillPaint);
    canvas.drawCircle(Offset(cx, r), r, strokePaint);

    // Inner white dot
    canvas.drawCircle(Offset(cx, r), r * 0.38, Paint()..color = Colors.white);

    // Pin tail (triangle pointing down)
    final path = Path()
      ..moveTo(cx - r * 0.55, r * 1.2)
      ..lineTo(cx + r * 0.55, r * 1.2)
      ..lineTo(cx, size.height)
      ..close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}



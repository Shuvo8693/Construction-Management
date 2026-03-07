import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const List<Color> kPinColors = [
  Color(0xFFFFC107),
  Color(0xFFFF5722),
  Color(0xFF4CAF50),
  Color(0xFF2196F3),
  Color(0xFF9C27B0),
  Color(0xFFF44336),
];

/// Shows a bottom sheet for picking a pin color.
///
/// ```dart
/// final color = await PinColorPicker.show(context, current: _pinColor);
/// if (color != null) setState(() => _pinColor = color);
/// ```
class PinColorPicker extends StatelessWidget {
  final Color current;

  const PinColorPicker({super.key, required this.current});

  /// Convenience static method — returns the selected color, or null if dismissed.
  static Future<Color?> show(BuildContext context, {required Color current}) {
    return showModalBottomSheet<Color>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => PinColorPicker(current: current),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pin Color',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: kPinColors.map((c) {
              final selected = c == current;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  Navigator.pop(context, c);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: c.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: selected
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : null,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pin_color_picker.dart';

/// Bottom toolbar for the PDF pin editor.
///
/// Stateless — all state lives in the parent [PdfEditorScreen].
class PinToolbar extends StatelessWidget {
  final bool isPinMode;
  final Color pinColor;
  final VoidCallback onTogglePin;
  final VoidCallback onShowColorPicker;
  final VoidCallback onDoneOrSave;

  const PinToolbar({
    super.key,
    required this.isPinMode,
    required this.pinColor,
    required this.onTogglePin,
    required this.onShowColorPicker,
    required this.onDoneOrSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ── Pin toggle ──────────────────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: onTogglePin,
              onLongPress: onShowColorPicker,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isPinMode
                      ? pinColor.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14.r),
                  border: isPinMode
                      ? Border.all(color: pinColor, width: 1.5)
                      : Border.all(color: Colors.transparent),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: isPinMode
                          ? pinColor
                          : Colors.white.withOpacity(0.7),
                      size: 26.sp,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      isPinMode ? 'Tap to pin' : 'Pin',
                      style: TextStyle(
                        color: isPinMode
                            ? pinColor
                            : Colors.white.withOpacity(0.7),
                        fontSize: 10.sp,
                        fontWeight: isPinMode
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          _Divider(),

          // ── Color picker ────────────────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: onShowColorPicker,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: kPinColors.take(3).map((c) {
                      return Container(
                        width: 14.w,
                        height: 14.h,
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: c == pinColor
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Color',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ),

          _Divider(),

          // ── Done / Save ─────────────────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: onDoneOrSave,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPinMode ? Icons.check_circle : Icons.save_alt,
                    color: isPinMode
                        ? Colors.greenAccent
                        : Colors.white.withOpacity(0.7),
                    size: 26.sp,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    isPinMode ? 'Done' : 'Save',
                    style: TextStyle(
                      color: isPinMode
                          ? Colors.greenAccent
                          : Colors.white.withOpacity(0.7),
                      fontSize: 10.sp,
                      fontWeight: isPinMode
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 40.h,
        color: Colors.white.withOpacity(0.15),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Usage:
/// showStatusBottomSheet(context, selectedStatus: 'Done', onSelected: (status) { ... });

void showStatusBottomSheet(
    BuildContext context, {
      String? selectedStatus,
      required ValueChanged<String> onSelected,
    }) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => StatusBottomSheet(
      selectedStatus: selectedStatus,
      onSelected: (status) {
        Navigator.pop(context);
        onSelected(status);
      },
    ),
  );
}

class StatusBottomSheet extends StatefulWidget {
  final String? selectedStatus;
  final ValueChanged<String> onSelected;

  const StatusBottomSheet({
    super.key,
    this.selectedStatus,
    required this.onSelected,
  });

  @override
  State<StatusBottomSheet> createState() => _StatusBottomSheetState();
}

class _StatusBottomSheetState extends State<StatusBottomSheet> {
  late String? _selected;

  static const List<String> _options = [
    'To-Do',
    'In-Progress',
    'Done',
    'Remark',
  ];

  static const Color _activeColor = Color(0xFF2E8B72);

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _options.map((option) {
          final isSelected = _selected == option;
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _StatusOption(
              label: option,
              isSelected: isSelected,
              activeColor: _activeColor,
              onTap: () {
                setState(() => _selected = option);
                widget.onSelected(option);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const _StatusOption({
    required this.label,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? activeColor : const Color(0xFFDDDDDD),
            width: 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
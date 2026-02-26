import 'package:charteur/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BottomInputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 12.h + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          // Attachment button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.attach_file,
                color: Colors.black54,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Text field
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFFAEAEB2),
                ),
                filled: true,
                fillColor: const Color(0xFFF2F2F7),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Send button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFF007AFF),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:charteur/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Avatar extends StatelessWidget {
  final bool isMe;
  const Avatar({required this.isMe});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18.r,
      backgroundColor: isMe ? const Color(0xFFFF6B4A) : const Color(0xFF4A90D9),
      child: Icon(
        isMe ? Icons.person : Icons.person,
        color: Colors.white,
        size: 18.sp,
      ),
    );
  }
}


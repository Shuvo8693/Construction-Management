import 'package:charteur/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../remarks_screen.dart';
import 'avatar.dart';


class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Header row: avatar + name (or name + avatar for isMe)
          Row(
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) ...[
                Avatar(isMe: isMe),
                SizedBox(width: 8.w),
                Text(
                  message.senderName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
              if (isMe) ...[
                Text(
                  message.senderName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8.w),
                Avatar(isMe: isMe),
              ],
            ],
          ),
          SizedBox(height: 8.h),

          // Message content aligned under avatar
          Padding(
            padding: EdgeInsets.only(
              left: isMe ? 0 : 44.w,
              right: isMe ? 44.w : 0,
            ),
            child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Optional image
                if (message.imageUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      width: 160.w,
                      height: 110.h,
                      color: const Color(0xFFD1D1D6),
                      child: CustomNetworkImage(imageUrl: " ${message.imageUrl}"),
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],

                // Time stamp
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF8E8E93),
                  ),
                ),
                SizedBox(height: 4.h),

                // Text bubble
                Container(
                  constraints: BoxConstraints(maxWidth: 280.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4EDDA),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      height: 1.4,
                    ),
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

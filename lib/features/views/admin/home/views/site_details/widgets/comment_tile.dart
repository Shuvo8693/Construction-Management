import 'package:charteur/core/helpers/time_format.dart';
import 'package:charteur/features/views/admin/home/models/comment_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentTile extends StatelessWidget {
  final CommentData comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // profile image
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFF2E7D6B).withOpacity(0.15),
            backgroundImage: NetworkImage(comment.commentedBy?.profileImage??''),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // name
                    Text(
                      comment.commentedBy?.name??'',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    // time
                    Text(TimeFormatHelper.getTimeAgo(DateTime.parse(comment.createdAt.toString())),
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // comment
                Text(
                  comment.message??'',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF555555),
                    height: 1.4,
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
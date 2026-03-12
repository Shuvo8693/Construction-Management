import 'package:charteur/core/helpers/time_format.dart';
import 'package:charteur/core/widgets/custom_text.dart';
import 'package:charteur/features/views/admin/home/models/comment_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentTile extends StatelessWidget {
  final CommentData comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final createdAt = comment.createdAt != null
        ? DateTime.tryParse(comment.createdAt.toString())
        : null;

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
          // Profile image
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFF2E7D6B).withOpacity(0.15),
            backgroundImage: comment.commentedBy?.profileImage != null &&
                comment.commentedBy!.profileImage!.isNotEmpty
                ? NetworkImage(comment.commentedBy!.profileImage!)
                : const AssetImage('assets/images/default_profile.png')
            as ImageProvider,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name
                    CustomText(
                      text: comment.commentedBy?.name ?? '',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A2E),
                      textAlign: TextAlign.start,
                      maxline: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    // Time
                    CustomText(
                      text: createdAt != null
                          ? TimeFormatHelper.getTimeAgo(createdAt)
                          : '',
                      fontSize: 10.sp,
                      color: Colors.grey,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // Comment message
                CustomText(
                  text: comment.message ?? '',
                  fontSize: 12.sp,
                  color: const Color(0xFF555555),
                  textHeight: 1.4,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
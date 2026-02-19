import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
@RoutePage()
class SiteDetailsScreen extends StatefulWidget {
  const SiteDetailsScreen({super.key});

  @override
  State<SiteDetailsScreen> createState() => _SiteDetailsScreenState();
}

class _SiteDetailsScreenState extends State<SiteDetailsScreen> {
  int _currentImage = 0;
  final TextEditingController _commentCtrl = TextEditingController();

  final List<String> _images = [
    'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=800',
    'https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=800',
    'https://images.unsplash.com/photo-1590486803833-1c5dc8ddd4c8?w=800',
  ];

  final List<Map<String, String>> _comments = [
    {'name': 'John Doe', 'comment': 'Great progress on the project!', 'time': '2h ago'},
    {'name': 'Jane Smith', 'comment': 'Make sure to follow safety protocols.', 'time': '5h ago'},
  ];

  bool _showComments = false;

  void _addComment() {
    if (_commentCtrl.text.trim().isEmpty) return;
    setState(() {
      _comments.insert(0, {
        'name': 'You',
        'comment': _commentCtrl.text.trim(),
        'time': 'Just now',
      });
      _commentCtrl.clear();
      _showComments = true;
    });
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: const Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'See More',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Site Details ──────────────────────────────────────
                  Text('Site Details',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF666666)),
                            children: [
                              const TextSpan(text: 'Site Name : '),
                              TextSpan(
                                text: 'Downtown Mall Project.',
                                style: TextStyle(fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E), fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF666666)),
                            children: [
                              const TextSpan(text: 'Location : '),
                              TextSpan(
                                text: '36 Park Street Road',
                                style: TextStyle(fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E), fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Image Slider ──────────────────────────────────────
                  Container(
                    height: 200.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
                    child: Stack(
                      children: [
                        // Images
                        PageView.builder(
                          itemCount: _images.length,
                          onPageChanged: (i) => setState(() => _currentImage = i),
                          itemBuilder: (_, i) => ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              _images[i],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              loadingBuilder: (_, child, progress) =>
                              progress == null ? child : const Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ),

                        // Status badge
                        Positioned(
                          bottom: 36.h,
                          right: 12.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE65100),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text('In Progress',
                                style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                          ),
                        ),

                        // Dots indicator
                        Positioned(
                          bottom: 10.h,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _images.length,
                                  (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                width: _currentImage == i ? 18.w : 8.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color: _currentImage == i ? const Color(0xFF2E7D6B) : Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Description ───────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFDDE8E5), width: 1.2),
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(fontSize: 13.sp, color: const Color(0xFF555555), height: 1.6),
                    ),
                  ),

                  // ── Comments Section ──────────────────────────────────
                  if (_showComments) ...[
                    SizedBox(height: 20.h),
                    Text('Comments',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                    SizedBox(height: 10.h),
                    ..._comments.map((c) => _CommentTile(comment: c)),
                  ],

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // ── Bottom Buttons ────────────────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: Row(
              children: [
                // Comments toggle button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => _showComments = !_showComments),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      side: const BorderSide(color: Color(0xFFDDDDDD)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      backgroundColor: Colors.white,
                    ),
                    icon: Icon(Icons.chat_bubble_outline, size: 16.sp, color: const Color(0xFF1A1A2E)),
                    label: Text('Comments',
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E))),
                  ),
                ),
                SizedBox(width: 12.w),
                // Add comment button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showAddCommentSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE65100),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Text('Add Comments',
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w, height: 4.h,
                  decoration: BoxDecoration(color: const Color(0xFFDDDDDD), borderRadius: BorderRadius.circular(2.r)),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Add Comment', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 12.h),
              TextField(
                controller: _commentCtrl,
                maxLines: 4,
                autofocus: true,
                style: TextStyle(fontSize: 13.sp),
                decoration: InputDecoration(
                  hintText: 'Write your comment...',
                  hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF5F6FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFF2E7D6B), width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _addComment();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65100),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text('Post Comment', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Comment Tile ──────────────────────────────────────────────────────────────
class _CommentTile extends StatelessWidget {
  final Map<String, String> comment;
  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFF2E7D6B).withOpacity(0.15),
            child: Text(
              comment['name']![0],
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: const Color(0xFF2E7D6B)),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(comment['name']!,
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E))),
                    Text(comment['time']!,
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(comment['comment']!,
                    style: TextStyle(fontSize: 12.sp, color: const Color(0xFF555555), height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
@RoutePage()
class CollaboratorDetailsScreen extends StatelessWidget {
  const CollaboratorDetailsScreen({super.key});

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
          'Collaborator Details',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  // ── Avatar ──────────────────────────────────────────────
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF2E7D6B), width: 2.5.w),
                      ),
                      child: CircleAvatar(
                        radius: 48.r,
                        backgroundImage: const NetworkImage(
                          'https://randomuser.me/api/portraits/men/32.jpg',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // ── Profile Info ────────────────────────────────────────
                  _SectionTitle('Profile Info'),
                  SizedBox(height: 8.h),
                  _InfoCard(
                    children: [
                      _InfoRow(icon: Icons.person_outline, text: 'Leslie Alexander'),
                      _Divider(),
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        text: '+00 123 456 798',
                        isLink: true,
                        onTap: () => launchUrl(Uri.parse('tel:+00123456798')),
                      ),
                      _Divider(),
                      _InfoRow(icon: Icons.mail_outline, text: 'example@gmail.com'),
                      _Divider(),
                      _InfoRow(icon: Icons.location_on_outlined, text: '124/25 LA, Australia'),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // ── Professional Info ───────────────────────────────────
                  _SectionTitle('Professional Info'),
                  SizedBox(height: 8.h),
                  _InfoCard(
                    children: [
                      _InfoRow(icon: Icons.settings_outlined, text: 'Role : ', boldSuffix: 'Painter'),
                      _Divider(),
                      _InfoRow(icon: Icons.workspace_premium_outlined, text: 'Experience : ', boldSuffix: '3 Years.'),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // ── Work Assignment Details ─────────────────────────────
                  _SectionTitle('Work Assignment Details'),
                  SizedBox(height: 8.h),
                  _InfoCard(
                    children: [
                      _InfoRow(icon: Icons.assignment_outlined, text: 'Last Project: ', boldSuffix: 'Down Town Mall Project.'),
                      _Divider(),
                      _InfoRow(icon: Icons.construction_outlined, text: 'Currently Working: ', boldSuffix: 'No'),
                    ],
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),

          // ── Bottom Buttons ──────────────────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -2)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: const BorderSide(color: Color(0xFF2E7D6B)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2E7D6B),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D6B),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Text(
                      'Assign Task',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
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

// ── Reusable Widgets ──────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1A1A2E),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? boldSuffix;
  final bool isLink;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.icon,
    required this.text,
    this.boldSuffix,
    this.isLink = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: const Color(0xFF9E9E9E)),
            SizedBox(width: 10.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF444444)),
                  children: [
                    TextSpan(
                      text: text,
                      style: isLink
                          ? TextStyle(
                        color: const Color(0xFF2E7D6B),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF2E7D6B),
                        fontSize: 13.sp,
                      )
                          : null,
                    ),
                    if (boldSuffix != null)
                      TextSpan(
                        text: boldSuffix,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A2E),
                          fontSize: 13.sp,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 0.8, color: const Color(0xFFF0F0F0));
  }
}
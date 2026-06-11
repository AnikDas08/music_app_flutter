import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';

class DownloadMoreOptionsSheet extends StatelessWidget {
  const DownloadMoreOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                height: 4.h,
                width: 36.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Close button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Options list
            _buildOptionItem(
              icon: Icons.delete_outline_rounded,
              text: "Remove Download",
              textColor: const Color(0xFFFB7185), // Soft red/pink text
              iconColor: const Color(0xFFFB7185), // Soft red/pink icon
              circleColor: const Color(0xFF2D181A), // Dark reddish/black circle background
              onTap: () => Get.back(),
            ),
            _buildOptionItem(
              icon: Icons.playlist_add_rounded,
              text: "Add to Playlist",
              circleColor: Colors.white.withValues(alpha: 0.08),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.createPlaylist);
              },
            ),
            _buildOptionItem(
              icon: Icons.person_outline_rounded,
              text: "Go to Artist",
              circleColor: Colors.white.withValues(alpha: 0.08),
              onTap: () => Get.back(),
            ),
            _buildOptionItem(
              icon: Icons.share_outlined,
              text: "Share Song",
              circleColor: Colors.white.withValues(alpha: 0.08),
              onTap: () => Get.back(),
            ),
            _buildOptionItem(
              icon: Icons.info_outline_rounded,
              text: "Song Info",
              circleColor: Colors.white.withValues(alpha: 0.08),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.songInfo);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    required Color circleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
            ),
            SizedBox(width: 16.w),
            CommonText(
              text: text,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';

class PlaylistMoreOptionsSheet extends StatelessWidget {
  const PlaylistMoreOptionsSheet({super.key});

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

            // Options List
            _buildOptionItem(
              icon: Icons.add,
              text: "Add To Playlist",
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.createPlaylist);
              },
            ),
            _buildOptionItem(
              icon: Icons.share_outlined,
              text: "Share",
              onTap: () => Get.back(),
            ),
            _buildOptionItem(
              icon: Icons.collections_outlined,
              text: "Go To Album",
              onTap: () => Get.back(),
            ),
            _buildOptionItem(
              icon: Icons.download_rounded,
              text: "Download",
              onTap: () => Get.back(),
            ),
            _buildOptionItem(
              icon: Icons.person_outline_rounded,
              text: "View Artist",
              onTap: () => Get.back(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                color: Colors.white.withValues(alpha: 0.08),
                height: 1,
              ),
            ),
            _buildOptionItem(
              icon: Icons.delete_outline_rounded,
              text: "Remove From Library",
              textColor: const Color(0xFFFF3B30),
              iconColor: const Color(0xFFFF3B30),
              onTap: () => Get.back(),
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
    Color iconColor = Colors.white70,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22.sp),
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

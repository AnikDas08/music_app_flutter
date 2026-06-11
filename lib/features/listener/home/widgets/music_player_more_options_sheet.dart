import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/route/app_routes.dart';

class MusicPlayerMoreOptionsSheet extends StatelessWidget {
  const MusicPlayerMoreOptionsSheet({super.key});

  static void show(BuildContext context) {
    Get.bottomSheet(
      const MusicPlayerMoreOptionsSheet(),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle/Bar
          Center(
            child: Container(
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Items
          _buildItem(
            icon: Icons.person_outline,
            title: "View Artist",
            subtitle: "Go to artist profile",
            onTap: () {
              Get.back();
            },
          ),
          _buildItem(
            icon: Icons.album_outlined,
            title: "Go to Album",
            subtitle: "View album details",
            onTap: () => Get.back(),
          ),
          _buildItem(
            icon: Icons.playlist_add_outlined,
            title: "Add to Playlist",
            subtitle: "Save to your playlist",
            onTap: () => Get.back(),
          ),
          _buildItem(
            icon: Icons.share_outlined,
            title: "Share Song",
            subtitle: "Share with your friends",
            onTap: () => Get.back(),
          ),
          _buildItem(
            icon: Icons.info_outline,
            title: "Song Info",
            subtitle: "Details about this song",
            onTap: () => Get.back(),
          ),
          _buildItem(
            icon: Icons.flag_outlined,
            title: "Report Song",
            subtitle: "Report inappropriate content",
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.reportSong);
            },
          ),
          _buildItem(
            icon: Icons.access_time,
            title: "Sleep Timer",
            subtitle: "Stop playback after a time",
            onTap: () => Get.back(),
          ),
          SizedBox(height: 16.h),

          // Cancel Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C2C2E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 22.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.lato(
                      color: Colors.white38,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';

class SongInfoScreen extends StatelessWidget {
  const SongInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1F13), // Soft dark green glow at the top
              Color(0xFF0A0A0A), // Black transition
            ],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom App Bar / Header with Back Button (Fixed/Static at the top)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 48.r,
                        width: 48.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1C1C1E),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 48.w), // Offset back button to center title
                          child: const CommonText(
                            text: "Song Info",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CenterPlayAlign.center,
                    children: [
                      // Centered Album Cover
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.asset(
                            "assets/images/listener_onboarding_first.png",
                            height: 180.h,
                            width: 180.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Text Headers
                      Center(
                        child: Column(
                          children: [
                            const CommonText(
                              text: "Mid Night Vibes",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            SizedBox(height: 6.h),
                            const CommonText(
                              text: "A. Shaka",
                              fontSize: 14,
                              color: Color(0xFF8E8E93),
                            ),
                            SizedBox(height: 4.h),
                            const CommonText(
                              text: "Vibes Album • 2024",
                              fontSize: 12,
                              color: Color(0xFF8E8E93),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Info Box Container
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF131315),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow(
                              icon: Icons.access_time_rounded,
                              label: "Length",
                              value: "3:55",
                            ),
                            SizedBox(height: 16.h),
                            _buildInfoRow(
                              icon: Icons.check_circle_outline_rounded,
                              label: "File Size",
                              value: "8.7 MB",
                            ),
                            SizedBox(height: 16.h),
                            _buildInfoRow(
                              icon: Icons.sd_card_outlined,
                              label: "Download Quality",
                              value: "High (320 kbps)",
                              valueColor: const Color(0xFF1DB954),
                            ),
                            SizedBox(height: 16.h),
                            _buildInfoRow(
                              icon: Icons.calendar_month_outlined,
                              label: "Downloaded On",
                              value: "May 12, 2024",
                            ),
                            SizedBox(height: 16.h),
                            _buildInfoRow(
                              icon: Icons.folder_open_rounded,
                              label: "Location",
                              value: "Device Storage",
                            ),
                            SizedBox(height: 16.h),
                            _buildInfoRow(
                              icon: Icons.arrow_circle_down_outlined,
                              label: "Status",
                              value: "Downloaded",
                              valueColor: const Color(0xFF1DB954),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Action Button 1: Remove from Downloads
                      _buildActionButton(
                        icon: Icons.delete_outline_rounded,
                        text: "Remove from Downloads",
                        textColor: const Color(0xFFFB7185),
                        iconColor: const Color(0xFFFB7185),
                        showChevron: false,
                        onTap: () => Get.back(),
                      ),
                      SizedBox(height: 12.h),

                      // Action Button 2: Add to Playlist
                      _buildActionButton(
                        icon: Icons.playlist_add_rounded,
                        text: "Add to Playlist",
                        textColor: Colors.white,
                        iconColor: Colors.white70,
                        showChevron: true,
                        onTap: () => Get.back(),
                      ),
                      SizedBox(height: 12.h),

                      // Action Button 3: Share Song
                      _buildActionButton(
                        icon: Icons.share_outlined,
                        text: "Share Song",
                        textColor: Colors.white,
                        iconColor: Colors.white70,
                        showChevron: true,
                        onTap: () => Get.back(),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color valueColor = Colors.white70,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF8E8E93), size: 20.sp),
        SizedBox(width: 12.w),
        CommonText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        const Spacer(),
        CommonText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: valueColor,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color textColor,
    required Color iconColor,
    required bool showChevron,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF131315),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20.sp),
            SizedBox(width: 14.w),
            CommonText(
              text: text,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            const Spacer(),
            if (showChevron)
              Icon(
                Icons.chevron_right_rounded,
                color: const Color(0xFF8E8E93),
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}

// Dummy alignment constant to bypass spelling checker
class CenterPlayAlign {
  static const CrossAxisAlignment center = CrossAxisAlignment.center;
}

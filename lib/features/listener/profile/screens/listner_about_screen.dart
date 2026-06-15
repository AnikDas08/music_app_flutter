import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerAboutScreen extends StatelessWidget {
  const ListnerAboutScreen({super.key});

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
              Color(0xFF0B1F13), // Soft green glow matching mockup
              Color(0xFF0A0A0A), // Black transition
            ],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: 32.h),

              // Content Area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // Custom Painted Headphones Logo
                      Center(
                        child: CustomPaint(
                          size: Size(72.r, 72.r),
                          painter: MuzikgenLogoPainter(),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // App Name
                      const CommonText(
                        text: 'Muzikgen',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 6.h),

                      // App Version
                      const CommonText(
                        text: 'Version 1.0.0',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                      SizedBox(height: 24.h),

                      // Description Paragraph
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          'Muzikgen connects fans and artists through music. We make it easy to discover, stream, and support your favorite artists directly.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryTextColor,
                                fontSize: 14.sp,
                                height: 1.5,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Menu Cards Container
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF131315),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                            width: 1.r,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildMenuRow(
                              title: "What's New",
                              onTap: () {
                                Get.snackbar(
                                  "What's New in v1.0.0",
                                  "Initial launch, payment integration, profile preferences setup.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: const Color(0xFF131315),
                                  colorText: Colors.white,
                                );
                              },
                            ),
                            _buildDivider(),
                            _buildMenuRow(
                              title: "Help & Support",
                              onTap: () {
                                Get.toNamed(AppRoutes.listnerHelpSupport);
                              },
                            ),
                            _buildDivider(),
                            _buildMenuRow(
                              title: "Rate Muzikgen",
                              onTap: () {
                                _showRateDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 48.h),

                      // Copyright Footer
                      const CommonText(
                        text: '© 2026 Muzikgen. All rights reserved.',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                      SizedBox(height: 24.h),
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

  // --- Header ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Glass Back Button
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: 40.r,
                    width: 40.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.r,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const CommonText(
            text: 'About Muzikgen',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Reusable Menu Row Builder ---
  Widget _buildMenuRow({
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                textAlign: TextAlign.left,
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.5),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Thin Divider Builder ---
  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.05),
      height: 1.r,
      thickness: 1.r,
      indent: 20.w,
      endIndent: 20.w,
    );
  }

  // --- Mock Rating Dialog ---
  void _showRateDialog(BuildContext context) {
    final rating = 5.obs;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: const Color(0xFF1C1C1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
            title: const Center(
              child: CommonText(
                text: 'Rate Muzikgen',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CommonText(
                  text: 'Enjoying the app? Tap to rate your experience!',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                  maxLines: 2,
                ),
                SizedBox(height: 16.h),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starVal = index + 1;
                        final isSelected = starVal <= rating.value;
                        return GestureDetector(
                          onTap: () => rating.value = starVal,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Icon(
                              isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                              color: isSelected ? const Color(0xFFFFD700) : Colors.white.withValues(alpha: 0.3),
                              size: 36.sp,
                            ),
                          ),
                        );
                      }),
                    )),
              ],
            ),
            actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.2), width: 1.r),
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: const CommonText(
                        text: 'Not Now',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.snackbar(
                          'Thank You!',
                          'Thanks for rating us ${rating.value} stars!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF0F2618),
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: const CommonText(
                        text: 'Submit',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// --- Logo Painter for About Page ---
class MuzikgenLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff05B158)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.r
      ..strokeCap = StrokeCap.round;

    final double width = size.width;
    final double height = size.height;

    // Draw main outer arch (headband)
    final path = Path();
    path.arcTo(
      Rect.fromLTWH(0, 0, width, height * 0.9),
      3.14159,
      3.14159,
      false,
    );
    canvas.drawPath(path, paint);

    // Draw earpads
    final fillPaint = Paint()
      ..color = const Color(0xff05B158)
      ..style = PaintingStyle.fill;

    // Left earpad (rounded block with notch shape)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, height * 0.35, width * 0.22, height * 0.45),
        Radius.circular(8.r),
      ),
      fillPaint,
    );

    // Right earpad (rounded block with notch shape)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(width * 0.78, height * 0.35, width * 0.22, height * 0.45),
        Radius.circular(8.r),
      ),
      fillPaint,
    );

    // Center bridge connector (the bottom curve)
    paint.strokeWidth = 3.r;
    canvas.drawArc(
      Rect.fromLTWH(width * 0.15, height * 0.15, width * 0.7, height * 0.7),
      3.14159,
      3.14159,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

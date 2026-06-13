import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/text_field/common_text_field.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerHelpSupportScreen extends StatelessWidget {
  const ListnerHelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

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
              SizedBox(height: 24.h),

              // Form content scroll area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Issue Title Label
                      _buildLabel('Issue Title'),
                      SizedBox(height: 8.h),
                      // Issue Title Text Field
                      CommonTextField(
                        controller: titleController,
                        fillColor: const Color(0xFF1C1C1E),
                        textColor: Colors.white,
                        borderRadius: 24.r,
                        borderColor: Colors.white.withValues(alpha: 0.05),
                        hintText: 'Enter Issue Title',
                        hintTextColor: AppColors.secondaryTextColor,
                      ),
                      SizedBox(height: 20.h),

                      // Description Label
                      _buildLabel('Description'),
                      SizedBox(height: 8.h),
                      // Description Text Field
                      CommonTextField(
                        controller: descriptionController,
                        fillColor: const Color(0xFF1C1C1E),
                        textColor: Colors.white,
                        borderRadius: 12.r,
                        borderColor: Colors.white.withValues(alpha: 0.05),
                        hintText: 'Describe Your Issue ....',
                        hintTextColor: AppColors.secondaryTextColor,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      SizedBox(height: 20.h),

                      // Attach File Box
                      _buildAttachFileBox(),
                      SizedBox(height: 12.h),

                      // Attach Info Text Row
                      _buildAttachInfoRow(),
                      SizedBox(height: 32.h),

                      // Submit Button
                      CommonButton(
                        titleText: 'Submit',
                        buttonHeight: 48.h,
                        titleSize: 16,
                        titleWeight: FontWeight.bold,
                        onTap: () {
                          if (titleController.text.trim().isEmpty || descriptionController.text.trim().isEmpty) {
                            Get.snackbar(
                              'Validation Error',
                              'Please fill in all required fields.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color(0xFF1A0B0C),
                              colorText: Colors.white,
                            );
                            return;
                          }
                          Get.back();
                          Get.snackbar(
                            'Support Ticket Submitted',
                            'Thank you. We will get back to you shortly.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF0F2618),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Footer Privacy Disclaimer
                      _buildFooterDisclaimer(),
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
          // Circular Glass Back Button on left
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
            text: 'Help & Support',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Label with asterisk ---
  Widget _buildLabel(String text) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        children: [
          TextSpan(text: text),
          TextSpan(
            text: ' *',
            style: TextStyle(color: AppColors.red, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  // --- Attach File Box with Rounded Dashed Border ---
  Widget _buildAttachFileBox() {
    return CustomPaint(
      painter: DashedRRectPainter(
        color: Colors.white.withValues(alpha: 0.15),
        strokeWidth: 1.r,
        dashWidth: 6.r,
        dashGap: 4.r,
        borderRadius: 12.r,
      ),
      child: InkWell(
        onTap: () {
          // Placeholder for picking file
          Get.snackbar(
            'Attach File',
            'File attachment functionality coming soon',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF131315),
            colorText: Colors.white,
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              // Rotating Paperclip Icon
              Transform.rotate(
                angle: -0.8,
                child: Icon(
                  Icons.attach_file_rounded,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              // Instructions text block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: 'Attach File (optional)',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 4.h),
                    const CommonText(
                      text: 'Add screenshots or documents that can help explain the issue.',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryTextColor,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Attach File Info Row ---
  Widget _buildAttachInfoRow() {
    return Row(
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: AppColors.secondaryTextColor,
          size: 14.sp,
        ),
        SizedBox(width: 6.w),
        const Expanded(
          child: CommonText(
            text: 'Max file size: 10MB. Supported formats: JPG, PNG, PDF',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  // --- Footer Privacy Disclaimer ---
  Widget _buildFooterDisclaimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          color: AppColors.primaryColor,
          size: 16.sp,
        ),
        SizedBox(width: 6.w),
        const Expanded(
          child: CommonText(
            text: 'Your information is safe with us and will only be used to resolve your issue.',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
            textAlign: TextAlign.left,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

// --- Custom Painter for Dashed Rounded Rectangle ---
class DashedRRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double borderRadius;

  DashedRRectPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    final Path dashedPath = Path();
    double distance = 0.0;
    for (final PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final double len = min(dashWidth, metric.length - distance);
        dashedPath.addPath(
          metric.extractPath(distance, distance + len),
          Offset.zero,
        );
        distance += dashWidth + dashGap;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(DashedRRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.borderRadius != borderRadius;
  }
}

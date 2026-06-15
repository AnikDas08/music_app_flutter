import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/text_field/common_text_field.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerDeleteAccountScreen extends StatelessWidget {
  const ListnerDeleteAccountScreen({super.key});

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
              SizedBox(height: 24.h),

              // Content area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // Glow Circular Warning Icon
                      Center(
                        child: Container(
                          height: 120.r,
                          width: 120.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffE53935).withValues(alpha: 0.15),
                                blurRadius: 40.r,
                                spreadRadius: 10.r,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.warning_amber_rounded,
                              color: const Color(0xffE53935),
                              size: 72.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Title
                      const CommonText(
                        text: 'Delete Account?',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.h),

                      // Subtitle
                      const CommonText(
                        text: 'This action cannot be undone.',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                      SizedBox(height: 28.h),

                      // Warn details container card with red thin border
                      Container(
                        padding: EdgeInsets.all(18.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFF131315),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xffE53935).withValues(alpha: 0.2),
                            width: 1.r,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CommonText(
                              text: 'If you delete your account:',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            SizedBox(height: 16.h),

                            // Bullet rows
                            _buildWarningRow(Icons.calendar_today_outlined, 'All your subscriptions will be canceled'),
                            SizedBox(height: 12.h),
                            _buildWarningRow(Icons.file_download_outlined, 'You will lose access to downloaded songs and content'),
                            SizedBox(height: 12.h),
                            _buildWarningRow(Icons.library_music_outlined, 'Your playlists and library will be permanently deleted'),
                            SizedBox(height: 12.h),
                            _buildWarningRow(Icons.shield_outlined, 'Your account data will be removed from our systems'),
                            SizedBox(height: 20.h),

                            // Disclaimer text inside warning card
                            Text(
                              'You will continue to have access to your active subscriptions until the end of your current billing period.',
                              style: TextStyle(
                                fontSize: 11.sp,
                                height: 1.4,
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // Continue Solid Red Button
                      GestureDetector(
                        onTap: () => _showDeleteConfirmationPopup(context),
                        child: Container(
                          height: 48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffE53935),
                            borderRadius: BorderRadius.circular(100.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffE53935).withValues(alpha: 0.25),
                                blurRadius: 10.r,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const CommonText(
                            text: 'Continue',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Cancel text button
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const CommonText(
                          text: 'Cancel',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffE53935),
                        ),
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
            text: 'Delete Account?',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Reusable warning list row ---
  Widget _buildWarningRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xffE53935),
          size: 18.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.4,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ),
      ],
    );
  }

  // --- Delete Account Confirmation Frosted Glass Popup Dialog ---
  void _showDeleteConfirmationPopup(BuildContext context) {
    final reasonController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Stack(
              children: [
                // Frosted Glass Content Panel
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 28.h, bottom: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2), // Frosted glass opacity matching logout
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                      width: 1.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20.r,
                        spreadRadius: 2.r,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Red Trash Icon inside border box
                        Center(
                          child: Container(
                            width: 64.r,
                            height: 64.r,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                                width: 1.r,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: const Color(0xffE53935),
                                size: 28.r,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Title
                        const Center(
                          child: CommonText(
                            text: 'Delete Account',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // Subtitle
                        const Center(
                          child: CommonText(
                            text: 'Are you sure you want to delete your account?',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryTextColor,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Reason Input Label & Input Field
                        const CommonText(
                          text: 'Reason',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextField(
                          controller: reasonController,
                          hintText: 'Enter a reason why you want to delete',
                          fillColor: const Color(0xFF131315).withValues(alpha: 0.8),
                          textColor: Colors.white,
                          hintTextColor: AppColors.textFiledColor,
                          borderColor: Colors.white.withValues(alpha: 0.1),
                        ),
                        SizedBox(height: 14.h),

                        // Password Input Label & Input Field
                        const CommonText(
                          text: 'Password',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextField(
                          controller: passwordController,
                          hintText: 'Enter your password',
                          isPassword: true,
                          fillColor: const Color(0xFF131315).withValues(alpha: 0.8),
                          textColor: Colors.white,
                          hintTextColor: AppColors.textFiledColor,
                          borderColor: Colors.white.withValues(alpha: 0.1),
                        ),
                        SizedBox(height: 20.h),

                        // Delete button (Solid Red Stadium)
                        GestureDetector(
                          onTap: () {
                            if (reasonController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
                              Get.snackbar(
                                'Validation Error',
                                'Please provide a reason and your password.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFF2E1010),
                                colorText: Colors.white,
                              );
                              return;
                            }
                            Get.back(); // close dialog
                            Get.back(); // return to settings
                            Get.snackbar(
                              'Account Deleted',
                              'Your account deletion request has been submitted.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color(0xFF2E1010),
                              colorText: Colors.white,
                            );
                          },
                          child: Container(
                            height: 44.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffE53935),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            alignment: Alignment.center,
                            child: const CommonText(
                              text: 'Delete',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Top Right Close "x" Icon Button
                Positioned(
                  right: 12.w,
                  top: 20.h,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

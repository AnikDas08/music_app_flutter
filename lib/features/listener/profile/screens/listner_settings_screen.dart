import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../widgets/profile_option_card.dart';

class ListnerSettingsScreen extends StatelessWidget {
  const ListnerSettingsScreen({super.key});

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
              SizedBox(height: 16.h),

              // Settings Scroll Area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Account Section ---
                      _buildSectionTitle('Account'),
                      ProfileOptionCard(
                        icon: Icons.person_outline_rounded,
                        title: 'Profile',
                        subtitle: 'View and edit your profile information',
                        onTap: () {
                          Get.toNamed(AppRoutes.listnerEditProfile);
                        },
                      ),
                      ProfileOptionCard(
                        icon: Icons.notifications_none_outlined,
                        title: 'Notifications',
                        subtitle: 'Muzikgen Related',
                        onTap: () {
                          Get.toNamed(AppRoutes.listnerNotificationSettings);
                        },
                      ),
                      SizedBox(height: 12.h),

                      // --- Preferences Section ---
                      _buildSectionTitle('Preferences'),
                      ProfileOptionCard(
                        icon: Icons.music_note_outlined,
                        title: 'Playback Preferences',
                        subtitle: 'Crossfade, audio quality',
                        onTap: () {
                          Get.toNamed(AppRoutes.playbackPreferences);
                        },
                      ),
                      ProfileOptionCard(
                        icon: Icons.file_download_outlined,
                        title: 'Download Quality',
                        subtitle: 'Choose your download quality',
                        onTap: () {
                          Get.toNamed(AppRoutes.downloadQuality);
                        },
                      ),
                      SizedBox(height: 12.h),

                      // --- Legal Section ---
                      _buildSectionTitle('Legal'),
                      ProfileOptionCard(
                        icon: Icons.shield_outlined,
                        title: 'Privacy Policy',
                        subtitle: 'Learn how we collect and use your data',
                        onTap: () {
                          Get.snackbar(
                            'Privacy Policy',
                            'Privacy Policy document coming soon',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF131315),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      ProfileOptionCard(
                        icon: Icons.description_outlined,
                        title: 'Terms & Conditions',
                        subtitle: 'Read our terms of service',
                        onTap: () {
                          Get.snackbar(
                            'Terms & Conditions',
                            'Terms & Conditions document coming soon',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF131315),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      ProfileOptionCard(
                        icon: Icons.info_outline,
                        title: 'About Muzikgen',
                        subtitle: 'Version 1.0.0',
                        onTap: () {
                          Get.toNamed(AppRoutes.listnerAbout);
                        },
                      ),
                      SizedBox(height: 24.h),

                      // --- Delete Account Button ---
                      _buildDeleteAccountButton(),
                      SizedBox(height: 20.h),

                      // --- Footer Security Disclaimer ---
                      _buildFooterSecurityDisclaimer(),
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
            text: 'Settings',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Section Title ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: CommonText(
        text: title,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        textAlign: TextAlign.left,
      ),
    );
  }

  // --- Delete Account Card ---
  Widget _buildDeleteAccountButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.listnerDeleteAccount);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(30.r), // Highly rounded pill shape
          border: Border.all(
            color: AppColors.red,
            width: 1.r,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            // Trash Icon inside red circular border
            Container(
              height: 44.r,
              width: 44.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.red, width: 1.r),
                color: Colors.transparent,
              ),
              child: const Center(
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.red,
                  size: 22,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            // Details text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: 'Delete Account',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 2.h),
                  CommonText(
                    text: 'Permanently delete your account and all data',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.5),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Footer Security Disclaimer ---
  Widget _buildFooterSecurityDisclaimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          color: AppColors.primaryColor,
          size: 16.sp,
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: const CommonText(
            text: 'Your data is secure with us  •  Muzikgen protects your privacy',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

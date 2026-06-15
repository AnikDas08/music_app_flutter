import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/download_quality_controller.dart';

class ListnerDownloadQualityScreen extends StatelessWidget {
  const ListnerDownloadQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<DownloadQualityController>()
        ? Get.find<DownloadQualityController>()
        : Get.put(DownloadQualityController());

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

              // Scrollable body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      // Unified Quality Container Card
                      Obx(() => Container(
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
                                // 1. Low
                                _buildQualityItem(
                                  title: 'Low',
                                  subtitle: '64 kbps',
                                  isSelected: controller.selectedQuality.value == 'Low',
                                  onTap: () => controller.setSelectedQuality('Low'),
                                ),
                                _buildDivider(),

                                // 2. Normal
                                _buildQualityItem(
                                  title: 'Normal',
                                  subtitle: '128 kbps',
                                  isSelected: controller.selectedQuality.value == 'Normal',
                                  onTap: () => controller.setSelectedQuality('Normal'),
                                ),
                                _buildDivider(),

                                // 3. High
                                _buildQualityItem(
                                  title: 'High',
                                  subtitle: '320 kbps',
                                  isSelected: controller.selectedQuality.value == 'High',
                                  onTap: () => controller.setSelectedQuality('High'),
                                ),
                                _buildDivider(),

                                // 4. Very High
                                _buildQualityItem(
                                  title: 'Very High',
                                  subtitle: '640 kbps',
                                  isSelected: controller.selectedQuality.value == 'Very High',
                                  onTap: () => controller.setSelectedQuality('Very High'),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Save Button pinned to bottom
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: CommonButton(
                  titleText: 'Save',
                  titleWeight: FontWeight.bold,
                  buttonHeight: 48.h,
                  onTap: () {
                    controller.saveQuality();
                  },
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
            text: 'Download Quality',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Reusable Quality Option Item Builder ---
  Widget _buildQualityItem({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              // Left Custom Radio Button
              _buildRadioButton(isSelected),
              SizedBox(width: 16.w),
              // Title / Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: subtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryTextColor,
                      textAlign: TextAlign.left,
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

  // --- Custom Radio Button Builder ---
  Widget _buildRadioButton(bool isSelected) {
    return Container(
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.white.withValues(alpha: 0.3),
          width: 2.r,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 8.r,
                height: 8.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }

  // --- Thin Divider Builder ---
  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.05),
      height: 1.r,
      thickness: 1.r,
      indent: 16.w,
      endIndent: 16.w,
    );
  }
}

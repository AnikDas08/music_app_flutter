import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/playback_preferences_controller.dart';

class ListnerPlaybackPreferencesScreen extends StatelessWidget {
  const ListnerPlaybackPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<PlaybackPreferencesController>()
        ? Get.find<PlaybackPreferencesController>()
        : Get.put(PlaybackPreferencesController());

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
                      // Unified Preferences Container Card
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
                            // 1. Audio Quality
                            Obx(() => _buildPreferenceItem(
                                  icon: Icon(
                                    Icons.music_note_outlined,
                                    color: AppColors.primaryColor,
                                    size: 24.sp,
                                  ),
                                  title: 'Audio Quality',
                                  valueText: controller.audioQuality.value,
                                  onTap: () {
                                    _showSelectionBottomSheet(
                                      title: 'Select Audio Quality',
                                      options: [
                                        'Low (96 kbps)',
                                        'Normal (160 kbps)',
                                        'High (320 kbps)',
                                        'Very High (440 kbps)',
                                      ],
                                      currentValue: controller.audioQuality.value,
                                      onSelected: controller.setAudioQuality,
                                    );
                                  },
                                )),
                            _buildDivider(),

                            // 2. Crossfade
                            Obx(() => _buildPreferenceItem(
                                  icon: _buildCrossfadeIcon(),
                                  title: 'Crossfade',
                                  valueText: controller.crossfade.value,
                                  onTap: () {
                                    _showSelectionBottomSheet(
                                      title: 'Select Crossfade Duration',
                                      options: [
                                        'Off',
                                        '2 seconds',
                                        '5 seconds',
                                        '10 seconds',
                                        '15 seconds',
                                      ],
                                      currentValue: controller.crossfade.value,
                                      onSelected: controller.setCrossfade,
                                    );
                                  },
                                )),
                            _buildDivider(),

                            // 3. Equalizer
                            Obx(() => _buildPreferenceItem(
                                  icon: Icon(
                                    Icons.tune_outlined,
                                    color: AppColors.primaryColor,
                                    size: 24.sp,
                                  ),
                                  title: 'Equalizer',
                                  valueText: controller.equalizer.value,
                                  onTap: () {
                                    _showSelectionBottomSheet(
                                      title: 'Select Equalizer Preset',
                                      options: [
                                        'Off',
                                        'Normal',
                                        'Pop',
                                        'Rock',
                                        'Classical',
                                        'Custom',
                                      ],
                                      currentValue: controller.equalizer.value,
                                      onSelected: controller.setEqualizer,
                                    );
                                  },
                                )),
                            _buildDivider(),

                            // 4. Gapless Playback
                            Obx(() => _buildPreferenceItem(
                                  icon: Icon(
                                    Icons.remove_circle_outline_rounded,
                                    color: AppColors.primaryColor,
                                    size: 24.sp,
                                  ),
                                  title: 'Gapless Playback',
                                  subtitle: 'Play tracks without gaps',
                                  trailing: Switch(
                                    value: controller.gaplessPlayback.value,
                                    onChanged: controller.toggleGaplessPlayback,
                                    activeThumbColor: Colors.white,
                                    activeTrackColor: AppColors.primaryColor,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: const Color(0xFF2C2C35),
                                  ),
                                )),
                            _buildDivider(),

                            // 5. Normalize Volume
                            Obx(() => _buildPreferenceItem(
                                  icon: Icon(
                                    Icons.volume_up_outlined,
                                    color: AppColors.primaryColor,
                                    size: 24.sp,
                                  ),
                                  title: 'Normalize Volume',
                                  subtitle: 'Set consistent volume',
                                  trailing: Switch(
                                    value: controller.normalizeVolume.value,
                                    onChanged: controller.toggleNormalizeVolume,
                                    activeThumbColor: Colors.white,
                                    activeTrackColor: AppColors.primaryColor,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: const Color(0xFF2C2C35),
                                  ),
                                )),
                            _buildDivider(),

                            // 6. Autoplay
                            Obx(() => _buildPreferenceItem(
                                  icon: Icon(
                                    Icons.replay_rounded,
                                    color: AppColors.primaryColor,
                                    size: 24.sp,
                                  ),
                                  title: 'Autoplay',
                                  subtitle: 'Play similar songs automatically',
                                  trailing: Switch(
                                    value: controller.autoplay.value,
                                    onChanged: controller.toggleAutoplay,
                                    activeThumbColor: Colors.white,
                                    activeTrackColor: AppColors.primaryColor,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: const Color(0xFF2C2C35),
                                  ),
                                )),
                            _buildDivider(),

                            // 7. Restricted Content
                            Obx(() => _buildPreferenceItem(
                                  icon: Icon(
                                    Icons.error_outline_rounded,
                                    color: AppColors.primaryColor,
                                    size: 24.sp,
                                  ),
                                  title: 'Restricted Content',
                                  subtitle: 'Hide explicit content',
                                  trailing: Switch(
                                    value: controller.restrictedContent.value,
                                    onChanged: controller.toggleRestrictedContent,
                                    activeThumbColor: Colors.white,
                                    activeTrackColor: AppColors.primaryColor,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: const Color(0xFF2C2C35),
                                  ),
                                )),
                            _buildDivider(),

                            // 8. Reset to Default
                            _buildPreferenceItem(
                              icon: Icon(
                                Icons.replay_rounded,
                                color: AppColors.red,
                                size: 24.sp,
                              ),
                              title: 'Reset to Default',
                              titleColor: AppColors.red,
                              onTap: () {
                                _showResetConfirmationDialog(controller);
                              },
                            ),
                          ],
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
            text: 'Playback Preferences',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Reusable Preference Item Builder ---
  Widget _buildPreferenceItem({
    required Widget icon,
    required String title,
    String? subtitle,
    String? valueText,
    Widget? trailing,
    VoidCallback? onTap,
    Color titleColor = Colors.white,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              // Left Icon
              icon,
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
                      color: titleColor,
                      textAlign: TextAlign.left,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 4.h),
                      CommonText(
                        text: subtitle,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ],
                ),
              ),
              // Value & Chevron or Switch
              if (valueText != null) ...[
                CommonText(
                  text: valueText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.secondaryTextColor,
                  size: 20.sp,
                ),
              ],
              ?trailing,
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
      indent: 16.w,
      endIndent: 16.w,
    );
  }

  // --- Custom Crossed Lines (X) Icon for Crossfade ---
  Widget _buildCrossfadeIcon() {
    return SizedBox(
      width: 24.w,
      height: 24.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: 45 * 3.14159 / 180,
            child: Container(
              width: 1.5.w,
              height: 18.h,
              color: AppColors.primaryColor,
            ),
          ),
          Transform.rotate(
            angle: -45 * 3.14159 / 180,
            child: Container(
              width: 1.5.w,
              height: 18.h,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // --- Selection Bottom Sheet ---
  void _showSelectionBottomSheet({
    required String title,
    required List<String> options,
    required String currentValue,
    required Function(String) onSelected,
  }) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: const Color(0xFF131315),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.r,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            CommonText(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            SizedBox(height: 16.h),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((option) {
                    final isSelected = option == currentValue;
                    return InkWell(
                      onTap: () {
                        onSelected(option);
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.white.withValues(alpha: 0.05),
                            width: 1.r,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: option,
                              fontSize: 16,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? AppColors.primaryColor : Colors.white,
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primaryColor,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // --- Reset Confirmation Dialog ---
  void _showResetConfirmationDialog(PlaybackPreferencesController controller) {
    Get.defaultDialog(
      title: 'Reset Preferences',
      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      middleText: 'Are you sure you want to reset all playback preferences to their default settings?',
      middleTextStyle: const TextStyle(color: AppColors.secondaryTextColor),
      backgroundColor: const Color(0xFF131315),
      textConfirm: 'Reset',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.primaryColor,
      buttonColor: AppColors.red,
      onConfirm: () {
        controller.resetToDefault();
        Get.back();
        Get.snackbar(
          'Reset Successful',
          'Playback preferences have been reset.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF0F2618),
          colorText: Colors.white,
        );
      },
    );
  }
}

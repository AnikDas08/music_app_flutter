import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_notification_settings_controller.dart';

class ListnerNotificationSettingsScreen extends StatelessWidget {
  const ListnerNotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ListnerNotificationSettingsController>()
        ? Get.find<ListnerNotificationSettingsController>()
        : Get.put(ListnerNotificationSettingsController());

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
              SizedBox(height: 8.h),

              // Subtitle instruction text
              const CommonText(
                text: 'Choose the updates and alerts you want to receive.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
              ),
              SizedBox(height: 20.h),

              // Settings Scroll Area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Root Push Notification Setting ---
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF131315),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08),
                              width: 1.r,
                            ),
                          ),
                          child: _buildSettingItem(
                            icon: Icons.notifications_none_outlined,
                            iconColor: AppColors.primaryColor,
                            bgColor: const Color(0xFF1E2E25),
                            title: 'Push Notifications',
                            subtitle: 'Receive push notifications',
                            value: controller.pushNotifications.value,
                            onChanged: controller.togglePushNotifications,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // --- Subscription Notifications Group ---
                        _buildSectionHeader('Subscription Notifications', const Color(0xff05B158)),
                        SizedBox(height: 8.h),
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
                              _buildSettingItem(
                                icon: Icons.credit_card_outlined,
                                iconColor: AppColors.primaryColor,
                                bgColor: const Color(0xFF1E2E25),
                                title: 'Billing and subscription updates',
                                subtitle: 'Important updates about your billing',
                                value: controller.billingUpdates.value,
                                onChanged: controller.toggleBillingUpdates,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.access_time_rounded,
                                iconColor: AppColors.primaryColor,
                                bgColor: const Color(0xFF1E2E25),
                                title: 'Subscription expiring soon',
                                subtitle: 'Get reminded before your subscription ends',
                                value: controller.expiringSoon.value,
                                onChanged: controller.toggleExpiringSoon,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.description_outlined,
                                iconColor: AppColors.primaryColor,
                                bgColor: const Color(0xFF1E2E25),
                                title: 'Payment receipts',
                                subtitle: 'Receive receipts for successful payments',
                                value: controller.paymentReceipts.value,
                                onChanged: controller.togglePaymentReceipts,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.check_circle_outline_rounded,
                                iconColor: AppColors.primaryColor,
                                bgColor: const Color(0xFF1E2E25),
                                title: 'Renewal successful',
                                subtitle: 'Get notified when your subscription renews',
                                value: controller.renewalSuccessful.value,
                                onChanged: controller.toggleRenewalSuccessful,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.cancel_outlined,
                                iconColor: AppColors.primaryColor,
                                bgColor: const Color(0xFF1E2E25),
                                title: 'Payment failed',
                                subtitle: 'Alerts for failed or declined payments',
                                value: controller.paymentFailed.value,
                                onChanged: controller.togglePaymentFailed,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // --- Music & Artist Updates Group ---
                        _buildSectionHeader('Music & Artist Updates', const Color(0xffFF5252)),
                        SizedBox(height: 8.h),
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
                              _buildSettingItem(
                                icon: Icons.music_note_outlined,
                                iconColor: const Color(0xffFF5252),
                                bgColor: const Color(0xFF2E1515),
                                title: 'New releases from subscribed artists',
                                subtitle: 'Be the first to hear new music',
                                value: controller.newReleases.value,
                                onChanged: controller.toggleNewReleases,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.add_circle_outline_rounded,
                                iconColor: const Color(0xffFF5252),
                                bgColor: const Color(0xFF2E1515),
                                title: 'New songs added',
                                subtitle: 'New tracks added to your library',
                                value: controller.newSongs.value,
                                onChanged: controller.toggleNewSongs,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.star_border_rounded,
                                iconColor: const Color(0xffFF5252),
                                bgColor: const Color(0xFF2E1515),
                                title: 'Exclusive content available',
                                subtitle: 'Special content only for subscribers',
                                value: controller.exclusiveContent.value,
                                onChanged: controller.toggleExclusiveContent,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.arrow_downward_rounded,
                                iconColor: const Color(0xffFF5252),
                                bgColor: const Color(0xFF2E1515),
                                title: 'Download completed',
                                subtitle: 'Get notified when downloads finish',
                                value: controller.downloadCompleted.value,
                                onChanged: controller.toggleDownloadCompleted,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // --- App Notifications Group ---
                        _buildSectionHeader('App Notifications', const Color(0xff448AFF)),
                        SizedBox(height: 8.h),
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
                              _buildSettingItem(
                                icon: Icons.info_outline_rounded,
                                iconColor: const Color(0xff448AFF),
                                bgColor: const Color(0xFF15203E),
                                title: 'App updates',
                                subtitle: 'New features and improvements',
                                value: controller.appUpdates.value,
                                onChanged: controller.toggleAppUpdates,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.build_outlined,
                                iconColor: const Color(0xff448AFF),
                                bgColor: const Color(0xFF15203E),
                                title: 'Maintenance announcements',
                                subtitle: 'Scheduled maintenance and downtime',
                                value: controller.maintenance.value,
                                onChanged: controller.toggleMaintenance,
                              ),
                              _buildDivider(),
                              _buildSettingItem(
                                icon: Icons.shield_outlined,
                                iconColor: const Color(0xff448AFF),
                                bgColor: const Color(0xFF15203E),
                                title: 'Security alerts',
                                subtitle: 'Important security and account alerts',
                                value: controller.securityAlerts.value,
                                onChanged: controller.toggleSecurityAlerts,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // --- Privacy Card ---
                        _buildPrivacyCard(),
                        SizedBox(height: 32.h),
                      ],
                    );
                  }),
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
            text: 'Notifications',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Section Header ---
  Widget _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 4.h),
      child: CommonText(
        text: title,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  // --- Reusable Setting Toggle Item Builder ---
  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          // Left Icon Container
          Container(
            height: 40.r,
            width: 40.r,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // Title / Subtitle Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: subtitle,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          // Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primaryColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFF2C2C35),
          ),
        ],
      ),
    );
  }

  // --- Privacy Info Card ---
  Widget _buildPrivacyCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            color: AppColors.primaryColor,
            size: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'We respect your privacy.',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4.h),
                const CommonText(
                  text: 'You can change these settings anytime.',
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

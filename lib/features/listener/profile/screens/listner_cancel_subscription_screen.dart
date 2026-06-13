import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerCancelSubscriptionScreen extends StatelessWidget {
  const ListnerCancelSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get artist name from route arguments, fallback to 'King Promise'
    final String artistName = Get.arguments?['artistName'] ?? 'King Promise';

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
              Color(0xFF0B1F13), // Soft green glow
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
              SizedBox(height: 20.h),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      // Red Calendar Badge
                      _buildRedBadge(),
                      SizedBox(height: 24.h),

                      // Cancel Subscription Title
                      const CommonText(
                        text: 'Cancel Subscription?',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.h),

                      // Descriptions
                      const CommonText(
                        text: 'Your subscription will remain active until\nJune 10, 2026.',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        maxLines: 2,
                      ),
                      SizedBox(height: 12.h),
                      CommonText(
                        text: "After that, you will not be charged again and access to $artistName's content will end.",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        maxLines: 3,
                      ),
                      SizedBox(height: 28.h),

                      // Benefits Card Container
                      _buildBenefitsCard(),
                      SizedBox(height: 36.h),

                      // Action Buttons
                      _buildActionButtons(),
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
            text: 'Cancel Subscription',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Red Calendar Badge ---
  Widget _buildRedBadge() {
    return Container(
      height: 96.r,
      width: 96.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF2C1314), // Dark red tinted background
      ),
      child: Center(
        child: Icon(
          Icons.event_busy_outlined,
          color: AppColors.red,
          size: 38.sp,
        ),
      ),
    );
  }

  // --- Benefits Card ---
  Widget _buildBenefitsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: "WHAT YOU'LL STILL GET:",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryTextColor,
          ),
          SizedBox(height: 16.h),
          _buildBenefitItem('Full access to all content'),
          SizedBox(height: 12.h),
          _buildBenefitItem('Artist updates & member benefits'),
          SizedBox(height: 12.h),
          _buildBenefitItem('Exclusive member benefits'),
          SizedBox(height: 20.h),
          const CommonText(
            text: 'Until June 10, 2026',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: AppColors.primaryColor,
          size: 18.sp,
        ),
        SizedBox(width: 12.w),
        CommonText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ],
    );
  }

  // --- Action Buttons ---
  Widget _buildActionButtons() {
    return Column(
      children: [
        CommonButton(
          titleText: 'Cancel Subscription',
          buttonColor: AppColors.red,
          borderColor: AppColors.red,
          titleColor: Colors.white,
          onTap: () {
            // Confirm cancellation action (e.g. show success popup and go back)
            Get.back();
            Get.snackbar(
              'Cancelled',
              'Your subscription has been cancelled successfully.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFF2C1314),
              colorText: Colors.white,
            );
          },
        ),
        SizedBox(height: 16.h),
        OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white24, width: 1.5),
            shape: const StadiumBorder(),
            minimumSize: Size(double.infinity, 48.h),
            backgroundColor: Colors.transparent,
          ),
          child: const CommonText(
            text: 'Keep Subscription',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

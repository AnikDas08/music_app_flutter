import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerSubscriptionRenewScreen extends StatelessWidget {
  const ListnerSubscriptionRenewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get route arguments with default fallbacks
    final String artistName = Get.arguments?['artistName'] ?? 'Kendy Mustaq';
    final String artistImage = Get.arguments?['artistImage'] ?? 'assets/images/artist_onboarding_third.png';
    final String amount = Get.arguments?['amount'] ?? 'UGX 1,000/Mo';
    final String period = Get.arguments?['period'] ?? 'Monthly';

    // Parse clean price and billing cycle text
    final String cleanPrice = amount.split('/').first;
    final String billingCycle = period.toLowerCase() == 'monthly' ? 'per month' : 'per year';

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
              _buildHeader(artistName),
              SizedBox(height: 16.h),

              // Main content scroll area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      // Artist Profile Image Circle
                      _buildArtistAvatar(artistImage),
                      SizedBox(height: 20.h),

                      // Expired Plan Card
                      _buildExpiredPlanCard(period, cleanPrice, billingCycle),
                      SizedBox(height: 20.h),

                      // Locked Status Card
                      _buildLockedStatusCard(),
                      SizedBox(height: 24.h),

                      // Renew Button
                      CommonButton(
                        titleText: 'Renew',
                        buttonHeight: 48.h,
                        titleSize: 16,
                        titleWeight: FontWeight.bold,
                        onTap: () {
                          Get.back();
                          Get.snackbar(
                            'Success',
                            'Subscription renewed successfully!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF0F2618),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Secure Payment Disclaimer Footer
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
  Widget _buildHeader(String artistName) {
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
          CommonText(
            text: artistName,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Artist Avatar ---
  Widget _buildArtistAvatar(String artistImage) {
    return Container(
      height: 80.r,
      width: 80.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5.r,
        ),
        image: DecorationImage(
          image: AssetImage(artistImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // --- Expired Plan Card ---
  Widget _buildExpiredPlanCard(String period, String cleanPrice, String billingCycle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1112), // Dark red container background
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.red, // Red border
          width: 1.5.r,
        ),
      ),
      child: Column(
        children: [
          // Crown Centered, Expired Status Badge on right
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.workspace_premium,
                color: const Color(0xFFEEBC30), // Gold Crown
                size: 28.sp,
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cancel,
                        color: AppColors.red,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      const CommonText(
                        text: 'Expired',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Period Name (e.g. Monthly)
          CommonText(
            text: period,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 6.h),

          // Expired Label text
          const CommonText(
            text: 'Expired',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.red,
          ),
          SizedBox(height: 4.h),

          // Subtitle hints
          CommonText(
            text: 'renew to restore access',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.5),
          ),
          SizedBox(height: 12.h),

          // Subtle Divider
          Divider(
            color: Colors.white.withValues(alpha: 0.1),
            thickness: 1.r,
          ),
          SizedBox(height: 12.h),

          // Pricing block
          CommonText(
            text: cleanPrice,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: billingCycle,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }

  // --- Locked Status Card ---
  Widget _buildLockedStatusCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
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
          // Concentric Glowing circles with Lock icon in center
          Container(
            height: 110.r,
            width: 110.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                width: 6.r,
              ),
            ),
            alignment: Alignment.center,
            child: Container(
              height: 94.r,
              width: 94.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  width: 3.r,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                height: 76.r,
                width: 76.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0C2417), // Dark green
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.35),
                    width: 1.r,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.25),
                      blurRadius: 12.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.primaryColor,
                  size: 32.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Status label
          const CommonText(
            text: 'Renew To Continue Listening',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Footer Disclaimer ---
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
        const CommonText(
          text: 'Secure payment  •  Cancel anytime',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryTextColor,
        ),
      ],
    );
  }
}

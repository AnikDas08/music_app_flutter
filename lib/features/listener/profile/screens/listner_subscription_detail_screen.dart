import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerSubscriptionDetailScreen extends StatelessWidget {
  const ListnerSubscriptionDetailScreen({super.key});

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
                      SizedBox(height: 16.h),

                      // Plan Highlight Card
                      _buildHighlightCard(period, cleanPrice, billingCycle),
                      SizedBox(height: 16.h),

                      // You'll Get Card Section
                      _buildFeaturesCard(artistName),
                      SizedBox(height: 24.h),

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

  // --- Plan Highlight Card ---
  Widget _buildHighlightCard(String period, String cleanPrice, String billingCycle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF12231A), // Dark green tinted background
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor, // Green border highlighting plan
          width: 1.5.r,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Green Verified Checkmark in corner
          Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.check_circle,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
          Column(
            children: [
              Icon(
                Icons.workspace_premium,
                color: Colors.amber,
                size: 30.sp,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: period,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 2.h),
              const CommonText(
                text: 'Cancel Anytime',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
              ),
              SizedBox(height: 12.h),
              CommonText(
                text: cleanPrice,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 2.h),
              CommonText(
                text: billingCycle,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Features Card ---
  Widget _buildFeaturesCard(String artistName) {
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
            text: "You'll Get",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 20.h),

          // Features List Items
          _buildFeatureRow(
            icon: Icons.music_note_outlined,
            title: 'Full Catalog',
            subtitle: 'Get full access to all songs and releases',
          ),
          SizedBox(height: 18.h),

          _buildFeatureRow(
            icon: Icons.star_outline_outlined,
            title: 'Exclusive Releases',
            subtitle: 'Listen to unreleased and behind-the-scenes content',
          ),
          SizedBox(height: 18.h),

          _buildFeatureRow(
            icon: Icons.download_outlined,
            title: 'Offline Listening',
            subtitle: 'Download your favorite songs and listen any where',
          ),
          SizedBox(height: 18.h),

          _buildFeatureRow(
            icon: Icons.favorite_border_outlined,
            title: 'Direct Artist Support',
            subtitle: 'Your subscription directly support ${artistName.toLowerCase()}',
          ),
          SizedBox(height: 28.h),

          // Action Buttons Row
          Row(
            children: [
              // Maybe Later Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.red, width: 1.5),
                    shape: const StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: Colors.transparent,
                  ),
                  child: const CommonText(
                    text: 'Maybe Later',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Manage Button
              Expanded(
                child: CommonButton(
                  titleText: 'Manage',
                  buttonHeight: 44.h,
                  titleSize: 14,
                  titleWeight: FontWeight.bold,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.listnerManageSubscription,
                      arguments: {'artistName': artistName},
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Green Circle Icon Container
        Container(
          height: 38.r,
          width: 38.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF1E2E25),
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: title,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              CommonText(
                text: subtitle,
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

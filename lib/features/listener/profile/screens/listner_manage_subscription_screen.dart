import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerManageSubscriptionScreen extends StatelessWidget {
  const ListnerManageSubscriptionScreen({super.key});

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
                      // Subscription Info Card
                      _buildDetailsCard(artistName),
                      SizedBox(height: 16.h),

                      // Safe disclaimer banner card
                      _buildDisclaimerCard(),
                      SizedBox(height: 36.h),

                      // Action buttons
                      _buildActionButtons(artistName),
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
            text: 'Manage Subscription',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Subscription Info Card ---
  Widget _buildDetailsCard(String artistName) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Header Row: Avatar and subscription identity
          Row(
            children: [
              // Avatar with overlapping verified check
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 56.r,
                    width: 56.r,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/artist_onboarding_third.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1C1C1E),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor,
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: 'SUBSCRIBED TO',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryTextColor,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        CommonText(
                          text: artistName,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.check_circle,
                          color: AppColors.primaryColor,
                          size: 16.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    const CommonText(
                      text: 'Direct-to-fan subscription',
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
          SizedBox(height: 24.h),
          const Divider(color: Colors.white10, height: 1),
          SizedBox(height: 16.h),

          // Details Metadata Rows
          _buildDetailRow(
            icon: Icons.sync,
            label: 'Subscription Status',
            valueWidget: const CommonText(
              text: 'Active',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 18.h),

          _buildDetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Renewal Date',
            valueWidget: const CommonText(
              text: 'June 10, 2026',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 18.h),

          _buildDetailRow(
            icon: Icons.credit_card_outlined,
            label: 'Payment Method',
            valueWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonText(
                  text: 'MTN Mobile Money',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: '+256 772 123 456',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),

          _buildDetailRow(
            icon: Icons.view_headline_outlined,
            label: 'Plan',
            valueWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonText(
                  text: 'Fan Subscription',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: '1,000 UGX / month',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required Widget valueWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 20.sp),
        SizedBox(width: 10.w),
        CommonText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryTextColor,
        ),
        const Spacer(),
        valueWidget,
      ],
    );
  }

  // --- Disclaimer Card ---
  Widget _buildDisclaimerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: AppColors.primaryColor,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          const Expanded(
            child: CommonText(
              text: 'You can cancel anytime. You will continue to enjoy your benefits until your renewal date.',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryTextColor,
              textAlign: TextAlign.left,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  // --- Action Buttons ---
  Widget _buildActionButtons(String artistName) {
    return Column(
      children: [
        CommonButton(
          titleText: 'Cancel Subscription',
          buttonColor: AppColors.red,
          borderColor: AppColors.red,
          titleColor: Colors.white,
          onTap: () {
            Get.toNamed(
              AppRoutes.listnerCancelSubscription,
              arguments: {'artistName': artistName},
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

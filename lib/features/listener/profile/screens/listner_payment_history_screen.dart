import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerPaymentHistoryScreen extends StatelessWidget {
  const ListnerPaymentHistoryScreen({super.key});

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

              // Content Area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      // Menu Options Container Card
                      _buildMenuCard(),
                      SizedBox(height: 16.h),

                      // Stats Card (Split Vertically)
                      _buildStatsCard(),
                      SizedBox(height: 16.h),

                      // Security Info Card
                      _buildSecurityCard(),
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
            text: 'Payment & History',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Menu Card ---
  Widget _buildMenuCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Billing & Payment Row
          _buildMenuRow(
            icon: Icons.credit_card,
            title: 'Billing & Payment',
            subtitle: 'Manage payment methods and subscriptions',
            onTap: () {
              Get.toNamed(AppRoutes.listnerBillingPayment);
            },
          ),
          // Divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: Colors.white.withValues(alpha: 0.06),
              height: 1,
            ),
          ),
          // Payment History Row
          _buildMenuRow(
            icon: Icons.receipt_long,
            title: 'Payment History',
            subtitle: 'View receipts and transaction history',
            onTap: () {
              Get.toNamed(AppRoutes.listnerPaymentHistoryLogs);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            // Green Box Container for Icon
            Container(
              height: 44.r,
              width: 44.r,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2E25),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
              ),
            ),
            SizedBox(width: 14.w),
            // Text Block
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 16,
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
                  ),
                ],
              ),
            ),
            // Chevron Right
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.5),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  // --- Stats Card ---
  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Row(
        children: [
          // Left: Total Spent Info
          Expanded(
            child: Row(
              children: [
                // Green Circle with Stats Icon
                Container(
                  height: 38.r,
                  width: 38.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1E2E25),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Text details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonText(
                        text: 'TOTAL SPENT',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                      SizedBox(height: 4.h),
                      const CommonText(
                        text: 'UGX 61,000',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 2.h),
                      const CommonText(
                        text: 'All time',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Vertical Divider
          Container(
            height: 44.h,
            width: 1.w,
            color: Colors.white.withValues(alpha: 0.08),
          ),
          SizedBox(width: 14.w),
          // Right: Active Subscriptions Info
          Expanded(
            child: Row(
              children: [
                // Green Circle with Shield/Check Icon
                Container(
                  height: 38.r,
                  width: 38.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1E2E25),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Text details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonText(
                        text: 'ACTIVE SUBSCRIPTIONS',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                      SizedBox(height: 4.h),
                      const CommonText(
                        text: '3',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 2.h),
                      const CommonText(
                        text: 'Currently active',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Security Card ---
  Widget _buildSecurityCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: AppColors.primaryColor,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'Your payments are secure and encrypted',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4.h),
                const CommonText(
                  text: 'We never store your full card details.',
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
}

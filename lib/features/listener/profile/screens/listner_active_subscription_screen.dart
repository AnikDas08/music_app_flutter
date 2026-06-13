import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../../../../config/route/app_routes.dart';
import '../controller/listner_profile_controller.dart';

class ListnerActiveSubscriptionScreen extends StatelessWidget {
  const ListnerActiveSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListnerProfileController>(
      init: ListnerProfileController(),
      builder: (controller) {
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
                  Color(0xFF0B1F13), // Soft dark green glow
                  Color(0xFF0A0A0A), // Black transition
                ],
                stops: [0.0, 0.35],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // App Bar / Header
                  _buildHeader(),
                  SizedBox(height: 16.h),

                  // Main List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: controller.activeSubscriptionsList.length + 1,
                      itemBuilder: (context, index) {
                        // The last index will display the disclaimer card
                        if (index == controller.activeSubscriptionsList.length) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 24.h),
                            child: _buildDisclaimerCard(),
                          );
                        }

                        final item = controller.activeSubscriptionsList[index];
                        return _buildSubscriptionCard(item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
            text: 'Active Subscription',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Subscription Card Item ---
  Widget _buildSubscriptionCard(Map<String, dynamic> item) {
    final bool isActive = item['isActive'] ?? false;

    final Widget cardContent = Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upper Artist Details
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CommonImage(
                  imageSrc: item['image'],
                  height: 64.r,
                  width: 64.r,
                  fill: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: item['name'],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 2.h),
                    CommonText(
                      text: item['genre'],
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryTextColor,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 4.h),
                    // Status row (verified / check badge if active)
                    Row(
                      children: [
                        if (isActive) ...[
                          Icon(
                            Icons.check_circle_outline,
                            color: AppColors.primaryColor,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          CommonText(
                            text: 'Active',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ] else ...[
                          CommonText(
                            text: 'Expired',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red,
                          ),
                        ],
                        SizedBox(width: 4.w),
                        CommonText(
                          text: '(${item['period']})',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Side-by-Side Info Boxes (Amount & Billing/Expiration)
          Row(
            children: [
              // Amount Box
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF242426),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card_outlined,
                            color: AppColors.secondaryTextColor,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          const CommonText(
                            text: 'Amount',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryTextColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      CommonText(
                        text: item['amount'],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Billing / Expiration Box
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF242426),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.secondaryTextColor,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          CommonText(
                            text: item['billingLabel'],
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryTextColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      CommonText(
                        text: item['billingValue'],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Full-width Subscribe Date Box
          GestureDetector(
            onTap: () {
              if (isActive) {
                Get.toNamed(
                  AppRoutes.listnerSubscriptionDetail,
                  arguments: {
                    'artistName': item['name'],
                    'artistImage': item['image'],
                    'amount': item['amount'],
                    'period': item['period'],
                  },
                );
              } else {
                Get.toNamed(
                  AppRoutes.listnerSubscriptionRenew,
                  arguments: {
                    'artistName': item['name'],
                    'artistImage': item['image'],
                    'amount': item['amount'],
                    'period': item['period'],
                  },
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF242426),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonText(
                        text: 'Subscribe Date',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                      SizedBox(height: 4.h),
                      CommonText(
                        text: item['subscribeDate'],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Lower Section Action Buttons
          if (isActive) ...[
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.listnerCancelSubscription,
                        arguments: {'artistName': item['name']},
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.red, width: 1.5),
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor: Colors.transparent,
                    ),
                    child: const CommonText(
                      text: 'Cancel',
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
                        arguments: {'artistName': item['name']},
                      );
                    },
                  ),
                ),
              ],
            ),
          ] else ...[
            // Full width Renew Button
            CommonButton(
              titleText: 'Renew',
              buttonHeight: 44.h,
              titleSize: 14,
              titleWeight: FontWeight.bold,
              onTap: () {
                Get.toNamed(
                  AppRoutes.listnerSubscriptionRenew,
                  arguments: {
                    'artistName': item['name'],
                    'artistImage': item['image'],
                    'amount': item['amount'],
                    'period': item['period'],
                  },
                );
              },
            ),
          ],
        ],
      ),
    );

    if (!isActive) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.listnerSubscriptionRenew,
            arguments: {
              'artistName': item['name'],
              'artistImage': item['image'],
              'amount': item['amount'],
              'period': item['period'],
            },
          );
        },
        child: cardContent,
      );
    }
    return cardContent;
  }

  // --- Disclaimer Footer ---
  Widget _buildDisclaimerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.lato(fontSize: 12.sp, height: 1.4),
          children: [
            TextSpan(
              text: 'Note: ',
              style: GoogleFonts.lato(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text: "You Can Cancel Your Subscriptions Anytime. You'll Continue To Have Access Until The End Of Your Current Billing Period.",
              style: TextStyle(color: AppColors.secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

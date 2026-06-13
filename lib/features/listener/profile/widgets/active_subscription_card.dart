import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_profile_controller.dart';

class ActiveSubscriptionCard extends StatelessWidget {
  final ListnerProfileController controller;

  const ActiveSubscriptionCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F2618), // Dark green tinted background matching design
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Left Accent Green Line
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 3.w,
              color: AppColors.primaryColor,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                // Top row details
                Row(
                  children: [
                    SizedBox(width: 4.w), // Spacer for left accent line
                    // Pink Music Icon Container
                    Container(
                      height: 44.r,
                      width: 44.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF1493), // Pink music icon background
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Titles
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonText(
                            text: 'Active Subscription',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 2.h),
                          CommonText(
                            text: controller.subscriptionCount,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryTextColor,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    // Chevron Right in Circle (Glass effect)
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.listnerActiveSubscription);
                      },
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            height: 36.r,
                            width: 36.r,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                                width: 1.r,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Divider
                Divider(
                  color: Colors.white.withOpacity(0.1),
                  height: 1.h,
                  thickness: 1.h,
                ),
                SizedBox(height: 16.h),
                // Bottom row details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 4.w),
                    _buildSubDetailColumn(
                      title: 'Total Spent',
                      value: controller.totalSpent,
                    ),
                    _buildSubDetailColumn(
                      title: 'Active Since',
                      value: controller.activeSince,
                    ),
                    _buildSubDetailColumn(
                      title: 'Expires',
                      value: controller.expires,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubDetailColumn({required String title, required String value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
          ),
          SizedBox(height: 6.h),
          CommonText(
            text: value,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

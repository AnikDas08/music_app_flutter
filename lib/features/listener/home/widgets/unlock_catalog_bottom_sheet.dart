import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';

class UnlockCatalogBottomSheet extends StatelessWidget {
  final String artistName;
  final String artistImage;
  final String price;
  final VoidCallback? onUnlockTap;

  const UnlockCatalogBottomSheet({
    super.key,
    required this.artistName,
    required this.artistImage,
    required this.price,
    this.onUnlockTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(), // Close sheet on tapping background
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {}, // Prevent closing sheet when clicking inside
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B1B1C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          height: 4.h,
                          width: 36.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Close button alignment
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white70,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Header
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          SizedBox(width: 8.w),
                          CommonText(
                            text: "What You'll Unlock",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      CommonText(
                        text: "Get full access to all songs, exclusive content and support this artist directly.",
                        fontSize: 13,
                        color: Colors.white54,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                      SizedBox(height: 24.h),

                      // Feature List
                      _buildFeatureItem(
                        icon: Icons.music_note_outlined,
                        title: "Full Catalog",
                        subtitle: "Get full access to all songs and releases",
                      ),
                      SizedBox(height: 16.h),
                      _buildFeatureItem(
                        icon: Icons.star_border,
                        title: "Exclusive Releases",
                        subtitle: "Listen to unreleased and behind the scenes content",
                      ),
                      SizedBox(height: 16.h),
                      _buildFeatureItem(
                        icon: Icons.file_download_outlined,
                        title: "Offline Listening",
                        subtitle: "Download your favorite songs and listen any where",
                      ),
                      SizedBox(height: 16.h),
                      _buildFeatureItem(
                        icon: Icons.favorite_border_outlined,
                        title: "Direct Artist Support",
                        subtitle: "Your subscription directly support $artistName",
                      ),
                      SizedBox(height: 28.h),

                      // Unlock Button
                      GestureDetector(
                        onTap: () {
                          Get.back(); // close the current sheet
                          if (onUnlockTap != null) {
                            onUnlockTap!();
                          } else {
                            Get.toNamed(
                              AppRoutes.subscribePlan,
                              arguments: {
                                'name': artistName,
                                'image': artistImage,
                                'price': price,
                              },
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 54.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C853),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.workspace_premium,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              CommonText(
                                text: "Unlock Full Catalog $price/Month",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Maybe later text
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: CommonText(
                            text: "Maybe later",
                            fontSize: 14,
                            color: Colors.white54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40.r,
          width: 40.r,
          decoration: BoxDecoration(
            color: const Color(0xFF00C853).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF00C853),
            size: 20.sp,
          ),
        ),
        SizedBox(width: 16.w),
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
                color: Colors.white54,
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class FeaturedArtistCard extends StatelessWidget {
  final String name;
  final String track;
  final String price;
  final String imagePath;
  final bool isSubscribed;

  const FeaturedArtistCard({
    super.key,
    required this.name,
    required this.track,
    required this.price,
    required this.imagePath,
    this.isSubscribed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/artist_profile_screen.dart',
          arguments: {
            'name': name,
            'image': imagePath,
            'isSubscribed': isSubscribed,
            'price': price,
            'track': track,
          },
        );
      },
      child: Container(
        width: 172.w,
        padding: EdgeInsets.all(8.r), // Inset padding around all card children
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1C), // Matching dark card background
          borderRadius: BorderRadius.circular(16.r),
          border: isSubscribed
              ? Border.all(color: AppColors.primaryColor, width: 1.5.r)
              : null,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image block with locking badge
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r), // Inset image rounded on all corners
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 135.h,
                  width: 172.w,
                  fit: BoxFit.cover,
                ),
                // Overlay badge
                if (isSubscribed)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: AppColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                  )
                else
                  // Locked overlay badge with glass blur effect
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                            ),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.5),
                              width: 1.r,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "Subscribe\nto unlock",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Metadata block
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  maxLines: 1,
                ),
                SizedBox(height: 4.h),
                // Track detail
                Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: const Color(0xFF9E8EFE), // Lilac music note
                      size: 13.sp,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CommonText(
                        text: track,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF9E8EFE),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // Lightning feature text
                Row(
                  children: [
                    Icon(
                      Icons.electric_bolt, // Lightning icon
                      color: const Color(0xFFFFD700),
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CommonText(
                        text: "Full Access + Exclusive Tracks",
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Price Row OR Listen Now Button
                isSubscribed
                    ? Container(
                        height: 36.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Listen Now",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.workspace_premium, // Gold Crown
                            color: const Color(0xFFFFD700),
                            size: 13.sp,
                          ),
                          SizedBox(width: 4.w),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: price,
                                  style: GoogleFonts.lato(
                                    color: const Color(0xFFFFD700),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "/Month",
                                  style: GoogleFonts.lato(
                                    color: Colors.white60,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}

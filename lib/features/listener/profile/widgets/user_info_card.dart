import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_profile_controller.dart';

class UserInfoCard extends StatelessWidget {
  final ListnerProfileController controller;

  const UserInfoCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
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
          // Card Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                SizedBox(width: 4.w), // Extra space to clear the left accent line
                // Circular Profile Picture
                Container(
                  height: 72.r,
                  width: 72.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.5.r,
                    ),
                  ),
                  child: ClipOval(
                    child: CommonImage(
                      imageSrc: controller.userImage,
                      size: 72,
                      fill: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: controller.userName,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 4.h),
                      CommonText(
                        text: controller.userEmail,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 6.h),
                      // Edit Profile Underlined Text Link
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.listnerEditProfile);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.primaryColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: const CommonText(
                            text: 'Edit Profile',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.left,
                          ),
                        ),
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
}

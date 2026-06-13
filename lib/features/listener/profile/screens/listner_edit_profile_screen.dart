import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/pop_up/common_pop_menu.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/text_field/common_text_field.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_profile_controller.dart';

class ListnerEditProfileScreen extends StatelessWidget {
  const ListnerEditProfileScreen({super.key});

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
                  Color(0xFF0B1F13), // Dark green glow
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

                  // Main content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          // Form Card Container
                          _buildFormCard(controller),
                          SizedBox(height: 16.h),

                          // Secure Privacy Badge
                          _buildSecureBadge(),
                          SizedBox(height: 24.h),

                          // Account Section Divider
                          _buildSectionDivider(),
                          SizedBox(height: 16.h),

                          // Account Settings Card List
                          _buildAccountPanel(),
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
            text: 'Edit Profile',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Form Card ---
  Widget _buildFormCard(ListnerProfileController controller) {
    ImageProvider imgProvider;
    if (controller.selectedImagePath != null) {
      imgProvider = FileImage(File(controller.selectedImagePath!));
    } else if (controller.userImage.startsWith('assets/')) {
      imgProvider = AssetImage(controller.userImage);
    } else {
      imgProvider = NetworkImage(controller.userImage);
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // User Avatar Stack with Green camera icon overlay
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 110.r,
                width: 110.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.5.r,
                  ),
                  image: DecorationImage(
                    image: imgProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: controller.showImagePickerSourceDialog,
                child: Container(
                  height: 32.r,
                  width: 32.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor, // Green color badge
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Name Field Label
          const Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              text: 'Name',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 8.h),

          // Name Input Field
          CommonTextField(
            controller: controller.nameEditController,
            fillColor: const Color(0xFF242426),
            textColor: Colors.white,
            borderRadius: 100.r,
            borderColor: Colors.white.withValues(alpha: 0.05),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.person_outline,
                color: AppColors.secondaryTextColor,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Email Field Label
          const Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              text: 'Email',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 8.h),

          // Email Input Field
          CommonTextField(
            controller: controller.emailEditController,
            fillColor: const Color(0xFF242426),
            textColor: Colors.white,
            borderRadius: 100.r,
            borderColor: Colors.white.withValues(alpha: 0.05),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.email_outlined,
                color: AppColors.secondaryTextColor,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Subtext
          const Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              text: "We'll never share your email with anyone.",
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryTextColor,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 32.h),

          // Update Profile Button
          CommonButton(
            titleText: 'Update Profile',
            buttonColor: controller.isProfileChanged ? AppColors.primaryColor : const Color(0xFF3E3E40),
            borderColor: controller.isProfileChanged ? AppColors.primaryColor : Colors.transparent,
            titleColor: controller.isProfileChanged ? Colors.white : const Color(0xFF8E8E93),
            titleWeight: FontWeight.bold,
            onTap: controller.isProfileChanged ? controller.updateProfile : null,
          ),
        ],
      ),
    );
  }

  // --- Secure Badge ---
  Widget _buildSecureBadge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.verified_user_outlined,
          color: AppColors.primaryColor,
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        const CommonText(
          text: 'Your data is secure and private',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryTextColor,
        ),
      ],
    );
  }

  // --- Divider ---
  Widget _buildSectionDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white10)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const CommonText(
            text: 'Account',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryTextColor,
          ),
        ),
        const Expanded(child: Divider(color: Colors.white10)),
      ],
    );
  }

  // --- Account Options Panel ---
  Widget _buildAccountPanel() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildAccountOption(
            icon: Icons.lock_open_outlined,
            title: 'Change Password',
            onTap: () => Get.toNamed(AppRoutes.changePassword),
          ),
          Divider(color: Colors.white.withValues(alpha: 0.05), height: 1),
          _buildAccountOption(
            icon: Icons.notifications_none_outlined,
            title: 'Notification Preferences',
            onTap: () {
              // Action handler
            },
          ),
          Divider(color: Colors.white.withValues(alpha: 0.05), height: 1),
          _buildAccountOption(
            icon: Icons.favorite_border_outlined,
            title: 'Favorite Artists',
            onTap: () {
              // Action handler
            },
          ),
          Divider(color: Colors.white.withValues(alpha: 0.05), height: 1),
          _buildAccountOption(
            icon: Icons.logout_outlined,
            title: 'Log Out',
            color: AppColors.red,
            iconColor: AppColors.red,
            onTap: logOutPopUp,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.white,
    Color iconColor = AppColors.primaryColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 22.sp),
      title: CommonText(
        text: title,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color,
        textAlign: TextAlign.left,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }
}

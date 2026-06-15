import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/text_field/common_text_field.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import 'package:muzikgen_app/utils/helpers/validation.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ChangePasswordController>()
        ? Get.find<ChangePasswordController>()
        : Get.put(ChangePasswordController());

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

              // Content Form Area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),

                        // Center Verification Shield Badge
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                color: AppColors.primaryColor,
                                size: 76.sp,
                              ),
                              Icon(
                                Icons.check_rounded,
                                color: AppColors.primaryColor,
                                size: 36.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Center Title
                        const Center(
                          child: CommonText(
                            text: 'Keep your account secure',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6.h),

                        // Center Subtitle
                        const Center(
                          child: CommonText(
                            text: "Use a strong password that you don't use elsewhere.",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryTextColor,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: 28.h),

                        // --- Current Password Section ---
                        const CommonText(
                          text: 'Current Password',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryTextColor,
                        ),
                        SizedBox(height: 8.h),
                        CommonTextField(
                          controller: controller.currentPasswordController,
                          hintText: 'Enter your current password',
                          isPassword: true,
                          fillColor: const Color(0xFF131315),
                          textColor: Colors.white,
                          hintTextColor: AppColors.textFiledColor,
                          borderColor: Colors.white.withValues(alpha: 0.1),
                          validator: AppValidation.password,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.textFiledColor,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // --- New Password Section ---
                        const CommonText(
                          text: 'New Password',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryTextColor,
                        ),
                        SizedBox(height: 8.h),
                        CommonTextField(
                          controller: controller.newPasswordController,
                          hintText: 'Enter your new password',
                          isPassword: true,
                          fillColor: const Color(0xFF131315),
                          textColor: Colors.white,
                          hintTextColor: AppColors.textFiledColor,
                          borderColor: Colors.white.withValues(alpha: 0.1),
                          validator: AppValidation.password,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.textFiledColor,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // --- Confirm New Password Section ---
                        const CommonText(
                          text: 'Confirm New Password',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryTextColor,
                        ),
                        SizedBox(height: 8.h),
                        CommonTextField(
                          controller: controller.confirmPasswordController,
                          hintText: 'Confirm your new password',
                          isPassword: true,
                          fillColor: const Color(0xFF131315),
                          textColor: Colors.white,
                          hintTextColor: AppColors.textFiledColor,
                          borderColor: Colors.white.withValues(alpha: 0.1),
                          validator: (value) => AppValidation.confirmPassword(
                            value,
                            controller.newPasswordController,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.textFiledColor,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),

                        // Solid Green Update Password Button
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.changePasswordRepo();
                            }
                          },
                          child: Container(
                            height: 48.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(100.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withValues(alpha: 0.25),
                                  blurRadius: 10.r,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const CommonText(
                              text: 'Update Password',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Bottom security badge row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              color: AppColors.primaryColor,
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            const CommonText(
                              text: 'Your account security is important to us.',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
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
          // Circular Glass Back Button
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
            text: 'Change Password',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/text_field/common_text_field.dart';
import 'package:muzikgen_app/component/other_widgets/auth_custom_app_bar.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import 'package:muzikgen_app/utils/helpers/validation.dart';
import '../controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/select_role_image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: GetBuilder<SignUpController>(
          builder: (controller) {
            final isArtist = controller.selectRole == 'Artist';
            final roleName = isArtist ? 'Artist' : 'Listener';

            return SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circular Back Button custom app bar
                      const AuthCustomAppBar(),

                      // Main Title
                      CommonText(
                        text: "Create $roleName Profile",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 6.h),

                      // Subtitle
                      CommonText(
                        text:
                            "Let's set up your ${roleName.toLowerCase()} profile",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 24.h),

                      // Circular Image Selector / Photo Uploader
                      Center(
                        child: GestureDetector(
                          onTap: () => controller.openGallery(),
                          child: Column(
                            children: [
                              Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 1.5.r,
                                  ),
                                  color: Colors.black.withOpacity(0.5),
                                  image: controller.image != null
                                      ? DecorationImage(
                                          image: FileImage(
                                            File(controller.image!),
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: controller.image == null
                                    ? Center(
                                        child: CommonImage(
                                          imageSrc:
                                              "assets/images/camera_image.png",
                                          width: 96,
                                          height: 96,
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(height: 8.h),
                              const CommonText(
                                text: "Upload Photo",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Listener/Artist Profile Name Label
                      CommonText(
                        text: "$roleName Name",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        textAlign: TextAlign.left,
                        bottom: 6,
                      ),

                      // Listener/Artist Profile Name Field
                      CommonTextField(
                        controller: controller.nameController,
                        hintText: "Enter Your Artist / Stage Name",
                        fillColor: const Color(0xFF242424).withOpacity(0.5),
                        textColor: Colors.white,
                        hintTextColor: AppColors.secondaryTextColor,
                        borderRadius: 100,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 20.w),
                          child: Icon(
                            Icons.person_outline,
                            color: AppColors.secondaryTextColor,
                            size: 20.sp,
                          ),
                        ),
                        validator: AppValidation.required,
                      ),
                      SizedBox(height: 20.h),

                      // Phone Label
                      const CommonText(
                        text: "Phone",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        textAlign: TextAlign.left,
                        bottom: 8,
                      ),

                      // Ugandan Phone Input Field
                      IntlPhoneField(
                        controller: controller.numberController,
                        onCountryChanged: controller.onCountryChange,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        dropdownTextStyle: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        dropdownIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        flagsButtonPadding: EdgeInsets.only(
                          left: 16.w,
                          right: 8.w,
                        ),
                        decoration: InputDecoration(
                          hintText: "XXX XXX XXX",
                          hintStyle: GoogleFonts.lato(
                            color: AppColors.secondaryTextColor,
                            fontSize: 14.sp,
                          ),
                          fillColor: const Color(0xFF242424).withOpacity(0.5),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.r),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        initialCountryCode: 'UG',
                      ),
                      SizedBox(height: 6.h),

                      // Helper instruction
                      const CommonText(
                        text: "We'll use this number to verify your account.",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 24.h),

                      // Terms and Conditions checkbox and RichText
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h,
                            width: 24.w,
                            child: Checkbox(
                              value: controller.isAgreed,
                              onChanged: (val) {
                                controller.toggleAgreement(val);
                              },
                              activeColor: AppColors.primaryColor,
                              checkColor: Colors.white,
                              side: const BorderSide(
                                color: Colors.white60,
                                width: 1.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 13.sp,
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "By continuing, you agree to our ",
                                  ),
                                  TextSpan(
                                    text: "Terms & Conditions ",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(text: "and "),
                                  TextSpan(
                                    text: "Privacy Policy.",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),

                      // Continue Button
                      CommonButton(
                        titleText: "Continue",
                        buttonHeight: 54.h,
                        isLoading: controller.isLoading,
                        onTap: () {
                          if (!_formKey.currentState!.validate()) return;
                          if (!controller.isAgreed) {
                            Get.snackbar(
                              "Agreement Required",
                              "Please accept the Terms & Conditions and Privacy Policy to continue.",
                              backgroundColor: Colors.red.withOpacity(0.8),
                              colorText: Colors.white,
                            );
                            return;
                          }
                          controller.signUpUser();
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Footer Sign In navigation
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signIn),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already have an account?',
                                  style: GoogleFonts.lato(
                                    color: AppColors.textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Sign In',
                                  style: GoogleFonts.lato(
                                    color: AppColors.primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

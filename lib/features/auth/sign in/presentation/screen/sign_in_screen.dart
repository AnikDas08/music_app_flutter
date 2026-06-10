import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/other_widgets/auth_custom_app_bar.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../../../../../component/image/common_image.dart';
import '../controller/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

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
        child: GetBuilder<SignInController>(
          builder: (controller) {
            return SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w,),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Back Button Custom App Bar
                      const AuthCustomAppBar(),
                      SizedBox(height: 50.h),

                      CommonImage(
                        imageSrc: "assets/images/musicimage.png",
                        height: 90,
                        width: 90,
                      ),
                      SizedBox(height: 30.h),

                      // Heading Title
                      const CommonText(
                        text: "Enter Your Phone Number",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      SizedBox(height: 10.h),

                      // Subtitle
                      const CommonText(
                        text: "We'll send you a verification code",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 36.h),

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
                          fillColor: const Color(
                            0xFF242424,
                          ).withValues(alpha: 0.5),
                          filled: true,
                          prefixText: '|   ',
                          prefixStyle: TextStyle(
                            color: Colors.white24,
                            fontSize: 16.sp,
                          ),
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
                      SizedBox(height: 30.h),

                      // Continue Submit Button
                      CommonButton(
                        titleText: "Sign In",
                        buttonHeight: 54.h,
                        isLoading: controller.isLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.signInUser();
                          }
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Footer Navigation links
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signUp),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Didn't have an account? ",
                                  style: GoogleFonts.lato(
                                    color: AppColors.textColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  style: GoogleFonts.lato(
                                    color: AppColors.primaryColor,
                                    fontSize: 15.sp,
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

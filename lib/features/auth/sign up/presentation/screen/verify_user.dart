import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/other_widgets/auth_custom_app_bar.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/sign_up_controller.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SignUpController.instance.startTimer();
    super.initState();
  }

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
            return SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Back Button Custom App Bar
                      const AuthCustomAppBar(),
                      SizedBox(height: 30.h),

                      // Center Crown & Musical Note Badge
                      _buildCrownNoteBadge(),
                      SizedBox(height: 24.h),

                      // Heading Title
                      const CommonText(
                        text: "Verify Account",
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),

                      // Dynamic Number Subtitle
                      CommonText(
                        text: "Enter The 6-Digit Code Sent To\n${controller.countryCode} ${controller.numberController.text}",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                      SizedBox(height: 36.h),

                      // Circular OTP Field Input
                      Flexible(
                        flex: 0,
                        child: PinCodeTextField(
                          controller: controller.otpController,
                          autoDisposeControllers: false,
                          cursorColor: Colors.white,
                          appContext: context,
                          autoFocus: true,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            fieldHeight: 48.h,
                            fieldWidth: 48.w,
                            activeFillColor: const Color(0xFF242424).withValues(alpha: 0.5),
                            selectedFillColor: const Color(0xFF242424).withValues(alpha: 0.5),
                            inactiveFillColor: const Color(0xFF242424).withValues(alpha: 0.5),
                            borderWidth: 1.5.r,
                            selectedColor: AppColors.primaryColor,
                            activeColor: AppColors.primaryColor,
                            inactiveColor: Colors.white24,
                          ),
                          textStyle: GoogleFonts.lato(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          hintCharacter: '-',
                          hintStyle: GoogleFonts.lato(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white38,
                          ),
                          length: 6,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          enableActiveFill: true,
                          validator: (value) {
                            if (value != null && value.length == 6) {
                              return null;
                            } else {
                              return "OTP is invalid";
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Resend Code Trigger text
                      GestureDetector(
                        onTap: controller.time == '00:00'
                            ? () {
                                controller.startTimer();
                                controller.signUpUser();
                              }
                            : null,
                        child: CommonText(
                          text: controller.time == '00:00'
                              ? "Resend Code"
                              : "Resend (${controller.time})",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 36.h),

                      // Verify Submit Button
                      CommonButton(
                        titleText: "Verify",
                        buttonHeight: 54.h,
                        isLoading: controller.isLoadingVerify,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.verifyOtp();
                          }
                        },
                      ),
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

  // --- Badge Helper ---
  Widget _buildCrownNoteBadge() {
    return Container(
      height: 76.r,
      width: 76.r,
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryColor, width: 2.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.18),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.workspace_premium, // Crown icon
            color: const Color(0xFFFFD700), // Gold
            size: 18.sp,
          ),
          SizedBox(height: 2.h),
          Icon(
            Icons.music_note,
            color: const Color(0xFFFFD700), // Gold
            size: 26.sp,
          ),
        ],
      ),
    );
  }
}

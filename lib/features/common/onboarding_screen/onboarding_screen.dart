import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_string.dart';

import '../../../component/button/common_button.dart';
import '../../../component/image/common_image.dart';
import '../../../utils/extensions/extension.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/on_boarding_screen_here.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 30.h,),
                  CommonImage(
                    imageSrc: "assets/images/onboarding_view.png",
                    height: 295.h,
                    width: 247.w,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/background_image.png"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), // Darkens the image so text is readable
                    BlendMode.darken,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CommonButton(
                    titleText: "Get Start",
                    borderColor: Colors.transparent,
                    onTap: (){
                      Get.toNamed(AppRoutes.selectRole);
                    },
                  ),
                  SizedBox(height: 14.h,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing you agree to our',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' Terms of service ',
                          style: GoogleFonts.lato(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h,),
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'And',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: ' Privacy Policy',
                        style: GoogleFonts.lato(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ]
                  )),
                  SizedBox(height: 40.h,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

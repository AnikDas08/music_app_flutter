import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../../../config/route/app_routes.dart';
import '../../../component/other_widgets/auth_custom_app_bar.dart';
import '../../../utils/constants/app_colors.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/select_role_image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthCustomAppBar(),
              SizedBox(height: 20,),
              const CommonText(
                  text: "Continue As",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
              SizedBox(height: 6.h,),
              const CommonText(
                text: "Choose how you want to use Muzikgen.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
              ),
              SizedBox(height: 32.h,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.artistOnboarding);
                },
                child: CommonImage(
                    imageSrc: "assets/images/artist_role_image.png",
                  height: 148.h,
                  width: double.infinity,
                  fill: BoxFit.fill,
                ),
              ),
              SizedBox(height: 16.h,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.listenerOnboarding);
                },
                child: CommonImage(
                  imageSrc: "assets/images/listner_role_image.png",
                  height: 148.h,
                  width: double.infinity,
                  fill: BoxFit.fill,
                ),
              ),
              SizedBox(height: 24.h,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.signIn);
                },
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
                              fontWeight: FontWeight.w700
                          ),
                        ),
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
}

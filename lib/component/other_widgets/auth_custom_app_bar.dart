import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../text/common_text.dart';
import '../../utils/constants/app_colors.dart';

class AuthCustomAppBar extends StatelessWidget {
  final String? title;
  const AuthCustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: Color(0xff242424),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]
                ),
                child: SvgPicture.asset(
                    "assets/icons/back_icon.svg",
                    height: 24.h,
                    width: 24.w,
                )
              ),
            ),
            if (title != null) ...[
              Expanded(
                child: CommonText(
                  text: title!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 36), // To balance the back button space for centering
            ]
          ],
        ),
      ),
    );
  }
}

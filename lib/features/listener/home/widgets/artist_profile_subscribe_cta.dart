import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';

class ArtistProfileSubscribeCta extends StatelessWidget {
  final String price;
  final String artistName;
  final String artistImage;

  const ArtistProfileSubscribeCta({
    super.key,
    required this.price,
    required this.artistName,
    required this.artistImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(
                AppRoutes.subscribePlan,
                arguments: {
                  'name': artistName,
                  'image': artistImage,
                  'price': price,
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.workspace_premium, // Crown Icon
                  color: Colors.white,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Subscribe Now- $price/Month",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(
            "Cancel Anytime • Secure Payment",
            style: GoogleFonts.lato(
              color: Colors.white38,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistProfileLockCard extends StatelessWidget {
  final String price;

  const ArtistProfileLockCard({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      margin: EdgeInsets.only(top: 16.h, bottom: 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF00C853).withValues(alpha: 0.3),
          width: 1.5.r,
        ),
      ),
      child: Column(
        children: [
          // Lock circle
          Container(
            height: 44.r,
            width: 44.r,
            decoration: BoxDecoration(
              color: const Color(0xFF00C853).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline,
              color: const Color(0xFF00C853),
              size: 22.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Subscribe To Unlock Full Catalog",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "Get Full Access To All Songs, Exclusive Content And Support This Artist Directly.",
            style: GoogleFonts.lato(
              color: Colors.white60,
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          // Green Subscribe button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              child: Text(
                "Subscribe - $price/Month",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'unlock_catalog_bottom_sheet.dart';

class ArtistProfileUnlockBanner extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  const ArtistProfileUnlockBanner({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1C),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Circular lock icon
          Container(
            height: 38.r,
            width: 38.r,
            decoration: BoxDecoration(
              color: const Color(0xFF00C853).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline,
              color: const Color(0xFF00C853),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          // Banner text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Unlock The Full Catalog",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Get Access To All Song, Exclusive Releases Offline Listening And More.",
                  style: GoogleFonts.lato(
                    color: Colors.white60,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Learn More link (clickable)
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                UnlockCatalogBottomSheet(
                  artistName: name,
                  artistImage: imagePath,
                  price: price,
                ),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: Row(
              children: [
                Text(
                  "Learn More",
                  style: GoogleFonts.lato(
                    color: const Color(0xFF00C853),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF00C853),
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

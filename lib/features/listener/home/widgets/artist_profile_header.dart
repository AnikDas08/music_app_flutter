import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistProfileHeader extends StatelessWidget {
  final String name;
  final String imagePath;
  final String track;

  const ArtistProfileHeader({
    super.key,
    required this.name,
    required this.imagePath,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Column Meta details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RECORDING ARTIST",
                style: GoogleFonts.lato(
                  color: const Color(0xFF00C853),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.check_circle,
                    color: const Color(0xFF00C853),
                    size: 18.sp,
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                "Uganda • $track",
                style: GoogleFonts.lato(
                  color: Colors.white60,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        // Right Side Profile image with golden gradient glow
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 130.r,
              width: 130.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF9F0A).withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Container(
              height: 110.r,
              width: 110.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

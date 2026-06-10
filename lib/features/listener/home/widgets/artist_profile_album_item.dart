import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistProfileAlbumItem extends StatelessWidget {
  final String title;
  final String year;
  final String songsCount;
  final String imagePath;
  final String? badge;
  final bool isLocked;

  const ArtistProfileAlbumItem({
    super.key,
    required this.title,
    required this.year,
    required this.songsCount,
    required this.imagePath,
    this.badge,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              imagePath,
              height: 52.r,
              width: 52.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (badge != null) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5E17EB).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            color: const Color(0xFF5E17EB),
                            width: 0.5.r,
                          ),
                        ),
                        child: Text(
                          badge!,
                          style: GoogleFonts.lato(
                            color: const Color(0xFF9E8EFE),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  "$year • $songsCount",
                  style: GoogleFonts.lato(
                    color: Colors.white38,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          // Trailing lock icon or play arrow
          Container(
            height: 36.r,
            width: 36.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLocked ? Icons.lock_outline : Icons.play_arrow,
              color: isLocked ? const Color(0xFF00C853) : Colors.white,
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}

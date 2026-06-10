import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistProfileStats extends StatelessWidget {
  const ArtistProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(Icons.people_outline, "12k", "Subscribers"),
          _buildStatDivider(),
          _buildStatItem(Icons.headphones_outlined, "1.2k", "Monthly Listeners"),
          _buildStatDivider(),
          _buildStatItem(Icons.music_note_outlined, "246", "Songs"),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white60, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              value,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.lato(
            color: Colors.white60,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 24.h,
      width: 1.w,
      color: Colors.white.withValues(alpha: 0.15),
    );
  }
}

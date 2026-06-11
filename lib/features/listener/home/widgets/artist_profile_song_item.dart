import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistProfileSongItem extends StatelessWidget {
  final String title;
  final String duration;
  final String plays;
  final String imagePath;
  final String? badge;
  final bool isLocked;

  const ArtistProfileSongItem({
    super.key,
    required this.title,
    required this.duration,
    required this.plays,
    required this.imagePath,
    this.badge,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: CustomPaint(
        painter: BottomBorderPainter(
          color: Colors.white.withValues(alpha: 0.18),
          radius: 12.r,
          strokeWidth: 1.r,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
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
              // Song Details
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: badge == "Exclusive"
                                  ? const Color(
                                      0xFF5E17EB,
                                    ).withValues(alpha: 0.2)
                                  : const Color(
                                      0xFFFFD700,
                                    ).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: badge == "Exclusive"
                                    ? const Color(0xFF5E17EB)
                                    : const Color(0xFFFFD700),
                                width: 0.5.r,
                              ),
                            ),
                            child: Text(
                              badge!,
                              style: GoogleFonts.lato(
                                color: badge == "Exclusive"
                                    ? const Color(0xFF9E8EFE)
                                    : const Color(0xFFFFD700),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white38,
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          duration,
                          style: GoogleFonts.lato(
                            color: Colors.white38,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 3.r,
                          width: 3.r,
                          decoration: const BoxDecoration(
                            color: Colors.white38,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          plays,
                          style: GoogleFonts.lato(
                            color: Colors.white38,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Trailing Lock Icon or Play Icon
              Container(
                height: 36.r,
                width: 36.r,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLocked ? Icons.lock_outline : Icons.play_arrow,
                  color: isLocked ? const Color(0xFF00C853) : Color(0xFF00C853),
                  size: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double strokeWidth;

  BottomBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    path.moveTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - radius,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

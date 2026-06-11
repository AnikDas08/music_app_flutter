import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/features/common/home_nav/controller/home_nav_controller.dart';
import 'package:muzikgen_app/features/listener/home/controller/music_player_controller.dart';
import 'package:muzikgen_app/features/listener/library/controller/listner_library_controller.dart';
import 'package:muzikgen_app/features/listener/library/widgets/up_next_queue_sheet.dart';

class PlaylistCreatedScreen extends StatelessWidget {
  const PlaylistCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final name = args["name"] ?? "New Playlist";
    final songsCount = args["songsCount"] ?? 0;
    final minutes = args["minutes"] ?? 0;
    final imagePath = args["imagePath"] ?? "";
    final List<Map<String, dynamic>> songs = List<Map<String, dynamic>>.from(args["songs"] ?? []);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F1F13), // Soft dark green glow
              Color(0xFF0A0A0A), // Black transition
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Green Checkmark inside circular badge with sparkles
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Decorative outer green sparkles (dots)
                    SizedBox(
                      height: 140.r,
                      width: 140.r,
                      child: CustomPaint(
                        painter: SparklePainter(),
                      ),
                    ),
                    
                    // Main green circle checkmark
                    Container(
                      height: 84.r,
                      width: 84.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1DB954),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Success text lines
              const CommonText(
                text: "Playlist Created",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: "$songsCount Songs Added",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8E8E93),
              ),
              SizedBox(height: 4.h),
              const CommonText(
                text: "Ready To Play",
                fontSize: 12,
                color: Color(0xFF636366),
              ),
              
              const Spacer(flex: 1),

              // Slanted Overlapping Covers stack
              _buildOverlappingCovers(songs, imagePath),
              SizedBox(height: 16.h),

              // Playlist name
              CommonText(
                text: name,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 6.h),

              // Playlist stats
              CommonText(
                text: "♬ $songsCount Songs • 🕑 $minutes Minutes",
                fontSize: 12,
                color: const Color(0xFF8E8E93),
              ),

              const Spacer(flex: 2),

              // Play Now green button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      final List<Map<String, dynamic>> mappedSongs = songs.map((s) => {
                        "id": s["id"] ?? "",
                        "title": s["title"] ?? "Unknown Track",
                        "artist": s["artist"] ?? "Unknown Artist",
                        "duration": s["duration"] ?? "3:50",
                        "image": s["image"] ?? s["imagePath"] ?? "",
                        "imagePath": s["image"] ?? s["imagePath"] ?? "",
                      }).toList();

                      // Close the 4 creation wizard screens to go back to the library view
                      Get.close(4);

                      // Load playlist and start play
                      final playerController = Get.isRegistered<MusicPlayerController>()
                          ? Get.find<MusicPlayerController>()
                          : Get.put(MusicPlayerController());
                      
                      playerController.loadPlaylist(mappedSongs, 0);

                      // Open the Up Next queue bottom sheet
                      Get.bottomSheet(
                        const UpNextQueueSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1DB954),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CommonText(
                          text: "Play Now ",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // View Playlist grey button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // Switch main navbar to Library (index 2)
                      final homeNavController = Get.isRegistered<HomeNavController>()
                          ? Get.find<HomeNavController>()
                          : Get.put(HomeNavController());
                      homeNavController.changeIndex(2);

                      // Switch Library to Playlist tab (index 3)
                      final libraryController = Get.isRegistered<ListnerLibraryController>()
                          ? Get.find<ListnerLibraryController>()
                          : Get.put(ListnerLibraryController());
                      libraryController.selectedTab.value = 3;
                      libraryController.showRecentlyPlayedDetails.value = false;

                      // Close the 4 creation wizard screens to go back to the library view
                      Get.close(4);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                      elevation: 0,
                    ),
                    child: const CommonText(
                      text: "View Playlist",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverlappingCovers(List<Map<String, dynamic>> songs, String userImagePath) {
    // Collect cover images
    final List<String> images = [];
    
    // 1st cover is the user's picked image if present
    if (userImagePath.isNotEmpty) {
      images.add(userImagePath);
    }
    
    // Remaining covers from songs list
    for (var s in songs) {
      if (s["image"] != null && s["image"] != userImagePath) {
        images.add(s["image"]);
      }
    }
    
    // Fallback covers
    while (images.length < 3) {
      images.add("assets/images/artist_onboarding_first.png");
    }

    return SizedBox(
      height: 180.h,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Left Slanted image
            Transform(
              transform: Matrix4.translationValues(-40.w, 15.h, 0.0)
                ..rotateZ(-0.15),
              alignment: Alignment.center,
              child: _buildCoverCard(images[0]),
            ),
            
            // Right Slanted image
            Transform(
              transform: Matrix4.translationValues(40.w, 15.h, 0.0)
                ..rotateZ(0.15),
              alignment: Alignment.center,
              child: _buildCoverCard(images[2]),
            ),
            
            // Center straight image (on top of others)
            Transform(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              alignment: Alignment.center,
              child: _buildCoverCard(images[1]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverCard(String path) {
    return Container(
      width: 100.w,
      height: 130.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: path.startsWith('assets/')
            ? Image.asset(path, fit: BoxFit.cover)
            : Image.file(File(path), fit: BoxFit.cover),
      ),
    );
  }
}

// Painter to draw decorative green sparkles around checkmark
class SparklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1DB954).withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    
    // Coordinates of decorative dot coordinates around the checkmark
    final points = [
      Offset(center.dx - 45.w, center.dy - 35.h),
      Offset(center.dx - 30.w, center.dy - 55.h),
      Offset(center.dx + 45.w, center.dy - 40.h),
      Offset(center.dx + 30.w, center.dy - 60.h),
      Offset(center.dx - 60.w, center.dy),
      Offset(center.dx + 60.w, center.dy),
      Offset(center.dx - 45.w, center.dy + 40.h),
      Offset(center.dx + 45.w, center.dy + 45.h),
      Offset(center.dx, center.dy - 65.h),
    ];

    for (var p in points) {
      canvas.drawCircle(p, 3.r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

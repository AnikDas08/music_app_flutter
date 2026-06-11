import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/features/listener/home/controller/music_player_controller.dart';

class UpNextQueueSheet extends StatelessWidget {
  const UpNextQueueSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final playerController = Get.isRegistered<MusicPlayerController>()
        ? Get.find<MusicPlayerController>()
        : Get.put(MusicPlayerController());

    return Container(
      height: 640.h,
      decoration: BoxDecoration(
        color: const Color(0xFF151516), // Dark grey premium background
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Drag Handle
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header Row: Up Next (N) and Clear Queue
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Obx(() {
              final count = playerController.playlist.length;
              return Row(
                children: [
                  const CommonText(
                    text: "Up Next",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    height: 24.r,
                    width: 24.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$count",
                        style: GoogleFonts.lato(
                          color: Colors.white60,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      playerController.playlist.clear();
                      playerController.currentSongIndex.value = 0;
                      playerController.isPlaying.value = false;
                    },
                    child: const CommonText(
                      text: "Clear Queue",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1DB954), // Spotify Green
                    ),
                  ),
                ],
              );
            }),
          ),
          SizedBox(height: 12.h),

          // Scrollable Queue List
          Expanded(
            child: Obx(() {
              if (playerController.playlist.isEmpty) {
                return const Center(
                  child: CommonText(
                    text: "Queue is empty",
                    fontSize: 15,
                    color: Colors.white30,
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: playerController.playlist.length,
                itemBuilder: (context, index) {
                  final item = playerController.playlist[index];
                  final isCurrent = index == playerController.currentSongIndex.value;
                  
                  final title = item["title"] ?? "Unknown Track";
                  final artist = item["artist"] ?? "Unknown Artist";
                  final duration = item["duration"] ?? "3:50";
                  final image = item["image"] ?? item["imagePath"] ?? "";

                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      children: [
                        // Left index number or animated equalizer bars
                        SizedBox(
                          width: 32.w,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: isCurrent
                                ? const EqualizerIndicator()
                                : Text(
                                    "${index + 1}",
                                    style: GoogleFonts.lato(
                                      color: Colors.white54,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),

                        // Thumbnail artwork
                        GestureDetector(
                          onTap: () => playerController.selectSong(index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: SizedBox(
                              width: 52.r,
                              height: 52.r,
                              child: _buildCoverImage(image),
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),

                        // Song Details
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => playerController.selectSong(index),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "$artist • $duration",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(
                                    color: Colors.white54,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                if (isCurrent) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Now Playing",
                                    style: GoogleFonts.lato(
                                      color: const Color(0xFF1DB954),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),

                        // Trailing Hamburger Menu (Current Song) or red Cross Delete (other songs)
                        if (isCurrent)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Icon(
                              Icons.menu_rounded,
                              color: Colors.white60,
                              size: 20.sp,
                            ),
                          )
                        else
                          IconButton(
                            onPressed: () => _removeSongFromQueue(playerController, index),
                            icon: Icon(
                              Icons.close_rounded,
                              color: const Color(0xFFFF3B30), // Warning red
                              size: 20.sp,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          // Sticky Footer: Auto Play Toggle Switch
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E), // Slightly lighter dark grey background
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 1.r,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: "Auto Play",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4.h),
                        const CommonText(
                          text: "Similar Songs Will Play Automatically",
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ],
                    ),
                  ),
                  Obx(() => Switch(
                        value: playerController.isAutoPlay.value,
                        onChanged: (val) => playerController.isAutoPlay.value = val,
                        activeThumbColor: const Color(0xFF1DB954),
                        activeTrackColor: const Color(0xFF1DB954).withValues(alpha: 0.3),
                        inactiveThumbColor: Colors.white30,
                        inactiveTrackColor: Colors.white10,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage(String path) {
    if (path.isEmpty) {
      return Image.asset(
        "assets/images/artist_onboarding_first.png",
        fit: BoxFit.cover,
      );
    }
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(path),
      fit: BoxFit.cover,
    );
  }

  void _removeSongFromQueue(MusicPlayerController playerController, int index) {
    if (playerController.playlist.length <= 1) {
      playerController.playlist.clear();
      playerController.currentSongIndex.value = 0;
      playerController.isPlaying.value = false;
      return;
    }
    
    final int currentIndex = playerController.currentSongIndex.value;
    if (index == currentIndex) {
      if (index == playerController.playlist.length - 1) {
        playerController.currentSongIndex.value = index - 1;
      }
      playerController.playlist.removeAt(index);
      playerController.selectSong(playerController.currentSongIndex.value);
    } else {
      if (index < currentIndex) {
        playerController.currentSongIndex.value = currentIndex - 1;
      }
      playerController.playlist.removeAt(index);
    }
  }
}

// Staggered animated audio equalizer bars
class EqualizerIndicator extends StatefulWidget {
  const EqualizerIndicator({super.key});

  @override
  State<EqualizerIndicator> createState() => _EqualizerIndicatorState();
}

class _EqualizerIndicatorState extends State<EqualizerIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animations = List.generate(3, (index) {
      final start = index * 0.2;
      final end = start + 0.6;
      return Tween<double>(begin: 4.h, end: 18.h).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      height: 20.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 3.w,
                height: _animations[index].value,
                decoration: BoxDecoration(
                  color: const Color(0xFF1DB954),
                  borderRadius: BorderRadius.circular(1.5.r),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

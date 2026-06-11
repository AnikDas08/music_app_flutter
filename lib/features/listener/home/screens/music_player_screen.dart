import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/music_player_controller.dart';
import '../widgets/music_player_more_options_sheet.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final MusicPlayerController controller = Get.put(MusicPlayerController());
  bool _isUpNextExpanded = true;

  @override
  void initState() {
    super.initState();
    // Load arguments
    final List<Map<String, dynamic>> songs = Get.arguments?['songs'] ?? [];
    final int initialIndex = Get.arguments?['index'] ?? 0;

    if (songs.isNotEmpty) {
      controller.loadPlaylist(songs, initialIndex);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }



  @override
  Widget build(BuildContext context) {
    final String artistName = Get.arguments?['artistName'] ?? "Kendi Mustiq";

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0E2519), // Dark green at top
            Color(0xFF0A0A0A), // Black at bottom
          ],
          stops: [0.0, 0.4],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.white, size: 24.sp),
              padding: EdgeInsets.zero,
              onPressed: () => Get.back(),
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                artistName,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(Icons.verified, color: const Color(0xFF00C853), size: 18.sp),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz, color: Colors.white, size: 24.sp),
              onPressed: () => MusicPlayerMoreOptionsSheet.show(context),
            ),
            SizedBox(width: 8.w),
          ],
        ),
        body: Obx(() {
          if (controller.playlist.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF00C853)),
            );
          }

          final song = controller.currentSong;
          final String title = song['title'] ?? "Sunset Dreams";
          final String imagePath =
              song['imagePath'] ?? "assets/images/artist_onboarding_first.png";

          // Calculate "Up Next" songs (all songs in playlist except the current one)
          final upNextSongs = <Map<String, dynamic>>[];
          for (int i = 0; i < controller.playlist.length; i++) {
            if (i != controller.currentSongIndex.value) {
              upNextSongs.add({...controller.playlist[i], 'originalIndex': i});
            }
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cover Art Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    imagePath,
                    height: 260.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 24.h),

                // Song Title, Artist & Actions (Favorite, Download)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title and Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Text(
                                artistName,
                                style: GoogleFonts.lato(
                                  color: Colors.white60,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.verified,
                                color: const Color(0xFF00C853),
                                size: 14.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Favorite button
                    GestureDetector(
                      onTap: () => controller.toggleFavorite(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            controller.isFavorite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.isFavorite.value
                                ? const Color(0xFFE91E63)
                                : Colors.white60,
                            size: 24.sp,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Favorite",
                            style: GoogleFonts.lato(
                              color: Colors.white60,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Download button
                    GestureDetector(
                      onTap: () {
                        // Mock download trigger
                        Get.snackbar(
                          "Download Status",
                          "Downloading $title...",
                          backgroundColor: const Color(0xFF131315),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_download_outlined,
                            color: Colors.white60,
                            size: 24.sp,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Download",
                            style: GoogleFonts.lato(
                              color: Colors.white60,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Custom Slider Progress Bar
                Theme(
                  data: Theme.of(context).copyWith(
                    sliderTheme: SliderThemeData(
                      trackShape: GradientSliderTrackShape(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFEC2F96),
                            Color(0xFFAF3AF8), // Purple/magenta
                            Color(0xFFEC2F96), // Pink
                          ],
                        ),
                      ),
                      trackHeight: 3.h,
                      inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
                      thumbColor: Colors.white,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 6.r,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 12.r,
                      ),
                    ),
                  ),
                  child: Slider(
                    min: 0.0,
                    max: controller.totalDuration.value.inSeconds.toDouble(),
                    value: controller.currentPosition.value.inSeconds
                        .toDouble(),
                    onChanged: (value) {
                      controller.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                // Time Indicators
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(controller.currentPosition.value),
                        style: GoogleFonts.lato(
                          color: Colors.white60,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        _formatDuration(controller.totalDuration.value),
                        style: GoogleFonts.lato(
                          color: Colors.white60,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Playback Control Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Shuffle
                    IconButton(
                      icon: Icon(
                        Icons.shuffle,
                        color: controller.isShuffle.value
                            ? const Color(0xFFE91E63)
                            : Colors.white60,
                        size: 22.sp,
                      ),
                      onPressed: () => controller.toggleShuffle(),
                    ),
                    // Skip Previous
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                      onPressed: () => controller.previousSong(),
                    ),
                    // Play / Pause Circle
                    GestureDetector(
                      onTap: () => controller.togglePlayPause(),
                      child: Container(
                        height: 64.r,
                        width: 64.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFAF3AF8), // Pink/magenta
                              Color(0xFFEC2F96), // Purple
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            controller.isPlaying.value
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 36.sp,
                          ),
                        ),
                      ),
                    ),
                    // Skip Next
                    IconButton(
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                      onPressed: () => controller.nextSong(),
                    ),
                    // Repeat
                    IconButton(
                      icon: Icon(
                        Icons.repeat,
                        color: controller.isRepeat.value
                            ? const Color(0xFFE91E63)
                            : Colors.white60,
                        size: 22.sp,
                      ),
                      onPressed: () => controller.toggleRepeat(),
                    ),
                  ],
                ),
                SizedBox(height: 28.h),

                // Support Artist Button
                SizedBox(
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.supportArtist,
                        arguments: {
                          'name': artistName,
                          'image': imagePath,
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFEC2F96),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: const Color(0xFFE91E63),
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Support Artist",
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
                SizedBox(height: 28.h),

                // Up Next Header
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isUpNextExpanded = !_isUpNextExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        "Up Next",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          "${upNextSongs.length}",
                          style: GoogleFonts.lato(
                            color: Colors.white70,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _isUpNextExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white60,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Up Next Songs List
                if (_isUpNextExpanded) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: upNextSongs.length,
                    itemBuilder: (context, index) {
                      final item = upNextSongs[index];
                      final int originalIndex = item['originalIndex'];
                      return GestureDetector(
                        onTap: () {
                          controller.selectSong(originalIndex);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFF131315),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.asset(
                                  item['imagePath'] ??
                                      "assets/images/artist_onboarding_first.png",
                                  height: 48.r,
                                  width: 48.r,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'] ?? "Unknown Title",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      artistName,
                                      style: GoogleFonts.lato(
                                        color: Colors.white60,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Duration
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white38,
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    item['duration'] ?? "3:50",
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
                      );
                    },
                  ),
                ],
                SizedBox(height: 16.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class GradientSliderTrackShape extends RoundedRectSliderTrackShape {
  final LinearGradient gradient;

  GradientSliderTrackShape({required this.gradient});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    double additionalActiveTrackHeight = 2.0,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Track active segment rect
    final activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    // Track inactive segment rect
    final inactiveRect = Rect.fromLTRB(
      thumbCenter.dx,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeRect);

    final Paint inactivePaint = Paint()
      ..color = isEnabled
          ? sliderTheme.inactiveTrackColor!
          : sliderTheme.disabledInactiveTrackColor!;

    // Draw inactive track with rounded corners
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        inactiveRect,
        Radius.circular(trackRect.height / 2),
      ),
      inactivePaint,
    );

    // Draw active track with rounded corners
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        activeRect,
        Radius.circular(trackRect.height / 2),
      ),
      activePaint,
    );
  }
}

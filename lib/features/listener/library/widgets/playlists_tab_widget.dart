import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'playlist_more_options_sheet.dart';
import '../controller/listner_library_controller.dart';
import 'package:muzikgen_app/features/listener/home/controller/music_player_controller.dart';
import 'up_next_queue_sheet.dart';


class PlaylistsTabWidget extends StatelessWidget {
  final ListnerLibraryController controller;

  const PlaylistsTabWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Create Playlist Box
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.createPlaylist);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1E14), // Dark green background tint
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF1DB954).withValues(alpha: 0.3), width: 1.r),
            ),
            child: Row(
              children: [
                Container(
                  height: 44.r,
                  width: 44.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFF122318),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Color(0xFF1DB954),
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "Create Playlist",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      CommonText(
                        text: "Create And Organize Your Music",
                        fontSize: 12,
                        color: Color(0xFF8E8E93),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // List of Playlists
        Obx(() {
          if (controller.filteredPlaylists.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: CommonText(
                  text: "No playlists matches found",
                  fontSize: 14,
                  color: Color(0xFF8E8E93),
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.filteredPlaylists.length,
            itemBuilder: (context, index) {
              final item = controller.filteredPlaylists[index];
              final isCustom = item["isCustomImage"] == true;
              return GestureDetector(
                onTap: () {
                  final rawSongs = item["songs"] as List<Map<String, dynamic>>?;
                  final List<Map<String, dynamic>> selectedSongs = (rawSongs != null && rawSongs.isNotEmpty)
                      ? rawSongs
                      : [
                          {
                            "id": "1",
                            "title": "Mid Night Vibes",
                            "artist": "Shaka",
                            "duration": "3:55",
                            "image": "assets/images/artist_onboarding_first.png",
                          },
                          {
                            "id": "2",
                            "title": "See You Tonight",
                            "artist": "Cindy Sanyu",
                            "duration": "5:55",
                            "image": "assets/images/listener_onboarding_first.png",
                          },
                          {
                            "id": "3",
                            "title": "Champion Gal",
                            "artist": "Size Yange",
                            "duration": "4:55",
                            "image": "assets/images/listener_onboarding_second.png",
                          },
                          {
                            "id": "4",
                            "title": "Komawo",
                            "artist": "Ava Peace",
                            "duration": "2:55",
                            "image": "assets/images/listener_onboarding_third.png",
                          },
                        ];

                  final List<Map<String, dynamic>> mappedSongs = selectedSongs.map((s) => {
                    "id": s["id"] ?? "",
                    "title": s["title"] ?? "Unknown Track",
                    "artist": s["artist"] ?? "Unknown Artist",
                    "duration": s["duration"] ?? "3:50",
                    "image": s["image"] ?? s["imagePath"] ?? "",
                    "imagePath": s["image"] ?? s["imagePath"] ?? "",
                  }).toList();

                  // Load playlist and play
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
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF18181A),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      if (isCustom)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: item["image"]!.startsWith('assets/')
                              ? Image.asset(
                                  item["image"]!,
                                  height: 44.r,
                                  width: 44.r,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(item["image"]!),
                                  height: 44.r,
                                  width: 44.r,
                                  fit: BoxFit.cover,
                                ),
                        )
                      else
                        Container(
                          height: 44.r,
                          width: 44.r,
                          decoration: BoxDecoration(
                            color: item["bgColor"],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Icon(
                              item["icon"] as IconData,
                              color: item["iconColor"] as Color,
                              size: 22.sp,
                            ),
                          ),
                        ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: item["title"]!,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            CommonText(
                              text: item["songsCount"]!,
                              fontSize: 12,
                              color: const Color(0xFF8E8E93),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            const PlaylistMoreOptionsSheet(),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Icon(
                            Icons.more_vert,
                            color: const Color(0xFF8E8E93),
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

        }),
      ],
    );
  }
}

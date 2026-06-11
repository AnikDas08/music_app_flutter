import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import '../controller/listner_library_controller.dart';
import 'playlist_more_options_sheet.dart';


class RecentTabWidget extends StatelessWidget {
  final ListnerLibraryController controller;

  const RecentTabWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recently Played Header
        _buildSectionHeader(
          title: "Recently Played",
          onSeeAllTap: () => Get.toNamed(AppRoutes.recentlyPlayed),
        ),
        SizedBox(height: 12.h),

        // Recently Played Horizontal List
        _buildRecentlyPlayedList(),
        SizedBox(height: 24.h),

        // Your Playlists Header
        _buildSectionHeader(
          title: "Your Playlists",
          onSeeAllTap: () => controller.changeTab(3),
        ),
        SizedBox(height: 12.h),

        // Your Playlists Dashboard List
        _buildPlaylistsDashboardList(),
        SizedBox(height: 24.h),

        // Your Artists Header
        _buildSectionHeader(
          title: "Your Artists",
          onSeeAllTap: () => controller.changeTab(4),
        ),
        SizedBox(height: 12.h),

        // Your Artists Dashboard List
        _buildArtistsDashboardList(),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onSeeAllTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: const CommonText(
            text: "See All",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1DB954),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyPlayedList() {
    return SizedBox(
      height: 185.h,
      child: Obx(() {
        if (controller.filteredRecentlyPlayed.isEmpty) {
          return const Center(
            child: CommonText(
              text: "No recently played matches found",
              fontSize: 14,
              color: Color(0xFF8E8E93),
            ),
          );
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.filteredRecentlyPlayed.length,
          itemBuilder: (context, index) {
            final item = controller.filteredRecentlyPlayed[index];
            return Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: GestureDetector(
                onTap: () {
                  final List<Map<String, dynamic>> mappedSongs = controller.recentlyPlayed.map((s) => {
                    "title": s["title"],
                    "artist": s["artist"],
                    "duration": s["duration"] ?? "3:50",
                    "image": s["image"] ?? s["imagePath"] ?? "assets/images/artist_onboarding_first.png",
                    "imagePath": s["image"] ?? s["imagePath"] ?? "assets/images/artist_onboarding_first.png",
                  }).toList();

                  Get.toNamed(
                    AppRoutes.musicPlayer,
                    arguments: {
                      'songs': mappedSongs,
                      'index': index,
                      'artistName': item["artist"] ?? "Kendi Mustaq",
                    },
                  );
                },
                child: SizedBox(
                  width: 120.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              item["image"]!,
                              height: 120.h,
                              width: 120.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 8.h,
                            right: 8.w,
                            child: Container(
                              height: 28.r,
                              width: 28.r,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1DB954),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CommonText(
                        text: item["title"]!,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: const Color(0xFF8E8E93),
                            size: 13.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: CommonText(
                              text: item["artist"]!,
                              fontSize: 12,
                              color: const Color(0xFF8E8E93),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildPlaylistsDashboardList() {
    return Obx(() {
      final items = controller.filteredPlaylists.take(3).toList();
      if (items.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
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
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
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

              Get.toNamed(
                AppRoutes.musicPlayer,
                arguments: {
                  'songs': mappedSongs,
                  'index': 0,
                  'artistName': item["title"] ?? "Kendi Mustaq",
                },
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
    });
  }

  Widget _buildArtistsDashboardList() {
    return Obx(() {
      final items = controller.filteredArtists.take(2).toList();
      if (items.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: CommonText(
              text: "No artists matches found",
              fontSize: 14,
              color: Color(0xFF8E8E93),
            ),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.artistAllSongs,
                arguments: {
                  'name': item["name"]!,
                  'isSubscribed': true,
                  'image': item["image"]!,
                  'price': 'UGX 1,000',
                },
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
                  ClipOval(
                    child: Image.asset(
                      item["image"]!,
                      height: 44.r,
                      width: 44.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: CommonText(
                                text: item["name"]!,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (item["isVerified"] == true) ...[
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.verified_rounded,
                                color: const Color(0xFF1DB954),
                                size: 15.sp,
                              ),
                            ],
                          ],
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
                  Icon(
                    Icons.chevron_right_rounded,
                    color: const Color(0xFF8E8E93),
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

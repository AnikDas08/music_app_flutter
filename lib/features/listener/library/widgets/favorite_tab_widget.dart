import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/listner_library_controller.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';


class FavoriteTabWidget extends StatelessWidget {
  final ListnerLibraryController controller;

  const FavoriteTabWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.filteredFavoriteSongs.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: CommonText(
              text: "No favorite songs matches found",
              fontSize: 14,
              color: Color(0xFF8E8E93),
            ),
          ),
        );
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.filteredFavoriteSongs.length,
        separatorBuilder: (context, index) =>
            Divider(color: Colors.white.withValues(alpha: 0.08), height: 24.h),
        itemBuilder: (context, index) {
          final item = controller.filteredFavoriteSongs[index];
          return GestureDetector(
            onTap: () {
              final List<Map<String, dynamic>> mappedSongs = controller.favoriteSongs.map((s) => {
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
            child: Row(
              children: [
                // Album art
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    item["image"]!,
                    height: 56.h,
                    width: 56.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 14.w),
                // Song Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: CommonText(
                              text: item["title"]!,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item["badge"] != null) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: item["badgeBgColor"],
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: CommonText(
                                text: item["badge"]!,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: item["badgeTextColor"],
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: const Color(0xFF8E8E93),
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: CommonText(
                              text: item["artist"]!,
                              fontSize: 12,
                              color: const Color(0xFF8E8E93),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: const Color(0xFF8E8E93),
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: CommonText(
                              text: "${item["duration"]!} • ${item["plays"]!}",
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
                // Play Button
                Container(
                  height: 36.r,
                  width: 36.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1DB954),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

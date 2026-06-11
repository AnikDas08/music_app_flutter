import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/listner_library_controller.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';


class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListnerLibraryController>(
      init: ListnerLibraryController(),
      builder: (controller) {
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
                  Color(0xFF0B1F13), // Soft dark green glow at the top
                  Color(0xFF0A0A0A), // Black transition
                ],
                stops: [0.0, 0.35],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom App Bar / Header with Back Button (Fixed/Static at the top)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 48.r,
                            width: 48.r,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1C1C1E),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.chevron_left_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(right: 48.w), // Offset back button to center title
                              child: const CommonText(
                                text: "Recently Played",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Grid View Area (Scrolls independently of the top bar)
                  Expanded(
                    child: Obx(() {
                      if (controller.filteredRecentlyPlayedSongs.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.0),
                            child: CommonText(
                              text: "No recently played matches found",
                              fontSize: 14,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 0.64,
                        ),
                        itemCount: controller.filteredRecentlyPlayedSongs.length,
                        itemBuilder: (context, index) {
                          final item = controller.filteredRecentlyPlayedSongs[index];
                          return GestureDetector(
                            onTap: () {
                              final List<Map<String, dynamic>> mappedSongs = controller.recentlyPlayedSongs.map((s) => {
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.asset(
                                        item["image"]!,
                                        height: 100.h,
                                        width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 6.h,
                                      right: 6.w,
                                      child: Container(
                                        height: 24.r,
                                        width: 24.r,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1DB954),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                CommonText(
                                  text: item["title"]!,
                                  fontSize: 13,
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
                                      size: 12.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: CommonText(
                                        text: item["artist"]!,
                                        fontSize: 11,
                                        color: const Color(0xFF8E8E93),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

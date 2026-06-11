import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/listner_library_controller.dart';
import 'download_more_options_sheet.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';


class DownloadsTabWidget extends StatelessWidget {
  final ListnerLibraryController controller;

  const DownloadsTabWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Download Row info
        Row(
          children: [
            Container(
              height: 44.r,
              width: 44.r,
              decoration: const BoxDecoration(
                color: Color(0xFF122318),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: const Color(0xFF1DB954),
                  size: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: "Downloaded",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  SizedBox(height: 2.h),
                  const CommonText(
                    text: "80 Song • 8h 45m",
                    fontSize: 12,
                    color: Color(0xFF8E8E93),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF122318),
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(color: const Color(0xFF1DB954), width: 1.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bolt_rounded,
                    color: const Color(0xFF1DB954),
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  const CommonText(
                    text: "Offline Mode",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1DB954),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Dropdown button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CommonText(
                text: "Recently Download",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 16.sp,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // Downloaded songs list
        Obx(() {
          if (controller.filteredDownloadedSongs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: CommonText(
                  text: "No downloaded songs matches found",
                  fontSize: 14,
                  color: Color(0xFF8E8E93),
                ),
              ),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.filteredDownloadedSongs.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.08),
              height: 24.h,
            ),
            itemBuilder: (context, index) {
              final item = controller.filteredDownloadedSongs[index];
              return GestureDetector(
                onTap: () {
                  final List<Map<String, dynamic>> mappedSongs = controller.downloadedSongs.map((s) => {
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
                    // Cover
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
                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: item["title"]!,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: const Color(0xFF8E8E93),
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              CommonText(
                                text: item["artist"]!,
                                fontSize: 12,
                                color: const Color(0xFF8E8E93),
                              ),
                              SizedBox(width: 6.w),
                              const CommonText(
                                text: "•",
                                fontSize: 12,
                                color: Color(0xFF8E8E93),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.access_time_rounded,
                                color: const Color(0xFF8E8E93),
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              CommonText(
                                text: item["duration"]!,
                                fontSize: 12,
                                color: const Color(0xFF8E8E93),
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
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          const DownloadMoreOptionsSheet(),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Icon(
                          Icons.more_vert,
                          color: const Color(0xFF8E8E93),
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

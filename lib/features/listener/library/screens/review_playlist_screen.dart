import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/review_playlist_controller.dart';

class ReviewPlaylistScreen extends StatelessWidget {
  const ReviewPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate or find the controller
    final controller = Get.put(ReviewPlaylistController());

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
              // Custom Header Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const CommonText(
                      text: "Review Playlist",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () => controller.createPlaylist(),
                      child: const CommonText(
                        text: "Create",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1DB954),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Scrollable content area
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    
                    // Large playlist cover image
                    Center(
                      child: Stack(
                        children: [
                          Obx(() {
                            final imagePath = controller.imagePath;
                            final hasSongs = controller.previewItems.isNotEmpty;
                            final resolvedImage = imagePath.isNotEmpty 
                                ? imagePath 
                                : (hasSongs ? controller.previewItems[0]["image"]! : "assets/images/artist_onboarding_first.png");
                            
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: resolvedImage.startsWith('assets/')
                                  ? Image.asset(
                                      resolvedImage,
                                      height: 150.r,
                                      width: 150.r,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(resolvedImage),
                                      height: 150.r,
                                      width: 150.r,
                                      fit: BoxFit.cover,
                                    ),
                            );
                          }),
                          
                          // Overlay camera icon at bottom right of cover art
                          Positioned(
                            bottom: 6.r,
                            right: 6.r,
                            child: Container(
                              height: 36.r,
                              width: 36.r,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1DB954),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    
                    // Playlist Name
                    Center(
                      child: CommonText(
                        text: controller.name,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    
                    // Playlist Stats
                    Center(
                      child: Obx(() => CommonText(
                        text: "♬ ${controller.totalSongsCount} Songs • 🕑 ${controller.totalMinutes} Minutes",
                        fontSize: 13,
                        color: const Color(0xFF8E8E93),
                      )),
                    ),
                    SizedBox(height: 20.h),
                    
                    // Divider
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Divider(
                        color: Colors.white.withValues(alpha: 0.08),
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    
                    // Songs Preview list
                    Expanded(
                      child: Obx(() {
                        if (controller.previewItems.isEmpty) {
                          return const Center(
                            child: CommonText(
                              text: "No items in playlist",
                              fontSize: 14,
                              color: Color(0xFF8E8E93),
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: controller.previewItems.length,
                          itemBuilder: (context, index) {
                            final song = controller.previewItems[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.asset(
                                      song["image"]!,
                                      height: 56.r,
                                      width: 56.r,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text: song["title"]!,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
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
                                            CommonText(
                                              text: "${song["artist"]!}  •  ",
                                              fontSize: 12,
                                              color: const Color(0xFF8E8E93),
                                            ),
                                            Icon(
                                              Icons.access_time_rounded,
                                              color: const Color(0xFF8E8E93),
                                              size: 13.sp,
                                            ),
                                            SizedBox(width: 4.w),
                                            CommonText(
                                              text: song["duration"]!,
                                              fontSize: 12,
                                              color: const Color(0xFF8E8E93),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Red Remove Cross action
                                  GestureDetector(
                                    onTap: () => controller.removeItem(song),
                                    child: Container(
                                      height: 36.r,
                                      width: 36.r,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Color(0xFFFF3B30),
                                          size: 20,
                                        ),
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}

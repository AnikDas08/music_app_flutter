import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/add_song_to_playlist_controller.dart';

class AddSongToPlaylistScreen extends StatelessWidget {
  const AddSongToPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve playlist arguments passed from CreatePlaylistScreen
    final playlistArgs = Get.arguments as Map<String, dynamic>? ?? {};

    // Instantiate or find the controller
    final controller = Get.put(AddSongToPlaylistController());

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
              // Header Row
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
                    Obx(() => CommonText(
                      text: controller.selectedTab.value == 0 ? "Add Song" : "Add Album",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                    GestureDetector(
                      onTap: () => controller.submit(playlistArgs),
                      child: Obx(() => CommonText(
                        text: "Done (${controller.totalSelectedCount})",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1DB954),
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: const Color(0xFF8E8E93),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Search Your Library",
                            hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Tabs (Songs & Album)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  final selected = controller.selectedTab.value;
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedTab.value = 0,
                          child: Column(
                            children: [
                              CommonText(
                                text: "Songs",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: selected == 0 ? const Color(0xFF1DB954) : const Color(0xFF8E8E93),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 2.h,
                                color: selected == 0 ? const Color(0xFF1DB954) : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedTab.value = 1,
                          child: Column(
                            children: [
                              CommonText(
                                text: "Album",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: selected == 1 ? const Color(0xFF1DB954) : const Color(0xFF8E8E93),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 2.h,
                                color: selected == 1 ? const Color(0xFF1DB954) : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 16.h),

              // Content List Area
              Expanded(
                child: Obx(() {
                  final isSongs = controller.selectedTab.value == 0;
                  
                  if (isSongs) {
                    // Render Songs List
                    if (controller.filteredSongs.isEmpty) {
                      return const Center(
                        child: CommonText(
                          text: "No matching songs found",
                          fontSize: 14,
                          color: Color(0xFF8E8E93),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: controller.filteredSongs.length,
                      itemBuilder: (context, index) {
                        final song = controller.filteredSongs[index];
                        final isSelected = controller.isSongSelected(song);
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
                              Obx(() {
                                final isSelected = controller.isSongSelected(song);
                                return GestureDetector(
                                  onTap: () => controller.toggleSong(song),
                                  child: Container(
                                    height: 36.r,
                                    width: 36.r,
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF1DB954) : Colors.white.withValues(alpha: 0.08),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        isSelected ? Icons.check_rounded : Icons.add_rounded,
                                        color: isSelected ? Colors.white : const Color(0xFF1DB954),
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    // Render Album Grid
                    if (controller.filteredAlbums.isEmpty) {
                      return const Center(
                        child: CommonText(
                          text: "No matching albums found",
                          fontSize: 14,
                          color: Color(0xFF8E8E93),
                        ),
                      );
                    }
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: controller.filteredAlbums.length,
                      itemBuilder: (context, index) {
                        final album = controller.filteredAlbums[index];
                        final isSelected = controller.isAlbumSelected(album);
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.asset(
                                  album["image"]!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 6.h,
                              right: 6.w,
                              child: Obx(() {
                                final isSelected = controller.isAlbumSelected(album);
                                return GestureDetector(
                                  onTap: () => controller.toggleAlbum(album),
                                  child: Container(
                                    height: 24.r,
                                    width: 24.r,
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF1DB954) : Colors.black.withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white24, width: 1.r),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        isSelected ? Icons.check_rounded : Icons.add_rounded,
                                        color: isSelected ? Colors.white : const Color(0xFF1DB954),
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

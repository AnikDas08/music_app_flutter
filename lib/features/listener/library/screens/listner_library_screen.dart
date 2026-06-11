import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/listner_library_controller.dart';
import '../widgets/recent_tab_widget.dart';
import '../widgets/favorite_tab_widget.dart';
import '../widgets/downloads_tab_widget.dart';
import '../widgets/playlists_tab_widget.dart';
import '../widgets/artists_tab_widget.dart';

class ListnerLibraryScreen extends StatelessWidget {
  const ListnerLibraryScreen({super.key});

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
                  // App Bar / Header
                  _buildHeader(),
                  SizedBox(height: 16.h),

                  // Search Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _buildSearchBar(controller),
                  ),
                  SizedBox(height: 20.h),

                  // Tabs
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _buildTabBar(controller),
                  ),
                  SizedBox(height: 20.h),

                  // Content Area
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Obx(() {
                        switch (controller.selectedTab.value) {
                          case 0:
                            return RecentTabWidget(controller: controller);
                          case 1:
                            return FavoriteTabWidget(controller: controller);
                          case 2:
                            return DownloadsTabWidget(controller: controller);
                          case 3:
                            return PlaylistsTabWidget(controller: controller);
                          case 4:
                            return ArtistsTabWidget(controller: controller);
                          default:
                            return RecentTabWidget(controller: controller);
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Header ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
      child: const Center(
        child: CommonText(
          text: "Your Library",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // --- Search Bar ---
  Widget _buildSearchBar(ListnerLibraryController controller) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(100.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(Icons.search, color: const Color(0xFF8E8E93), size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: "Search Your Library",
                hintStyle: GoogleFonts.lato(
                  color: const Color(0xFF8E8E93),
                  fontSize: 15.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Horizontal Tab Bar ---
  Widget _buildTabBar(ListnerLibraryController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Obx(() {
        return Row(
          children: List.generate(controller.tabs.length, (index) {
            final isSelected = controller.selectedTab.value == index;
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: Container(
                margin: EdgeInsets.only(right: 24.w),
                padding: EdgeInsets.only(bottom: 6.h),
                decoration: BoxDecoration(
                  border: isSelected
                      ? const Border(
                          bottom: BorderSide(
                            color: Color(0xFF1DB954), // Active green line indicator
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: CommonText(
                  text: controller.tabs[index],
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF1DB954) : const Color(0xFF8E8E93),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}

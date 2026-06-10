import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_home_controller.dart';
import '../widgets/featured_artist_card.dart';
import '../../../common/home_nav/controller/home_nav_controller.dart';

class ListnerHomeScreen extends StatelessWidget {
  const ListnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListnerHomeController>(
      init: ListnerHomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A), // Match exact mockup background dark grey/black
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeader(),
                  SizedBox(height: 24.h),

                  // Search Bar
                  _buildSearchBar(controller),
                  SizedBox(height: 24.h),

                  // Featured Artists Section
                  _buildSectionTitle(
                    title: "Featured Artists",
                    onSeeAllTap: () {
                      Get.toNamed(AppRoutes.detailsFeaturedArtists);
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildFeaturedList(controller),
                  SizedBox(height: 28.h),

                  // Trending Artists Section
                  _buildSectionTitle(
                    title: "Trending Artists",
                    onSeeAllTap: () {
                      Get.toNamed(AppRoutes.detailsTrendingArtists);
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildTrendingList(controller),
                  SizedBox(height: 20.h),

                  // Section Dot Indicator
                  _buildDotIndicator(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Header UI ---
  Widget _buildHeader() {
    return Row(
      children: [
        // Profile picture
        Container(
          height: 48.r,
          width: 48.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor, width: 1.5.r),
            image: const DecorationImage(
              image: AssetImage(
                "assets/images/artist_onboarding_third.png",
              ), // High fidelity portrait
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Greetings
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "Hello, Shaka",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 2.h),
              CommonText(
                text: "Welcome To Muzikgen",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
              ),
            ],
          ),
        ),
        // Notification bell icon container (Glass effect)
        ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 42.r,
              width: 42.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1.r,
                ),
              ),
              child: Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.notifications),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Search Bar UI ---
  Widget _buildSearchBar(ListnerHomeController controller) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF242424).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(100.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.secondaryTextColor, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              readOnly: true,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 14.sp),
              onTap: () {
                Get.find<HomeNavController>().changeIndex(1);
              },
              decoration: InputDecoration(
                hintText: "Search Artist You Love",
                hintStyle: GoogleFonts.lato(
                  color: AppColors.secondaryTextColor,
                  fontSize: 14.sp,
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

  // --- Section Title ---
  Widget _buildSectionTitle({
    required String title,
    required VoidCallback onSeeAllTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: title,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: CommonText(
            text: "See All",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  // --- Featured Artists List ---
  Widget _buildFeaturedList(ListnerHomeController controller) {
    return SizedBox(
      height: 290.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.featuredArtists.length,
        itemBuilder: (context, index) {
          final artist = controller.featuredArtists[index];
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: FeaturedArtistCard(
              name: artist["name"]!,
              track: artist["track"]!,
              price: artist["price"]!,
              imagePath: artist["image"]!,
              isSubscribed: artist["isSubscribed"] ?? false,
            ),
          );
        },
      ),
    );
  }

  // --- Trending Artists List ---
  Widget _buildTrendingList(ListnerHomeController controller) {
    return SizedBox(
      height: 290.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.trendingArtists.length,
        itemBuilder: (context, index) {
          final artist = controller.trendingArtists[index];
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: FeaturedArtistCard(
              name: artist["name"]!,
              track: artist["track"]!,
              price: artist["price"]!,
              imagePath: artist["image"]!,
              isSubscribed: artist["isSubscribed"] ?? false,
            ),
          );
        },
      ),
    );
  }

  // --- Dot Indicator ---
  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 6.r,
          width: 18.w, // Active dot
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          height: 6.r,
          width: 6.r,
          decoration: const BoxDecoration(
            color: Color(0xFF38383A),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          height: 6.r,
          width: 6.r,
          decoration: const BoxDecoration(
            color: Color(0xFF38383A),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_search_controller.dart';
import '../../home/widgets/featured_artist_card.dart';
import '../../../common/home_nav/controller/home_nav_controller.dart';

class ListnerSearchScreen extends StatelessWidget {
  const ListnerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListnerSearchController>(
      init: ListnerSearchController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: SafeArea(
            child: Column(
              children: [
                // Top Search Bar Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    children: [
                      // Circular Back Button
                      GestureDetector(
                        onTap: () {
                          Get.find<HomeNavController>().changeIndex(0);
                        },
                        child: Container(
                          height: 40.r,
                          width: 40.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                              width: 1.r,
                            ),
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Search Input field
                      Expanded(
                        child: Container(
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF242424).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: AppColors.secondaryTextColor,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: TextField(
                                  controller: controller.searchController,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
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
                                  onChanged: (val) {
                                    controller.searchQuery.value = val;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recent Searches Title
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: const Color(0xFF9F9FA9),
                              size: 22.sp,
                            ),
                            SizedBox(width: 8.w),
                            CommonText(
                              text: "Recent Searches",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Recent Searches list
                        ...controller.recentSearches.map((item) {
                          final isAlbum = item["type"] == "Album";
                          return Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1B1B1C),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: const Color(0xFF9F9FA9),
                                  size: 20.sp,
                                ),
                                SizedBox(width: 12.w),
                                if (isAlbum) ...[
                                  Icon(
                                    Icons.album,
                                    color: Colors.white.withValues(alpha: 0.6),
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 6.w),
                                ],
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: item["title"],
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      if (!isAlbum) ...[
                                        SizedBox(height: 2.h),
                                        CommonText(
                                          text: item["type"],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF9F9FA9),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 20.h),

                        // Trending Section Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: const Color(0xFF00C853),
                                  size: 22.sp,
                                ),
                                SizedBox(width: 8.w),
                                CommonText(
                                  text: "Trending Artists",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.detailsTrendingArtists);
                              },
                              child: CommonText(
                                text: "See All",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF00C853),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Trending Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 0.62,
                          ),
                          itemCount: controller.trendingArtists.length,
                          itemBuilder: (context, index) {
                            final artist = controller.trendingArtists[index];
                            return FeaturedArtistCard(
                              name: artist["name"]!,
                              track: artist["track"]!,
                              price: artist["price"]!,
                              imagePath: artist["image"]!,
                              isSubscribed: artist["isSubscribed"] ?? false,
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

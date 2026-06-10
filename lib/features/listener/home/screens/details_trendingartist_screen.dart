import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/listner_home_controller.dart';
import '../widgets/featured_artist_card.dart';

class DetailsTrendingArtistScreen extends StatelessWidget {
  const DetailsTrendingArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListnerHomeController>(
      init: ListnerHomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: Center(
              child: GestureDetector(
                onTap: () => Get.back(),
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
            ),
            title: Text(
              "Trending Artists",
              style: GoogleFonts.lato(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              physics: const BouncingScrollPhysics(),
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
          ),
        );
      },
    );
  }
}

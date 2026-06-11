import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/listner_home_controller.dart';
import '../widgets/featured_artist_card.dart';
import 'package:muzikgen_app/component/other_widgets/common_app_bar.dart';

class DetailsFeaturedArtistsScreen extends StatelessWidget {
  const DetailsFeaturedArtistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListnerHomeController>(
      init: ListnerHomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: const CommonAppBar(title: "Featured Artists"),
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
              itemCount: controller.allFeaturedArtists.length,
              itemBuilder: (context, index) {
                final artist = controller.allFeaturedArtists[index];
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

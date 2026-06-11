import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/listner_library_controller.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';


class ArtistsTabWidget extends StatelessWidget {
  final ListnerLibraryController controller;

  const ArtistsTabWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Artists List
        Obx(() {
          if (controller.filteredArtists.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: CommonText(
                  text: "No artists matches found",
                  fontSize: 14,
                  color: Color(0xFF8E8E93),
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.filteredArtists.length,
            itemBuilder: (context, index) {
              final item = controller.filteredArtists[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.artistAllSongs,
                    arguments: {
                      'name': item["name"]!,
                      'isSubscribed': true,
                      'image': item["image"]!,
                      'price': 'UGX 1,000',
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF18181A),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          item["image"]!,
                          height: 44.r,
                          width: 44.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: item["name"]!,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.music_note_rounded,
                                  color: const Color(0xFF8E8E93),
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                CommonText(
                                  text: item["genre"]!,
                                  fontSize: 12,
                                  color: const Color(0xFF8E8E93),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            CommonText(
                              text: item["songsCount"]!,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFE5B539), // Gold/Yellow song count text
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 28.r,
                        width: 28.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1DB954),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        SizedBox(height: 16.h),

        // Discover More Artists Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1E14),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF1DB954).withValues(alpha: 0.4), width: 1.r),
          ),
          child: Column(
            children: [
              Container(
                height: 48.r,
                width: 48.r,
                decoration: const BoxDecoration(
                  color: Color(0xFF0A0A0A),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.music_note_rounded,
                    color: Color(0xFF1DB954),
                    size: 24,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              const CommonText(
                text: "Discover More Artists",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              const CommonText(
                text: "Subscribe To More Artists And Support\nTheir Music Directly",
                fontSize: 13,
                color: Color(0xFF8E8E93),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1DB954),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  minimumSize: Size(double.infinity, 44.h),
                  elevation: 0,
                ),
                child: const CommonText(
                  text: "Browse Artists",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

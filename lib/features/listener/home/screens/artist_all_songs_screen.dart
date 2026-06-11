import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/text_field/common_text_field.dart';
import 'package:muzikgen_app/component/other_widgets/common_app_bar.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import '../widgets/artist_profile_song_item.dart';

class ArtistAllSongsScreen extends StatefulWidget {
  const ArtistAllSongsScreen({super.key});

  @override
  State<ArtistAllSongsScreen> createState() => _ArtistAllSongsScreenState();
}

class _ArtistAllSongsScreenState extends State<ArtistAllSongsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, dynamic>> _allSongs = [
    {
      "title": "Sunset Dreams",
      "badge": "New",
      "duration": "3:50",
      "plays": "125k Plays",
      "imagePath": "assets/images/artist_onboarding_first.png",
    },
    {
      "title": "Mid Night Vibes",
      "badge": "Exclusive",
      "duration": "3:55",
      "plays": "98k Plays",
      "imagePath": "assets/images/artist_onboariding_second.png",
    },
    {
      "title": "City Dreams",
      "badge": null,
      "duration": "5:00",
      "plays": "60k Plays",
      "imagePath": "assets/images/artist_onboarding_third.png",
    },
    {
      "title": "Ocean Waves",
      "badge": "New",
      "duration": "4:20",
      "plays": "80k Plays",
      "imagePath": "assets/images/artist_onboarding_fourth.png",
    },
    {
      "title": "City Dreams",
      "badge": null,
      "duration": "5:00",
      "plays": "60k Plays",
      "imagePath": "assets/images/artist_onboarding_fifth.png",
    },
    {
      "title": "City Dreams",
      "badge": "New",
      "duration": "5:00",
      "plays": "60k Plays",
      "imagePath": "assets/images/artist_onboarding_first.png",
    },
    {
      "title": "Ocean Waves",
      "badge": "Exclusive",
      "duration": "4:20",
      "plays": "80k Plays",
      "imagePath": "assets/images/artist_onboarding_fourth.png",
    },
    {
      "title": "Mid Night Vibes",
      "badge": "Exclusive",
      "duration": "3:55",
      "plays": "98k Plays",
      "imagePath": "assets/images/artist_onboariding_second.png",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String artistName = Get.arguments?['name'] ?? "Kendi Mustaq";
    final bool isSubscribed = Get.arguments?['isSubscribed'] ?? false;
    final String artistImage =
        Get.arguments?['image'] ?? "assets/images/artist_onboarding_first.png";
    final String price = Get.arguments?['price'] ?? "UGX 1,000";

    final filteredSongs = _allSongs.where((song) {
      final title = song["title"] as String;
      return title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0E2519), // Dark green at top
            Color(0xFF0A0A0A), // Black at bottom
          ],
          stops: [0.0, 0.4],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(title: artistName),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 12.h),

              // Search Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CommonTextField(
                  controller: _searchController,
                  hintText: "Search $artistName Song",
                  hintTextColor: Colors.white38,
                  textColor: Colors.white,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  borderRadius: 30,
                  borderColor: Colors.white.withValues(alpha: 0.1),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.white38,
                      size: 20.sp,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.h),

              // Filtered Songs List
              Expanded(
                child: filteredSongs.isEmpty
                    ? Center(
                        child: CommonText(
                          text: "No songs found",
                          fontSize: 16,
                          color: Colors.white38,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          final song = filteredSongs[index];
                          return GestureDetector(
                            onTap: () {
                              if (isSubscribed) {
                                Get.toNamed(
                                  AppRoutes.musicPlayer,
                                  arguments: {
                                    'songs': filteredSongs,
                                    'index': index,
                                    'artistName': artistName,
                                  },
                                );
                              } else {
                                Get.toNamed(
                                  AppRoutes.subscribePlan,
                                  arguments: {
                                    'name': artistName,
                                    'image': artistImage,
                                    'price': price,
                                  },
                                );
                              }
                            },
                            child: ArtistProfileSongItem(
                              title: song["title"]!,
                              badge: song["badge"],
                              duration: song["duration"]!,
                              plays: song["plays"]!,
                              imagePath: song["imagePath"]!,
                              isLocked: !isSubscribed,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

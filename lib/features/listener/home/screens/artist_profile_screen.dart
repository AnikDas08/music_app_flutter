import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';

import '../widgets/artist_profile_header.dart';
import '../widgets/artist_profile_stats.dart';
import '../widgets/artist_profile_subscribe_cta.dart';
import '../widgets/artist_profile_unlock_banner.dart';
import '../widgets/artist_profile_song_item.dart';
import '../widgets/artist_profile_lock_card.dart';
import '../widgets/artist_profile_album_item.dart';

class ArtistProfileScreen extends StatefulWidget {
  const ArtistProfileScreen({super.key});

  @override
  State<ArtistProfileScreen> createState() => _ArtistProfileScreenState();
}

class _ArtistProfileScreenState extends State<ArtistProfileScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Read route arguments
    final String name = Get.arguments['name'] ?? "Kendi Mustaq";
    final String imagePath = Get.arguments['image'] ?? "assets/images/artist_onboarding_first.png";
    final bool isSubscribed = Get.arguments['isSubscribed'] ?? false;
    final String price = Get.arguments['price'] ?? "UGX 1,000";
    final String track = Get.arguments['track'] ?? "Afrobeats";

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
          "Artist Profiles",
          style: GoogleFonts.lato(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              
              // Artist Info Header
              ArtistProfileHeader(
                name: name,
                imagePath: imagePath,
                track: track,
              ),
              SizedBox(height: 20.h),

              // Stats Row
              const ArtistProfileStats(),
              SizedBox(height: 20.h),

              // Conditional Subscription UI (Only if not subscribed)
              if (!isSubscribed) ...[
                ArtistProfileSubscribeCta(price: price),
                SizedBox(height: 16.h),
                const ArtistProfileUnlockBanner(),
                SizedBox(height: 24.h),
              ],

              // Tab Bar
              _buildTabBar(),
              SizedBox(height: 20.h),

              // Tab Contents (Conditional on selected index)
              if (_selectedTabIndex == 0) ...[
                _buildSongsTab(isSubscribed, price),
              ] else if (_selectedTabIndex == 1) ...[
                _buildAlbumsTab(isSubscribed, price),
              ] else if (_selectedTabIndex == 2) ...[
                _buildEpsTab(isSubscribed, price),
              ] else if (_selectedTabIndex == 3) ...[
                _buildAboutArtistTab(name, track),
              ] else ...[
                _buildPlaceholderTab(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // --- Custom Tab Bar selector ---
  Widget _buildTabBar() {
    final tabs = ["Songs", "Albums", "EPs", "About Artist"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(tabs.length, (index) {
        final isSelected = _selectedTabIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTabIndex = index;
            });
          },
          child: Column(
            children: [
              Text(
                tabs[index],
                style: GoogleFonts.lato(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF00C853) : Colors.white60,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                height: 2.h,
                width: 40.w,
                color: isSelected ? const Color(0xFF00C853) : Colors.transparent,
              ),
            ],
          ),
        );
      }),
    );
  }

  // --- Songs Tab View Content ---
  Widget _buildSongsTab(bool isSubscribed, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: "Top Songs",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            CommonText(
              text: "See All",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF00C853),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // List of songs using refactored widgets
        ArtistProfileSongItem(
          title: "Sunset Dreams",
          badge: "Exclusive",
          duration: "3:50",
          plays: "125k Plays",
          imagePath: "assets/images/artist_onboarding_first.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileSongItem(
          title: "Mid Night Vibes",
          badge: "Exclusive",
          duration: "3:55",
          plays: "98k Plays",
          imagePath: "assets/images/artist_onboariding_second.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileSongItem(
          title: "City Dreams",
          duration: "5:00",
          plays: "60k Plays",
          imagePath: "assets/images/artist_onboarding_third.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileSongItem(
          title: "Ocean Waves",
          badge: "New",
          duration: "4:20",
          plays: "80k Plays",
          imagePath: "assets/images/artist_onboarding_fourth.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileSongItem(
          title: "City Dreams",
          duration: "5:00",
          plays: "60k Plays",
          imagePath: "assets/images/artist_onboarding_fifth.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileSongItem(
          title: "City Dreams",
          duration: "5:00",
          plays: "60k Plays",
          imagePath: "assets/images/artist_onboarding_first.png",
          isLocked: !isSubscribed,
        ),

        // Bottom locking banner overlay (Only if not subscribed)
        if (!isSubscribed) ...[
          ArtistProfileLockCard(price: price),
        ] else ...[
          SizedBox(height: 24.h),
        ],
      ],
    );
  }

  // --- Albums Tab View Content ---
  Widget _buildAlbumsTab(bool isSubscribed, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: "Albums",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            CommonText(
              text: "See All",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF00C853),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        ArtistProfileAlbumItem(
          title: "Golden Hour",
          badge: "Exclusive",
          year: "2024",
          songsCount: "12 Songs",
          imagePath: "assets/images/artist_onboarding_first.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileAlbumItem(
          title: "Love & Vibes",
          badge: "Exclusive",
          year: "2024",
          songsCount: "12 Songs",
          imagePath: "assets/images/artist_onboarding_fifth.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileAlbumItem(
          title: "True Colors",
          badge: "Exclusive",
          year: "2024",
          songsCount: "12 Songs",
          imagePath: "assets/images/artist_onboarding_fourth.png",
          isLocked: !isSubscribed,
        ),

        // Bottom locking banner overlay (Only if not subscribed)
        if (!isSubscribed) ...[
          ArtistProfileLockCard(price: price),
        ] else ...[
          SizedBox(height: 24.h),
        ],
      ],
    );
  }

  // --- EPs Tab View Content ---
  Widget _buildEpsTab(bool isSubscribed, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: "Eps",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            CommonText(
              text: "See All",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF00C853),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        ArtistProfileAlbumItem(
          title: "Vibes Only",
          badge: "Exclusive",
          year: "2024",
          songsCount: "8 Songs",
          imagePath: "assets/images/artist_onboarding_third.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileAlbumItem(
          title: "After Hours",
          badge: "Exclusive",
          year: "2024",
          songsCount: "6 Songs",
          imagePath: "assets/images/artist_onboarding_fifth.png",
          isLocked: !isSubscribed,
        ),
        ArtistProfileAlbumItem(
          title: "Better Days",
          badge: "Exclusive",
          year: "2024",
          songsCount: "5 Songs",
          imagePath: "assets/images/artist_onboarding_fourth.png",
          isLocked: !isSubscribed,
        ),

        // Bottom locking banner overlay (Only if not subscribed)
        if (!isSubscribed) ...[
          ArtistProfileLockCard(price: price),
        ] else ...[
          SizedBox(height: 24.h),
        ],
      ],
    );
  }

  // --- About Artist Tab View Content ---
  Widget _buildAboutArtistTab(String name, String track) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "About Artist",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        SizedBox(height: 16.h),

        // About Info Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1C),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$name is a Ugandan Afrobeat singer and songwriter known for her soulful voice, heartfelt lyrics and vibrant melodies.",
                style: GoogleFonts.lato(
                  color: Colors.white70,
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Her music is a blend of Afrobeat, R&B and African pop, creating a sound that connects deeply with her fans.",
                style: GoogleFonts.lato(
                  color: Colors.white70,
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),
              Divider(
                color: Colors.white.withValues(alpha: 0.08),
                thickness: 1.r,
              ),
              SizedBox(height: 16.h),
              
              // Metadata rows
              _buildAboutMetaRow(Icons.public, "Country", "Uganda"),
              SizedBox(height: 12.h),
              _buildAboutMetaRow(Icons.music_note, "Genre", track),
              SizedBox(height: 12.h),
              _buildAboutMetaRow(Icons.person_outline, "Joined", "2020"),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Connect Section
        CommonText(
          text: "Connect",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        SizedBox(height: 16.h),

        // Social Media Buttons Row
        Row(
          children: [
            _buildSocialButton(
              icon: Icons.photo_camera,
              colors: [
                const Color(0xFF833AB4),
                const Color(0xFFFD1D1D),
                const Color(0xFFFCAF45),
              ],
            ),
            SizedBox(width: 12.w),
            _buildSocialButton(
              icon: Icons.music_note,
              color: Colors.black,
              hasBorder: true,
            ),
            SizedBox(width: 12.w),
            _buildSocialButton(
              icon: Icons.play_arrow,
              color: const Color(0xFFFF0000),
            ),
            SizedBox(width: 12.w),
            _buildSocialButton(
              icon: Icons.close, // Resembles X logo
              color: Colors.black,
              hasBorder: true,
            ),
            SizedBox(width: 12.w),
            _buildSocialButton(
              icon: Icons.facebook,
              color: const Color(0xFF1877F2),
            ),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildAboutMetaRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 36.r,
              width: 36.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white60,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.lato(
                color: Colors.white60,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    Color? color,
    List<Color>? colors,
    bool hasBorder = false,
  }) {
    return Container(
      height: 44.r,
      width: 44.r,
      decoration: BoxDecoration(
        color: color,
        gradient: colors != null
            ? LinearGradient(
                colors: colors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              )
            : null,
        borderRadius: BorderRadius.circular(12.r),
        border: hasBorder
            ? Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1.r)
            : null,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  // --- Placeholder other tabs ---
  Widget _buildPlaceholderTab() {
    return Container(
      height: 200.h,
      alignment: Alignment.center,
      child: Text(
        "Content Coming Soon",
        style: GoogleFonts.lato(color: Colors.white38, fontSize: 14.sp),
      ),
    );
  }
}

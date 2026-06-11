import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListnerLibraryController extends GetxController {
  final searchController = TextEditingController();
  
  // Track active sub-tab (0: Recent, 1: Favorite, 2: Downloads, 3: Playlists, 4: My Artists)
  final RxInt selectedTab = 0.obs;

  // Track nested Recently Played grid view
  final RxBool showRecentlyPlayedDetails = false.obs;

  final List<String> tabs = ["Recent", "Favorite", "Downloads", "Playlists", "My Artists"];

  // Mock Data - Recent Tab Dashboard Items (Horizontal)
  final List<Map<String, dynamic>> recentlyPlayed = [
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/artist_onboarding_first.png",
    },
    {
      "title": "City Dreams",
      "artist": "Kendy",
      "image": "assets/images/artist_onboariding_second.png",
    },
    {
      "title": "Ocean Waves",
      "artist": "Vinka",
      "image": "assets/images/artist_onboarding_third.png",
    },
  ];

  // Mock Data - Full Recently Played Grid (15 items matching mockup)
  final List<Map<String, dynamic>> recentlyPlayedSongs = [
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/artist_onboarding_first.png",
    },
    {
      "title": "City Dreams",
      "artist": "Kendy",
      "image": "assets/images/artist_onboariding_second.png",
    },
    {
      "title": "Ocean Waves",
      "artist": "Vinka",
      "image": "assets/images/artist_onboarding_third.png",
    },
    {
      "title": "Oyaya",
      "artist": "Lutty Neika",
      "image": "assets/images/artist_onboarding_fourth.png",
    },
    {
      "title": "Champion Gal",
      "artist": "Fik Fameica",
      "image": "assets/images/artist_onboarding_fifth.png",
    },
    {
      "title": "Size Yange",
      "artist": "Pia Pounds",
      "image": "assets/images/listener_onboarding_first.png",
    },
    {
      "title": "Sweet Mutima",
      "artist": "Super Chance",
      "image": "assets/images/listener_onboarding_second.png",
    },
    {
      "title": "Buwooma",
      "artist": "A Pass & Kabo",
      "image": "assets/images/listener_onboarding_third.png",
    },
    {
      "title": "Jaribu",
      "artist": "B2C",
      "image": "assets/images/artist_role_image.png",
    },
    {
      "title": "Wano Wano",
      "artist": "Rema Namakla",
      "image": "assets/images/listner_role_image.png",
    },
    {
      "title": "Love Story",
      "artist": "Kendy",
      "image": "assets/images/profile_background.png",
    },
    {
      "title": "Morocco (Remix)",
      "artist": "Axon",
      "image": "assets/images/musicimage.png",
    },
    {
      "title": "Okuffa Obuffi",
      "artist": "Feffe Bussi",
      "image": "assets/images/select_role_image.jpg",
    },
    {
      "title": "Tobingamba",
      "artist": "Ava Peace",
      "image": "assets/images/camera_image.png",
    },
    {
      "title": "Togwawo",
      "artist": "Black Shuga",
      "image": "assets/images/onboarding_view.png",
    },
  ];

  // Mock Data - Favorite Tab Items
  final List<Map<String, dynamic>> favoriteSongs = [
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/artist_onboarding_first.png",
      "badge": "Exclusive",
      "badgeBgColor": const Color(0xFF2E1564),
      "badgeTextColor": const Color(0xFFD8B4FE),
      "duration": "3:55",
      "plays": "98k Plays",
    },
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/listener_onboarding_first.png",
      "badge": "New",
      "badgeBgColor": const Color(0xFF3B2E15),
      "badgeTextColor": const Color(0xFFFDE047),
      "duration": "3:55",
      "plays": "98k Plays",
    },
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/artist_onboarding_third.png",
      "badge": null,
      "duration": "3:55",
      "plays": "98k Plays",
    },
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/artist_onboarding_fourth.png",
      "badge": "Exclusive",
      "badgeBgColor": const Color(0xFF2E1564),
      "badgeTextColor": const Color(0xFFD8B4FE),
      "duration": "3:55",
      "plays": "98k Plays",
    },
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/artist_onboarding_fifth.png",
      "badge": "New",
      "badgeBgColor": const Color(0xFF3B2E15),
      "badgeTextColor": const Color(0xFFFDE047),
      "duration": "3:55",
      "plays": "98k Plays",
    },
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/listener_onboarding_second.png",
      "badge": null,
      "duration": "3:55",
      "plays": "98k Plays",
    },
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/profile_background.png",
      "badge": "Exclusive",
      "badgeBgColor": const Color(0xFF2E1564),
      "badgeTextColor": const Color(0xFFD8B4FE),
      "duration": "3:55",
      "plays": "98k Plays",
    },
  ];

  // Mock Data - Downloads Tab Items
  final List<Map<String, dynamic>> downloadedSongs = [
    {
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "image": "assets/images/artist_onboarding_first.png",
      "duration": "3:55",
    },
    {
      "title": "See You Tonight",
      "artist": "Cindy Sanyu",
      "image": "assets/images/listener_onboarding_first.png",
      "duration": "5:55",
    },
    {
      "title": "Komawo",
      "artist": "Ava Peace",
      "image": "assets/images/listener_onboarding_second.png",
      "duration": "2:55",
    },
    {
      "title": "All Over You",
      "artist": "Vinka",
      "image": "assets/images/artist_onboarding_third.png",
      "duration": "8:55",
    },
    {
      "title": "Nyash",
      "artist": "Gloria Bugie",
      "image": "assets/images/artist_onboarding_fourth.png",
      "duration": "9:55",
    },
    {
      "title": "TikTok Life",
      "artist": "King Saha",
      "image": "assets/images/artist_onboarding_fifth.png",
      "duration": "8:55",
    },
  ];

  // Mock Data - Playlists Tab Items
  final List<Map<String, dynamic>> playlists = [
    {
      "title": "Afrobeats Hits",
      "songsCount": "32 Songs",
      "icon": Icons.music_note_rounded,
      "iconColor": const Color(0xFF1DB954),
      "bgColor": const Color(0xFF152A1C),
      "isCustomImage": false,
    },
    {
      "title": "Chill Waves",
      "songsCount": "18 Songs",
      "icon": Icons.music_note_rounded,
      "iconColor": const Color(0xFFE91E63),
      "bgColor": const Color(0xFF2A151C),
      "isCustomImage": false,
    },
    {
      "title": "Workout Mix",
      "songsCount": "24 Songs",
      "image": "assets/images/listener_onboarding_first.png",
      "isCustomImage": true,
    },
    {
      "title": "Love Story",
      "songsCount": "89 Songs",
      "image": "assets/images/listener_onboarding_second.png",
      "isCustomImage": true,
    },
    {
      "title": "Morocco (Remix)",
      "songsCount": "39 Songs",
      "image": "assets/images/artist_onboarding_third.png",
      "isCustomImage": true,
    },
    {
      "title": "Baddie (Remix)",
      "songsCount": "48 Songs",
      "image": "assets/images/artist_onboarding_fourth.png",
      "isCustomImage": true,
    },
    {
      "title": "Okuffa Obuffi",
      "songsCount": "30 Songs",
      "image": "assets/images/artist_onboarding_fifth.png",
      "isCustomImage": true,
    },
  ];

  // Mock Data - My Artists Tab Items
  final List<Map<String, dynamic>> artists = [
    {
      "name": "Vinka",
      "genre": "Afrobeats",
      "songsCount": "24k Songs",
      "image": "assets/images/artist_onboarding_first.png",
      "isVerified": true,
    },
    {
      "name": "Naosi Beats",
      "genre": "Hip Hop",
      "songsCount": "85k Songs",
      "image": "assets/images/artist_onboarding_fourth.png",
      "isVerified": true,
    },
    {
      "name": "Shaka",
      "genre": "Afrobeats",
      "songsCount": "36k Songs",
      "image": "assets/images/artist_onboarding_third.png",
      "isVerified": true,
    },
  ];

  // For storing filtered search lists
  final RxList<Map<String, dynamic>> filteredRecentlyPlayed = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredRecentlyPlayedSongs = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredFavoriteSongs = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredDownloadedSongs = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredPlaylists = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredArtists = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Populate filtered lists initially
    filteredRecentlyPlayed.assignAll(recentlyPlayed);
    filteredRecentlyPlayedSongs.assignAll(recentlyPlayedSongs);
    filteredFavoriteSongs.assignAll(favoriteSongs);
    filteredDownloadedSongs.assignAll(downloadedSongs);
    filteredPlaylists.assignAll(playlists);
    filteredArtists.assignAll(artists);

    // Listen to search changes
    searchController.addListener(_filterContent);
  }

  void changeTab(int index) {
    selectedTab.value = index;
    // Auto collapse detailed recently played grid when switching tabs
    showRecentlyPlayedDetails.value = false;
    update();
  }

  void _filterContent() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredRecentlyPlayed.assignAll(recentlyPlayed);
      filteredRecentlyPlayedSongs.assignAll(recentlyPlayedSongs);
      filteredFavoriteSongs.assignAll(favoriteSongs);
      filteredDownloadedSongs.assignAll(downloadedSongs);
      filteredPlaylists.assignAll(playlists);
      filteredArtists.assignAll(artists);
    } else {
      filteredRecentlyPlayed.assignAll(
        recentlyPlayed.where((item) =>
          item["title"].toString().toLowerCase().contains(query) ||
          item["artist"].toString().toLowerCase().contains(query)
        ).toList()
      );
      filteredRecentlyPlayedSongs.assignAll(
        recentlyPlayedSongs.where((item) =>
          item["title"].toString().toLowerCase().contains(query) ||
          item["artist"].toString().toLowerCase().contains(query)
        ).toList()
      );
      filteredFavoriteSongs.assignAll(
        favoriteSongs.where((item) =>
          item["title"].toString().toLowerCase().contains(query) ||
          item["artist"].toString().toLowerCase().contains(query)
        ).toList()
      );
      filteredDownloadedSongs.assignAll(
        downloadedSongs.where((item) =>
          item["title"].toString().toLowerCase().contains(query) ||
          item["artist"].toString().toLowerCase().contains(query)
        ).toList()
      );
      filteredPlaylists.assignAll(
        playlists.where((item) =>
          item["title"].toString().toLowerCase().contains(query)
        ).toList()
      );
      filteredArtists.assignAll(
        artists.where((item) =>
          item["name"].toString().toLowerCase().contains(query)
        ).toList()
      );
    }
  }

  void addPlaylist(String name, String description, String? imagePath, {int songsCount = 0, List<Map<String, dynamic>>? songs}) {
    final newPlaylist = {
      "title": name,
      "songsCount": "$songsCount Songs",
      "image": imagePath ?? "assets/images/listener_onboarding_first.png",
      "isCustomImage": true,
      "songs": songs ?? [],
    };
    playlists.insert(0, newPlaylist);
    _filterContent();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

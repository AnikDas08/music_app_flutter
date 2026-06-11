import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'listner_library_controller.dart';

class AddSongToPlaylistController extends GetxController {
  final searchController = TextEditingController();

  final RxInt selectedTab = 0.obs; // 0 for Songs, 1 for Albums
  
  // Track selected items
  final RxList<Map<String, dynamic>> selectedSongs = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> selectedAlbums = <Map<String, dynamic>>[].obs;

  final RxString searchQuery = "".obs;

  // Mock songs list matching the screenshot
  final List<Map<String, dynamic>> allSongs = [
    {
      "id": "1",
      "title": "Mid Night Vibes",
      "artist": "Shaka",
      "duration": "3:55",
      "image": "assets/images/artist_onboarding_first.png",
    },
    {
      "id": "2",
      "title": "See You Tonight",
      "artist": "Cindy Sanyu",
      "duration": "5:55",
      "image": "assets/images/artist_onboariding_second.png",
    },
    {
      "id": "3",
      "title": "Champion Gal",
      "artist": "Size Yange",
      "duration": "4:55",
      "image": "assets/images/artist_onboarding_third.png",
    },
    {
      "id": "4",
      "title": "Komawo",
      "artist": "Ava Peace",
      "duration": "2:55",
      "image": "assets/images/artist_onboarding_fourth.png",
    },
    {
      "id": "5",
      "title": "Nyash",
      "artist": "Gloria Bugie",
      "duration": "9:55",
      "image": "assets/images/artist_onboarding_fifth.png",
    },
    {
      "id": "6",
      "title": "TikTok Life",
      "artist": "King Saha",
      "duration": "8:55",
      "image": "assets/images/listener_onboarding_first.png",
    },
    {
      "id": "7",
      "title": "Champion Gal",
      "artist": "Size Yange",
      "duration": "4:55",
      "image": "assets/images/listener_onboarding_second.png",
    },
    {
      "id": "8",
      "title": "Komawo",
      "artist": "Ava Peace",
      "duration": "2:55",
      "image": "assets/images/listener_onboarding_third.png",
    },
  ];

  // Mock albums grid list matching the screenshot
  final List<Map<String, dynamic>> allAlbums = [
    {"id": "a1", "title": "Mid Night Vibes", "artist": "Shaka", "duration": "3:55", "image": "assets/images/artist_onboarding_first.png"},
    {"id": "a2", "title": "See You Tonight", "artist": "Cindy Sanyu", "duration": "5:55", "image": "assets/images/artist_onboariding_second.png"},
    {"id": "a3", "title": "Champion Gal", "artist": "Size Yange", "duration": "4:55", "image": "assets/images/artist_onboarding_third.png"},
    {"id": "a4", "title": "Komawo", "artist": "Ava Peace", "duration": "2:55", "image": "assets/images/artist_onboarding_fourth.png"},
    {"id": "a5", "title": "Nyash", "artist": "Gloria Bugie", "duration": "9:55", "image": "assets/images/artist_onboarding_fifth.png"},
    {"id": "a6", "title": "TikTok Life", "artist": "King Saha", "duration": "8:55", "image": "assets/images/listener_onboarding_first.png"},
    {"id": "a7", "title": "Size Yange", "artist": "Pia Pounds", "duration": "3:30", "image": "assets/images/listener_onboarding_second.png"},
    {"id": "a8", "title": "Sweet Mutima", "artist": "Super Chance", "duration": "4:15", "image": "assets/images/listener_onboarding_third.png"},
    {"id": "a9", "title": "Wano Wano", "artist": "Rema Namakla", "duration": "4:40", "image": "assets/images/artist_role_image.png"},
    {"id": "a10", "title": "Love Story", "artist": "Kendy", "duration": "3:20", "image": "assets/images/listner_role_image.png"},
    {"id": "a11", "title": "Okuffa Obuffi", "artist": "Feffe Bussi", "duration": "5:10", "image": "assets/images/profile_background.png"},
    {"id": "a12", "title": "Mid Night Vibes", "artist": "Shaka", "duration": "3:55", "image": "assets/images/musicimage.png"},
    {"id": "a13", "title": "See You Tonight", "artist": "Cindy Sanyu", "duration": "5:55", "image": "assets/images/select_role_image.jpg"},
    {"id": "a14", "title": "Champion Gal", "artist": "Size Yange", "duration": "4:55", "image": "assets/images/artist_onboarding_first.png"},
    {"id": "a15", "title": "Komawo", "artist": "Ava Peace", "duration": "2:55", "image": "assets/images/artist_onboariding_second.png"},
    {"id": "a16", "title": "Nyash", "artist": "Gloria Bugie", "duration": "9:55", "image": "assets/images/artist_onboarding_third.png"},
    {"id": "a17", "title": "TikTok Life", "artist": "King Saha", "duration": "8:55", "image": "assets/images/artist_onboarding_fourth.png"},
    {"id": "a18", "title": "Champion Gal", "artist": "Size Yange", "duration": "4:55", "image": "assets/images/artist_onboarding_fifth.png"},
  ];

  // Filtered lists based on search query
  final RxList<Map<String, dynamic>> filteredSongs = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredAlbums = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredSongs.assignAll(allSongs);
    filteredAlbums.assignAll(allAlbums);
    searchController.addListener(_filterLists);
  }

  void _filterLists() {
    final query = searchController.text.trim().toLowerCase();
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredSongs.assignAll(allSongs);
      filteredAlbums.assignAll(allAlbums);
    } else {
      filteredSongs.assignAll(
        allSongs.where((song) =>
          song["title"].toString().toLowerCase().contains(query) ||
          song["artist"].toString().toLowerCase().contains(query)
        ).toList()
      );
    }
  }

  int get totalSelectedCount => selectedSongs.length + selectedAlbums.length;

  bool isSongSelected(Map<String, dynamic> song) {
    return selectedSongs.any((item) => item["id"] == song["id"]);
  }

  void toggleSong(Map<String, dynamic> song) {
    if (isSongSelected(song)) {
      selectedSongs.removeWhere((item) => item["id"] == song["id"]);
    } else {
      selectedSongs.add(song);
    }
  }

  bool isAlbumSelected(Map<String, dynamic> album) {
    return selectedAlbums.any((item) => item["id"] == album["id"]);
  }

  void toggleAlbum(Map<String, dynamic> album) {
    if (isAlbumSelected(album)) {
      selectedAlbums.removeWhere((item) => item["id"] == album["id"]);
    } else {
      selectedAlbums.add(album);
    }
  }

  void submit(Map<String, dynamic> playlistArgs) {
    Get.toNamed(
      AppRoutes.reviewPlaylist,
      arguments: {
        "name": playlistArgs["name"],
        "description": playlistArgs["description"],
        "imagePath": playlistArgs["imagePath"],
        "selectedSongs": selectedSongs.toList(),
        "selectedAlbums": selectedAlbums.toList(),
      },
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListnerSearchController extends GetxController {
  final searchQuery = "".obs;
  final searchController = TextEditingController();

  final List<Map<String, dynamic>> recentSearches = [
    {
      "title": "Kendi Mustaq",
      "type": "Artist",
    },
    {
      "title": "Afrobeats",
      "type": "Genre",
    },
    {
      "title": "Maksud's Album",
      "type": "Album",
    },
  ];

  final List<Map<String, dynamic>> trendingArtists = [
    {
      "name": "Eddy Kenzo",
      "track": "Afrobeats",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_first.png",
      "isSubscribed": false
    },
    {
      "name": "Kapeke",
      "track": "Afrobeats",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboariding_second.png",
      "isSubscribed": true
    },
    {
      "name": "Jafer Hun",
      "track": "Afrobeats",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_third.png",
      "isSubscribed": true
    },
    {
      "name": "Alex Xender",
      "track": "Afrobeats",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_fourth.png",
      "isSubscribed": false
    },
  ];

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

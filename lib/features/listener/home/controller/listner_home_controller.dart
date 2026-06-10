import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListnerHomeController extends GetxController {
  final searchController = TextEditingController();

  final List<Map<String, dynamic>> featuredArtists = [
    {
      "name": "Vinka",
      "track": "Valu Valu",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_first.png",
      "isSubscribed": true
    },
    {
      "name": "Rema Namakula",
      "track": "Kibaluma",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboariding_second.png",
      "isSubscribed": false
    },
  ];

  final List<Map<String, dynamic>> trendingArtists = [
    {
      "name": "Joshua Baraka",
      "track": "Genre Song",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_third.png",
      "isSubscribed": true
    },
    {
      "name": "Gloria Bugie",
      "track": "Afrobeats",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_fourth.png",
      "isSubscribed": false
    },
    {
      "name": "A Pass",
      "track": "Wuuyo",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_fifth.png",
      "isSubscribed": false
    },
    {
      "name": "Fik Fameica",
      "track": "Pistol",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_first.png",
      "isSubscribed": true
    },
    {
      "name": "Spice Diana",
      "track": "Siri Regular",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboariding_second.png",
      "isSubscribed": false
    },
    {
      "name": "Sheebah Karungi",
      "track": "Nkyamissuka",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_third.png",
      "isSubscribed": true
    },
  ];

  // Full list of featured artists for the GridView in the mockup
  final List<Map<String, dynamic>> allFeaturedArtists = [
    {
      "name": "Palaso",
      "track": "Afrobeats",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_first.png",
      "isSubscribed": false
    },
    {
      "name": "King Saha",
      "track": "Genre Song",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboariding_second.png",
      "isSubscribed": false
    },
    {
      "name": "Juliana Kanyomozi",
      "track": "Kibaluma",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_third.png",
      "isSubscribed": false
    },
    {
      "name": "Navio",
      "track": "Njogereza",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_fourth.png",
      "isSubscribed": false
    },
    {
      "name": "Ziza Baffana",
      "track": "Valu Valu",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_fifth.png",
      "isSubscribed": false
    },
    {
      "name": "Eddy Kenzo",
      "track": "Sitya Loss",
      "price": "UGX 1,000",
      "image": "assets/images/artist_onboarding_first.png",
      "isSubscribed": false
    },
  ];

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'listner_library_controller.dart';

class ReviewPlaylistController extends GetxController {
  late final String name;
  late final String description;
  late final String imagePath;
  
  final RxList<Map<String, dynamic>> previewItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    name = args["name"] ?? "New Playlist";
    description = args["description"] ?? "";
    imagePath = args["imagePath"] ?? "";
    
    final List<Map<String, dynamic>> selectedSongs = List<Map<String, dynamic>>.from(args["selectedSongs"] ?? []);
    final List<Map<String, dynamic>> selectedAlbums = List<Map<String, dynamic>>.from(args["selectedAlbums"] ?? []);
    
    final List<Map<String, dynamic>> merged = [];
    merged.addAll(selectedSongs);
    merged.addAll(selectedAlbums);
    previewItems.assignAll(merged);
  }

  int get totalSongsCount => previewItems.length;

  int get totalMinutes {
    int totalSeconds = 0;
    for (var item in previewItems) {
      final durationStr = item["duration"] ?? "3:00";
      final parts = durationStr.split(':');
      if (parts.length == 2) {
        final m = int.tryParse(parts[0]) ?? 3;
        final s = int.tryParse(parts[1]) ?? 0;
        totalSeconds += (m * 60 + s);
      } else {
        totalSeconds += 180;
      }
    }
    return (totalSeconds / 60).round();
  }

  void removeItem(Map<String, dynamic> item) {
    previewItems.removeWhere((x) => x["id"] == item["id"]);
  }

  void createPlaylist() {
    try {
      final libraryController = Get.find<ListnerLibraryController>();
      
      // Use first selected item cover if playlist cover is empty
      String? resolvedImage = imagePath;
      if (resolvedImage == null || resolvedImage.isEmpty) {
        if (previewItems.isNotEmpty) {
          resolvedImage = previewItems[0]["image"];
        }
      }

      libraryController.addPlaylist(
        name,
        description,
        (resolvedImage != null && resolvedImage.isNotEmpty) ? resolvedImage : null,
        songsCount: totalSongsCount,
        songs: previewItems.toList(),
      );

      // Navigate to success screen
      Get.toNamed(
        AppRoutes.playlistCreated,
        arguments: {
          "name": name,
          "songsCount": totalSongsCount,
          "minutes": totalMinutes,
          "imagePath": resolvedImage,
          "songs": previewItems.toList(),
        },
      );
    } catch (e) {
      Get.back();
    }
  }
}

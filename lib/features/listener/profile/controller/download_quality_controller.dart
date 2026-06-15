import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadQualityController extends GetxController {
  final selectedQuality = 'High'.obs;

  void setSelectedQuality(String value) {
    selectedQuality.value = value;
  }

  void saveQuality() {
    Get.back();
    Get.snackbar(
      'Success',
      'Download quality set to $selectedQuality',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0F2618),
      colorText: Colors.white,
    );
  }
}

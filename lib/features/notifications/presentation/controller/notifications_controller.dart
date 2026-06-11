import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/notification_model.dart';

class NotificationsController extends GetxController {
  /// Notification list
  final List<NotificationModel> notifications = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasNoData = false;
  int page = 1;

  /// Scroll controller
  final ScrollController scrollController = ScrollController();

  /// Mock Notifications List
  final RxList<Map<String, dynamic>> mockNotifications = <Map<String, dynamic>>[].obs;
  final RxBool isInitialized = false.obs;

  /// Get instance
  static NotificationsController get instance => Get.find<NotificationsController>();

  @override
  void onInit() {
    super.onInit();
    initMockNotifications();
  }

  void initMockNotifications() {
    if (isInitialized.value) return;
    mockNotifications.assignAll([
      {
        "id": "1",
        "type": "new_release",
        "title": "New Release",
        "subtitle": "Kendi Music Just Released",
        "mainContent": "Ocean Waves",
        "imagePath": "assets/images/artist_onboarding_first.png",
        "time": "1 Min Ago",
        "isUnread": true,
      },
      {
        "id": "2",
        "type": "new_release",
        "title": "New Release",
        "subtitle": "Kendi Music Just Released",
        "mainContent": "Ocean Waves",
        "imagePath": "assets/images/artist_onboariding_second.png",
        "time": "1 Min Ago",
        "isUnread": true,
      },
      {
        "id": "3",
        "type": "unlocked",
        "title": "You Unlocked",
        "subtitle": "Because You Supported For",
        "mainContent": "Top Supporter Badge",
        "imagePath": "assets/images/artist_onboarding_third.png",
        "time": "1 Month Ago",
        "isUnread": true,
      },
      {
        "id": "4",
        "type": "payment_success",
        "title": "Payment Successful",
        "subtitle": "Your Subscription Was Renewed",
        "mainContent": "UGX1,000 Monthly",
        "imagePath": "payment_card",
        "time": "1 Min Ago",
        "isUnread": false,
      },
      {
        "id": "5",
        "type": "new_release",
        "title": "New Release",
        "subtitle": "Kendi Music Just Released",
        "mainContent": "Ocean Waves",
        "imagePath": "assets/images/artist_onboarding_fourth.png",
        "time": "1 Min Ago",
        "isUnread": true,
      },
      {
        "id": "6",
        "type": "new_release",
        "title": "New Release",
        "subtitle": "Kendi Music Just Released",
        "mainContent": "Ocean Waves",
        "imagePath": "assets/images/artist_onboarding_fifth.png",
        "time": "1 Min Ago",
        "isUnread": true,
      },
      {
        "id": "7",
        "type": "new_release",
        "title": "New Release",
        "subtitle": "Kendi Music Just Released",
        "mainContent": "Ocean Waves",
        "imagePath": "assets/images/artist_onboarding_first.png",
        "time": "1 Min Ago",
        "isUnread": true,
      },
    ]);
    isInitialized.value = true;
  }

  void markAllRead() {
    for (var i = 0; i < mockNotifications.length; i++) {
      mockNotifications[i] = {
        ...mockNotifications[i],
        "isUnread": false,
      };
    }
    mockNotifications.refresh();
  }

  void clearAll() {
    if (mockNotifications.isEmpty) return;
    mockNotifications.clear();
    Get.snackbar(
      "Cleared",
      "All notifications cleared.",
      backgroundColor: const Color(0xFF131315),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void deleteNotification(String id) {
    final item = mockNotifications.firstWhereOrNull((element) => element['id'] == id);
    if (item == null) return;

    mockNotifications.removeWhere((element) => element['id'] == id);

    Get.snackbar(
      "Deleted",
      "Notification '${item['title']}' deleted.",
      backgroundColor: const Color(0xFF131315),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Empty refresh
  @override
  Future<void> refresh() async {
    initMockNotifications();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

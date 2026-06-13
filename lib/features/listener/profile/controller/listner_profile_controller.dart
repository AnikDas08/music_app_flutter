import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/helpers/other_helper.dart';

class ListnerProfileController extends GetxController {
  // User Profile fields
  String get userName => LocalStorage.myName.isEmpty ? 'Shaka' : LocalStorage.myName;
  String get userEmail => LocalStorage.myEmail.isEmpty ? 'Shaka@Example.Com' : LocalStorage.myEmail;
  String get userImage => LocalStorage.myImage.isEmpty ? 'assets/images/artist_onboarding_third.png' : LocalStorage.myImage;

  // Active Subscription fields
  final String subscriptionCount = '3 Artists';
  final String totalSpent = 'UGX 1,000';
  final String activeSince = '01 Feb 2026';
  final String expires = '01 Jun 2026';

  // Subscriptions details list for mock data
  final List<Map<String, dynamic>> activeSubscriptionsList = [
    {
      'name': 'Kendy Mustaq',
      'genre': 'Afrobeats',
      'image': 'assets/images/artist_onboarding_fourth.png',
      'status': 'Active',
      'period': 'Monthly',
      'amount': 'UGX 1,000/Mo',
      'billingLabel': 'Next Billing',
      'billingValue': 'May 15, 2026',
      'subscribeDate': 'April 15, 2026',
      'isActive': true,
    },
    {
      'name': 'Nakosi Beats',
      'genre': 'HipHop',
      'image': 'assets/images/artist_onboariding_second.png',
      'status': 'Expired',
      'period': 'Yearly',
      'amount': 'UGX 10,000/Yr',
      'billingLabel': 'Expired On',
      'billingValue': 'May 15, 2026',
      'subscribeDate': 'April 15, 2026',
      'isActive': false,
    },
    {
      'name': 'Zara Nova',
      'genre': 'R&B',
      'image': 'assets/images/artist_onboarding_fifth.png',
      'status': 'Active',
      'period': 'Monthly',
      'amount': 'UGX 1,000/Mo',
      'billingLabel': 'Next Billing',
      'billingValue': 'May 15, 2026',
      'subscribeDate': 'April 15, 2026',
      'isActive': true,
    },
  ];

  // Edit Profile text controllers
  late TextEditingController nameEditController;
  late TextEditingController emailEditController;
  String? selectedImagePath;

  // Check if any fields changed compared to their initial stored states
  bool get isProfileChanged {
    final nameChanged = nameEditController.text.trim() != userName;
    final emailChanged = emailEditController.text.trim() != userEmail;
    final imageChanged = selectedImagePath != null;
    return nameChanged || emailChanged || imageChanged;
  }

  @override
  void onInit() {
    super.onInit();
    nameEditController = TextEditingController(text: userName);
    emailEditController = TextEditingController(text: userEmail);
    nameEditController.addListener(_onTextChanged);
    emailEditController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    update();
  }

  @override
  void onClose() {
    nameEditController.removeListener(_onTextChanged);
    emailEditController.removeListener(_onTextChanged);
    nameEditController.dispose();
    emailEditController.dispose();
    super.onClose();
  }

  // Display a bottom sheet to pick image source
  Future<void> showImagePickerSourceDialog() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CommonText(
              text: 'Select Image Source',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera',
                  source: ImageSource.camera,
                ),
                _buildSourceOption(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  source: ImageSource.gallery,
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required ImageSource source,
  }) {
    return GestureDetector(
      onTap: () async {
        Get.back(); // Close bottom sheet
        final path = await OtherHelper.pickImage(source: source);
        if (path != null) {
          selectedImagePath = path;
          update();
        }
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1E2E25),
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 28),
          ),
          const SizedBox(height: 8),
          CommonText(
            text: label,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // Pick profile image directly (fallback or convenience)
  Future<void> pickProfileImage() async {
    final path = await OtherHelper.pickImage();
    if (path != null) {
      selectedImagePath = path;
      update();
    }
  }

  // Update profile handler (save to LocalStorage and update state)
  Future<void> updateProfile() async {
    if (!isProfileChanged) return;

    await LocalStorage.setString(LocalStorageKeys.myName, nameEditController.text.trim());
    await LocalStorage.setString(LocalStorageKeys.myEmail, emailEditController.text.trim());
    if (selectedImagePath != null) {
      await LocalStorage.setString(LocalStorageKeys.myImage, selectedImagePath!);
    }
    await LocalStorage.getAllPrefData();
    update();
    Get.back(); // return to profile screen
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0F2618),
      colorText: Colors.white,
    );
  }

  // Logout function
  void logout() {
    LocalStorage.removeAllPrefData();
  }
}

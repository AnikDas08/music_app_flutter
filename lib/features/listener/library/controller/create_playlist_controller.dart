import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'listner_library_controller.dart';

class CreatePlaylistController extends GetxController {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  final RxInt nameLength = 0.obs;
  final RxInt descLength = 0.obs;

  final RxBool isFormValid = false.obs;
  final RxString selectedImagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(_validateForm);
    descController.addListener(_validateForm);
  }

  void _validateForm() {
    nameLength.value = nameController.text.length;
    descLength.value = descController.text.length;
    isFormValid.value = nameController.text.trim().isNotEmpty;
  }

  Future<void> selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImagePath.value = image.path;
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void submitPlaylist() {
    if (!isFormValid.value) return;

    final name = nameController.text.trim();
    final description = descController.text.trim();

    Get.toNamed(
      AppRoutes.addSongToPlaylist,
      arguments: {
        "name": name,
        "description": description,
        "imagePath": selectedImagePath.value,
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../controller/create_playlist_controller.dart';

class CreatePlaylistScreen extends StatelessWidget {
  const CreatePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate or find the controller
    final controller = Get.put(CreatePlaylistController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1F13), // Soft dark green glow at the top
              Color(0xFF0A0A0A), // Black transition
            ],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Header / App Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 48.r,
                        width: 48.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1C1C1E),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 48.w), // Offset back button to center title
                          child: const CommonText(
                            text: "Create Playlist",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),
                      
                      // Upload Image Box & Text
                      Obx(() {
                        final imagePath = controller.selectedImagePath.value;
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => controller.selectImage(),
                              child: Container(
                                height: 120.r,
                                width: 120.r,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1C1C1E),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: imagePath.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12.r),
                                        child: imagePath.startsWith('assets/')
                                            ? Image.asset(
                                                imagePath,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(imagePath),
                                                fit: BoxFit.cover,
                                              ),
                                      )
                                    : Center(
                                        child: Container(
                                          height: 48.r,
                                          width: 48.r,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF1DB954),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            GestureDetector(
                              onTap: () => controller.selectImage(),
                              child: const CommonText(
                                text: "Upload Image",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1DB954),
                              ),
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 32.h),

                      // Playlist Name Input
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const CommonText(
                          text: "Playlist Name",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        controller: controller.nameController,
                        maxLength: 40,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Playlist Name",
                          hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
                          filled: true,
                          fillColor: const Color(0xFF1C1C1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          counterText: "", // Hide default counter text
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Obx(() => Align(
                        alignment: Alignment.centerRight,
                        child: CommonText(
                          text: "${controller.nameLength.value}/40",
                          fontSize: 12,
                          color: const Color(0xFF8E8E93),
                        ),
                      )),
                      SizedBox(height: 20.h),

                      // Description Input
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const CommonText(
                              text: "Description ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            const CommonText(
                              text: "(Optional)",
                              fontSize: 13,
                              color: Color(0xFF8E8E93),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        controller: controller.descController,
                        maxLength: 80,
                        maxLines: 4,
                        minLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Add A Short Description",
                          hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
                          filled: true,
                          fillColor: const Color(0xFF1C1C1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          counterText: "", // Hide default counter text
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Obx(() => Align(
                        alignment: Alignment.centerRight,
                        child: CommonText(
                          text: "${controller.descLength.value}/80",
                          fontSize: 12,
                          color: const Color(0xFF8E8E93),
                        ),
                      )),
                      
                      SizedBox(height: 36.h),

                      // Action Button
                      Obx(() {
                        final isValid = controller.isFormValid.value;
                        return SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: isValid ? () => controller.submitPlaylist() : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isValid ? const Color(0xFF1DB954) : const Color(0xFF3A3A3C),
                              disabledBackgroundColor: const Color(0xFF3A3A3C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                              elevation: 0,
                            ),
                            child: CommonText(
                              text: "Continue",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isValid ? Colors.white : const Color(0xFF8E8E93),
                            ),
                          ),
                        );
                      }),
                      
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

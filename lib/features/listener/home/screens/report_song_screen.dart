import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/utils/app_snackbar.dart';

class ReportSongScreen extends StatefulWidget {
  const ReportSongScreen({super.key});

  @override
  State<ReportSongScreen> createState() => _ReportSongScreenState();
}

class _ReportSongScreenState extends State<ReportSongScreen> {
  int _selectedIndex = -1;
  final TextEditingController _detailsController = TextEditingController();

  final List<Map<String, dynamic>> _reasons = [
    {
      "title": "Copyright issue",
      "subtitle": "This song violates my copyright",
      "icon": Icons.copyright_rounded,
      "iconColor": const Color(0xFF1DB954),
      "iconBgColor": const Color(0x1A1DB954),
    },
    {
      "title": "Offensive content",
      "subtitle": "This content is violent or offensive",
      "icon": Icons.warning_amber_rounded,
      "iconColor": const Color(0xFFFB923C),
      "iconBgColor": const Color(0x1AFB923C),
    },
    {
      "title": "Hate speech",
      "subtitle": "This content promotes hate or discrimination",
      "icon": Icons.chat_bubble_outline_rounded,
      "iconColor": const Color(0xFFC084FC),
      "iconBgColor": const Color(0x1AC084FC),
    },
    {
      "title": "Spam or misleading",
      "subtitle": "This song or artist is misleading or spam",
      "icon": Icons.error_outline_rounded,
      "iconColor": const Color(0xFFFACC15),
      "iconBgColor": const Color(0x1AFACC15),
    },
    {
      "title": "Audio problem",
      "subtitle": "There is a problem with the audio quality",
      "icon": Icons.visibility_outlined,
      "iconColor": const Color(0xFF60A5FA),
      "iconBgColor": const Color(0x1A60A5FA),
    },
    {
      "title": "Other",
      "subtitle": "Something else is wrong",
      "icon": Icons.more_horiz_rounded,
      "iconColor": const Color(0xFF9CA3AF),
      "iconBgColor": const Color(0x1A9CA3AF),
    },
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _submitReport() {
    if (_selectedIndex == -1) {
      AppSnackbar.error(
        title: "Selection Required",
        message: "Please select why you are reporting this song.",
      );
      return;
    }

    // Report successfully submitted action
    AppSnackbar.success(
      title: "Report Submitted",
      message: "Thank you. Your report has been submitted for review.",
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        resizeToAvoidBottomInset: true,
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
                // Custom App Bar Header
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
                              text: "Report Song",
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

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),

                        // Shield Icon & Header Info
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 68.r,
                                width: 68.r,
                                decoration: BoxDecoration(
                                  color: const Color(0x141DB954),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0x331DB954),
                                    width: 1.5.r,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.verified_user_outlined,
                                    color: Color(0xFF1DB954),
                                    size: 32,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              const CommonText(
                                text: "Report this song",
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8.h),
                              const CommonText(
                                text: "Let us know what's wrong with this content.\nYour report will be reviewed by our team.",
                                fontSize: 13,
                                color: Color(0xFF8E8E93),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),

                        // List Header
                        const CommonText(
                          text: "Why are you reporting this song?",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: 16.h),

                        // Option Items
                        ...List.generate(_reasons.length, (index) {
                          final reason = _reasons[index];
                          final isSelected = _selectedIndex == index;

                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF131315),
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0x661DB954)
                                        : Colors.transparent,
                                    width: 1.r,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Left icon in colored background circle
                                    Container(
                                      height: 42.r,
                                      width: 42.r,
                                      decoration: BoxDecoration(
                                        color: reason["iconBgColor"],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          reason["icon"],
                                          color: reason["iconColor"],
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 14.w),

                                    // Reason labels
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                            text: reason["title"],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 2.h),
                                          CommonText(
                                            text: reason["subtitle"],
                                            fontSize: 11,
                                            color: const Color(0xFF8E8E93),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Custom Radio Button
                                    Container(
                                      height: 20.r,
                                      width: 20.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF1DB954)
                                              : const Color(0xFF3A3A3C),
                                          width: 2.r,
                                        ),
                                        color: isSelected
                                            ? const Color(0xFF1DB954)
                                            : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? Center(
                                              child: Icon(
                                                Icons.check_rounded,
                                                color: Colors.white,
                                                size: 12.sp,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 20.h),

                        // Text Area Header
                        const CommonText(
                          text: "Add more details (optional)",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: 12.h),

                        // Text Area Box
                        Container(
                          height: 130.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF131315),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: const Color(0xFF2C2C2E),
                              width: 1.r,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          child: Stack(
                            children: [
                              TextField(
                                controller: _detailsController,
                                maxLines: 4,
                                maxLength: 300,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Provide any additional information...",
                                  hintStyle: TextStyle(
                                    color: Colors.white24,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CommonText(
                                  text: "${_detailsController.text.length}/300",
                                  fontSize: 11,
                                  color: Colors.white24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),

                // Pinned Action Button at the bottom
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: CommonButton(
                    titleText: "Submit Report",
                    onTap: _submitReport,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

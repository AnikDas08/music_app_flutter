import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';

class ArtistOnboardingScreen extends StatefulWidget {
  const ArtistOnboardingScreen({super.key});

  @override
  State<ArtistOnboardingScreen> createState() => _ArtistOnboardingScreenState();
}

class _ArtistOnboardingScreenState extends State<ArtistOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage1(),
                  _buildPage2(),
                  _buildPage3(),
                  _buildPage4(),
                  _buildPage5(),
                ],
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  // --- Artist Onboarding Page 1 ---
  Widget _buildPage1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageHeader(
            "assets/images/artist_onboarding_first.png",
            556,
            overlappingWidget: _buildCrownNoteIcon(),
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const CommonText(
                  text: "Earn From Your Biggest Fans",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                const CommonText(
                  text: "Turn Your Passion Into Monthly Income Through Subscriptions And Fan Support",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Artist Onboarding Page 2 ---
  Widget _buildPage2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageHeader(
            "assets/images/artist_onboariding_second.png",
            480,
            overlappingWidget: _buildUploadIcon(),
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const CommonText(
                  text: "Upload Music & Exclusive Content",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                const CommonText(
                  text: "Upload Your Songs, EPs, Albums And Exclusive Content For Your Subscribers.",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Artist Onboarding Page 3 ---
  Widget _buildPage3() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageHeader(
            "assets/images/artist_onboarding_third.png",
            469,
            overlappingWidget: _buildSubscriberCard(),
          ),
          SizedBox(height: 45.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const CommonText(
                  text: "Grow Your Subscriber Community",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                const CommonText(
                  text: "Fans Subscribe Monthly To Support Your Music Journey And Unlock Exclusive Perks.",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Artist Onboarding Page 4 ---
  Widget _buildPage4() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageHeader("assets/images/artist_onboarding_fourth.png", 350),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const SizedBox(height: 100,),
                const CommonText(
                  text: "Track Earnings In Real Time",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                const CommonText(
                  text: "Monitor Subscribers, Plays, Tips And Withdrawals Instantly.",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Artist Onboarding Page 5 ---
  Widget _buildPage5() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageHeader("assets/images/artist_onboarding_fifth.png", 500),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const CommonText(
                  text: "Start Your Journey",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                const CommonText(
                  text: "Create Your Artist Profile And Start Building Your Legacy On MuzikGen.",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Page Header Builder ---
  Widget _buildImageHeader(
    String imagePath,
    double height, {
    Widget? overlappingWidget,
  }) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Image with bottom fade shader
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
              stops: [0.75, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: CommonImage(
            imageSrc: imagePath,
            height: height.h,
            width: double.infinity,
            fill: BoxFit.fill,
          ),
        ),
        // Custom Back Button Overlay
        Positioned(
          top: 50.h,
          left: 20.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: const Color(0xff242424).withOpacity(0.6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: CommonImage(
                  imageSrc: "assets/icons/back_icon.svg",
                  height: 20.h,
                  width: 20.w,
                  imageColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Overlapping icon/card if specified
        if (overlappingWidget != null)
          Positioned(
            bottom: -32.h,
            child: overlappingWidget,
          ),
      ],
    );
  }

  // --- Overlapping Floating Widgets ---

  // Page 1 Floating Crown and Note Icon
  Widget _buildCrownNoteIcon() {
    return Container(
      height: 76.r,
      width: 76.r,
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryColor, width: 2.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.18),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.workspace_premium, // Crown-like crown/award
            color: const Color(0xFFFFD700), // Gold
            size: 18.sp,
          ),
          SizedBox(height: 2.h),
          Icon(
            Icons.music_note,
            color: const Color(0xFFFFD700), // Gold
            size: 26.sp,
          ),
        ],
      ),
    );
  }

  // Page 2 Floating Upload Icon
  Widget _buildUploadIcon() {
    return Container(
      height: 76.r,
      width: 76.r,
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFA855F7), width: 2.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA855F7).withOpacity(0.18),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.upload,
          color: const Color(0xFFA855F7), // Purple icon
          size: 32.sp,
        ),
      ),
    );
  }

  // Page 3 Floating Subscriber Card
  Widget _buildSubscriberCard() {
    return Container(
      width: 320.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.06), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOverlappingAvatars(),
                SizedBox(height: 8.h),
                const CommonText(
                  text: "Your Subscribers",
                  fontSize: 13,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    const CommonText(
                      text: "12.4K",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(width: 8.w),
                    const CommonText(
                      text: "+23%",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.12),
            ),
            child: Icon(
              Icons.people_outline,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  // Page 3 Helper: Overlapping subscriber profile avatars
  Widget _buildOverlappingAvatars() {
    final avatars = [
      "assets/images/listener_ob_1.png",
      "assets/images/listener_ob_2.png",
      "assets/images/listener_ob_3.png",
      "assets/images/artist_role_image.png",
      "assets/images/listner_role_image.png",
    ];
    return SizedBox(
      height: 32.h,
      width: 120.w,
      child: Stack(
        children: List.generate(5, (index) {
          return Positioned(
            left: index * 18.w,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 1.5.r),
              ),
              child: CircleAvatar(
                radius: 14.r,
                backgroundImage: AssetImage(avatars[index]),
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- Bottom Indicator & Buttons ---
  Widget _buildBottomSection() {
    final bool isLastPage = _currentPage == 4;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 40.h,
        top: 10.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 5-dot Page Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isActive = _currentPage == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 8.h,
                width: isActive ? 24.w : 8.w,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primaryColor
                      : const Color(0xFF0F3D25),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              );
            }),
          ),
          SizedBox(height: 24.h),
          // Action Buttons
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLastPage
                ? CommonButton(
                    titleText: "Get Started",
                    buttonHeight: 54.h,
                    onTap: () {
                      Get.toNamed(AppRoutes.signUp);
                    },
                  )
                : Row(
                    children: [
                      // Skip Button
                      Expanded(
                        flex: 4,
                        child: CommonButton(
                          titleText: "Skip",
                          buttonColor: const Color(0xFF2C2C2E),
                          borderColor: const Color(0xFF2C2C2E),
                          buttonHeight: 54.h,
                          onTap: () {
                            Get.toNamed(AppRoutes.signUp);
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Next Button
                      Expanded(
                        flex: 5,
                        child: CommonButton(
                          titleText: "Next",
                          buttonHeight: 54.h,
                          onTap: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/image/common_image.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';

class ListenerOnboardingScreen extends StatefulWidget {
  const ListenerOnboardingScreen({super.key});

  @override
  State<ListenerOnboardingScreen> createState() =>
      _ListenerOnboardingScreenState();
}

class _ListenerOnboardingScreenState extends State<ListenerOnboardingScreen> {
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
                children: [_buildPage1(), _buildPage2(), _buildPage3()],
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  // --- Onboarding Page 1 ---
  Widget _buildPage1() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader("assets/images/listener_onboarding_first.png", 303),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: "DISCOVER",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8.h),
                const CommonText(
                  text: "Support Artists\nYou Love",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                SizedBox(height: 8.h),
                const CommonText(
                  text: "Choose the artists you enjoy and subscribe to support their journey.",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                ),
                SizedBox(height: 20.h),
                _buildCardItem(
                  iconData: Icons.favorite_border,
                  title: "Follow your favorite artists",
                  subtitle: "Stay connected to the music you love.",
                ),
                SizedBox(height: 12.h),
                _buildCardItem(
                  iconData: Icons.people_outline,
                  title: "Support their craft",
                  subtitle: "Your subscription makes a real impact.",
                ),
                SizedBox(height: 12.h),
                _buildCardItem(
                  iconData: Icons.star_border,
                  title: "Be part of their community",
                  subtitle: "Join a global community of real fans.",
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Onboarding Page 2 ---
  Widget _buildPage2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader(
            "assets/images/listener_onboarding_second.png",
            611,
            showLockOverlay: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Transform.translate(
              offset: const Offset(0, -100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: GoogleFonts.lato(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      children: [
                        const TextSpan(
                          text: "Unlock\n",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "Exclusive Access",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const CommonText(
                    text: "Access exclusive music and fan content.",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  SizedBox(height: 12.h),
                  const CommonText(
                    text: "Enjoy unreleased songs, subscriber-only content and direct artist access.",
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondaryTextColor,
                    textAlign: TextAlign.left,
                    maxLines: 3,
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Onboarding Page 3 ---
  Widget _buildPage3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader("assets/images/listener_onboarding_third.png", 537),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Transform.translate(
              offset: const Offset(0, -100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: "CONNECT",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 8.h),
                  const CommonText(
                    text: "Your Support\nGoes Directly",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.h),
                  const CommonText(
                    text: "Your subscription goes straight to the artists you listen to.",
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondaryTextColor,
                    textAlign: TextAlign.left,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.h),
                  _buildCardItem(
                    iconData: Icons.monetization_on_outlined,
                    title: "Direct artist support",
                    subtitle: "No middlemen. You make the difference.",
                  ),
                  SizedBox(height: 12.h),
                  _buildCardItem(
                    iconData: Icons.bar_chart_outlined,
                    title: "Stronger music ecosystem",
                    subtitle: "Help artists create and grow sustainably.",
                  ),
                  SizedBox(height: 12.h),
                  _buildCardItem(
                    iconData: Icons.verified_user_outlined,
                    title: "Secure & transparent",
                    subtitle: "Safe payments. Clear earnings.",
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Common UI Components ---

  Widget _buildImageHeader(
    String imagePath,
    double height, {
    bool showLockOverlay = false,
  }) {
    return Stack(
      children: [
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
        if (showLockOverlay)
          Positioned(
            bottom: 100.h,
            left: 20.w,
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
                border: Border.all(color: AppColors.primaryColor, width: 1.5.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.lock_outline,
                color: AppColors.primaryColor,
                size: 28.sp,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCardItem({
    required IconData iconData,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.03), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 1.2.r),
            ),
            child: Icon(iconData, color: AppColors.primaryColor, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: title,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: subtitle,
                  fontSize: 13,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    final bool isLastPage = _currentPage == 2;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
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

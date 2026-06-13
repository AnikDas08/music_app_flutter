import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/pop_up/common_pop_menu.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/config/route/app_routes.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_profile_controller.dart';
import '../widgets/active_subscription_card.dart';
import '../widgets/profile_option_card.dart';
import '../widgets/user_info_card.dart';

class ListnerProfileScreen extends StatelessWidget {
  const ListnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListnerProfileController>(
      init: ListnerProfileController(),
      builder: (controller) {
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
                  Color(0xFF0B1F13), // Soft dark green glow at the top matching mockup
                  Color(0xFF0A0A0A), // Black transition
                ],
                stops: [0.0, 0.35],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // App Bar Header
                  _buildHeader(),
                  SizedBox(height: 16.h),

                  // Main Scrollable Area
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          // User Info Card
                          UserInfoCard(controller: controller),
                          SizedBox(height: 16.h),

                          // Active Subscription Card
                          ActiveSubscriptionCard(controller: controller),
                          SizedBox(height: 16.h),

                          // Payment & History Card
                          ProfileOptionCard(
                            icon: Icons.credit_card_outlined,
                            title: 'Payment & History',
                            subtitle: 'View payments and reciepts',
                            onTap: () {
                              Get.toNamed(AppRoutes.listnerPaymentHistory);
                            },
                          ),

                          // Downloads Card
                          ProfileOptionCard(
                            icon: Icons.file_download_outlined,
                            title: 'Downloads',
                            subtitle: 'Manage your downloaded music',
                            onTap: () {
                              // Placeholder action
                            },
                          ),

                          // Settings Card
                          ProfileOptionCard(
                            icon: Icons.settings_outlined,
                            title: 'Settings',
                            subtitle: 'Manage Your app preferences',
                            onTap: () {
                              Get.toNamed(AppRoutes.setting);
                            },
                          ),

                          // Help & Support Card
                          ProfileOptionCard(
                            icon: Icons.chat_bubble_outline_outlined,
                            title: 'Help & Support',
                            subtitle: 'Get help with our services',
                            onTap: () {
                              Get.toNamed(AppRoutes.listnerHelpSupport);
                            },
                          ),

                          // FAQ Card
                          ProfileOptionCard(
                            icon: Icons.quiz_outlined,
                            title: 'FAQ',
                            subtitle: 'Learn how Muzikgen works',
                            onTap: () {
                              Get.toNamed(AppRoutes.listnerFaq);
                            },
                          ),
                          SizedBox(height: 20.h),

                          // Log Out Button
                          _buildLogOutButton(),
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
      },
    );
  }

  // --- Header ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
      child: const Center(
        child: CommonText(
          text: 'Profile',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // --- Log Out Button ---
  Widget _buildLogOutButton() {
    return OutlinedButton(
      onPressed: logOutPopUp,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.red, width: 1.5),
        shape: const StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        minimumSize: Size(double.infinity, 48.h),
        backgroundColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.logout,
            color: AppColors.red,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          const CommonText(
            text: 'Log Out',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.red,
          ),
        ],
      ),
    );
  }
}

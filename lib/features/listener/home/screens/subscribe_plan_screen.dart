import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/other_widgets/common_app_bar.dart';

class SubscribePlanScreen extends StatefulWidget {
  const SubscribePlanScreen({super.key});

  @override
  State<SubscribePlanScreen> createState() => _SubscribePlanScreenState();
}

class _SubscribePlanScreenState extends State<SubscribePlanScreen> {
  bool _isMonthly = true;

  @override
  Widget build(BuildContext context) {
    final String artistName = Get.arguments?['name'] ?? "Kendi Mustaq";
    final String artistImage = Get.arguments?['image'] ?? "assets/images/artist_onboarding_first.png";
    final String price = Get.arguments?['price'] ?? "UGX 1,000";

    final String monthlyVal = price;
    final String yearlyVal = price.replaceAll("1,000", "10,000").replaceAll("1000", "10000");

    final String activePrice = _isMonthly ? "$monthlyVal/MONTH" : "$yearlyVal/YEAR";
    final String renewText = _isMonthly 
        ? "Billed Monthly. Renews Automatically" 
        : "Billed Annually. Renews Automatically";

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0E2519), // Dark green at top
            Color(0xFF0A0A0A), // Black at bottom
          ],
          stops: [0.0, 0.4],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(title: "Join $artistName"),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subtitle & Artist Image Stack
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Positioned(
                      right: 0,
                      child: Container(
                        height: 140.r,
                        width: 140.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFFF9F0A).withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 120.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "Unlock The Full Catalog",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 6.h),
                          CommonText(
                            text: "And Support $artistName Directly",
                            fontSize: 14,
                            color: Colors.white60,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        artistImage,
                        height: 100.r,
                        width: 100.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28.h),

                // Choose Your Plan Title
                CommonText(
                  text: "Choose Your Plan",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 12.h),

                // Plan Selector Row
                Row(
                  children: [
                    // Monthly Card
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMonthly = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: _isMonthly 
                                ? const Color(0xFF00C853).withValues(alpha: 0.08)
                                : const Color(0xFF1B1B1C),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: _isMonthly 
                                  ? const Color(0xFF00C853)
                                  : Colors.white.withValues(alpha: 0.08),
                              width: 1.5.r,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.workspace_premium,
                                    color: _isMonthly ? const Color(0xFF00C853) : Colors.white60,
                                    size: 16.sp,
                                  ),
                                  Container(
                                    height: 16.r,
                                    width: 16.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _isMonthly ? const Color(0xFF00C853) : Colors.transparent,
                                      border: Border.all(
                                        color: _isMonthly ? const Color(0xFF00C853) : Colors.white30,
                                        width: 1.r,
                                      ),
                                    ),
                                    child: _isMonthly 
                                        ? Icon(Icons.check, color: Colors.white, size: 10.sp)
                                        : null,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              CommonText(
                                text: "Monthly",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 2.h),
                              CommonText(
                                text: "Cancel Anytime",
                                fontSize: 11,
                                color: Colors.white38,
                              ),
                              SizedBox(height: 8.h),
                              CommonText(
                                text: monthlyVal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 2.h),
                              CommonText(
                                text: "Per Month",
                                fontSize: 10,
                                color: Colors.white38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Yearly Card
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMonthly = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: !_isMonthly 
                                ? const Color(0xFF00C853).withValues(alpha: 0.08)
                                : const Color(0xFF1B1B1C),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: !_isMonthly 
                                  ? const Color(0xFF00C853)
                                  : Colors.white.withValues(alpha: 0.08),
                              width: 1.5.r,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.workspace_premium,
                                    color: !_isMonthly ? const Color(0xFF00C853) : Colors.white60,
                                    size: 16.sp,
                                  ),
                                  Container(
                                    height: 16.r,
                                    width: 16.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: !_isMonthly ? const Color(0xFF00C853) : Colors.transparent,
                                      border: Border.all(
                                        color: !_isMonthly ? const Color(0xFF00C853) : Colors.white30,
                                        width: 1.r,
                                      ),
                                    ),
                                    child: !_isMonthly 
                                        ? Icon(Icons.check, color: Colors.white, size: 10.sp)
                                        : null,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              CommonText(
                                text: "Yearly",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 2.h),
                              CommonText(
                                text: "Cancel Anytime",
                                fontSize: 11,
                                color: Colors.white38,
                              ),
                              SizedBox(height: 8.h),
                              CommonText(
                                text: yearlyVal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 2.h),
                              CommonText(
                                text: "Per Years",
                                fontSize: 10,
                                color: Colors.white38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // What You'll Get Title
                CommonText(
                  text: "What You'll Get",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 12.h),

                // Features Container Box
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B1B1C),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      _buildFeatureRow(Icons.music_note_outlined, "Full Catalog", "Get Full Access To All Songs And Releases"),
                      SizedBox(height: 12.h),
                      _buildFeatureRow(Icons.star_border, "Exclusive Releases", "Listen To Unreleased And Behind The Scenes Content"),
                      SizedBox(height: 12.h),
                      _buildFeatureRow(Icons.file_download_outlined, "Offline Listening", "Download Your Favorite Songs And Listen Any Where"),
                      SizedBox(height: 12.h),
                      _buildFeatureRow(Icons.favorite_border_outlined, "Direct Artist Support", "Your Subscription Directly Support $artistName"),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Trust Badges Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTrustBadge(Icons.sync, "Cancel\nAnytime", Colors.white70),
                    _buildTrustBadge(Icons.gpp_good_outlined, "Secure\nPayment", const Color(0xFF00C853)),
                    _buildTrustBadge(Icons.bolt, "Instant\nAccess", const Color(0xFFFFD700)),
                    _buildTrustBadge(Icons.block_flipped, "No Hidden\nFees", const Color(0xFFFF3B30)),
                  ],
                ),
                SizedBox(height: 24.h),

                // Start Listening Button
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.snackbar(
                      "Subscription Success",
                      "Thank you for supporting $artistName!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF00C853),
                      colorText: Colors.white,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C853),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        CommonText(
                          text: "START LISTENING $activePrice",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                // Billed Annually / Monthly subtitle text
                Center(
                  child: CommonText(
                    text: renewText,
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
                SizedBox(height: 12.h),

                // Privacy Policy And Terms links
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.lato(fontSize: 11.sp, color: Colors.white38),
                      children: [
                        const TextSpan(text: "By Continue Our "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: GoogleFonts.lato(
                            color: const Color(0xFF00C853),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: " And "),
                        TextSpan(
                          text: "Terms & Condition",
                          style: GoogleFonts.lato(
                            color: const Color(0xFF00C853),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 32.r,
          width: 32.r,
          decoration: BoxDecoration(
            color: const Color(0xFF00C853).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF00C853),
            size: 16.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              CommonText(
                text: subtitle,
                fontSize: 11,
                color: Colors.white54,
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrustBadge(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20.sp,
        ),
        SizedBox(height: 6.h),
        CommonText(
          text: label,
          fontSize: 10,
          color: Colors.white54,
          maxLines: 2,
        ),
      ],
    );
  }
}

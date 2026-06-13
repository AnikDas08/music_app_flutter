import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class ListnerFaqScreen extends StatelessWidget {
  const ListnerFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FAQ Question-Answer List Data
    final List<Map<String, String>> faqList = [
      {
        'question': '• How Do I Subscribe With An Artists?',
        'answer': 'To subscribe to an artist, navigate to their artist profile page, click on the Subscribe button, choose your preferred plan (monthly or yearly), and complete the payment using Mobile Money or Cards.',
      },
      {
        'question': '• Can I Cancel My Subscription Anytime?',
        'answer': 'Yes, you can cancel your subscriptions at any time. Go to Profile -> Active Subscriptions -> Manage -> Cancel. You will retain premium access until the current billing cycle ends.',
      },
      {
        'question': '• What Payment Method Are Accepted?',
        'answer': 'We support major payments including MTN Mobile Money, Airtel Money, credit cards, and local secure wallets.',
      },
      {
        'question': '• How Do I Download Song For Offline Listening',
        'answer': 'To download songs, navigate to the catalog of any subscribed artist and click the download icon. Downloaded files can be listed offline from your profile downloads page.',
      },
    ];

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
              Color(0xFF0B1F13), // Soft green glow matching mockup
              Color(0xFF0A0A0A), // Black transition
            ],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: 20.h),

              // FAQ List Area
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: faqList.length,
                  itemBuilder: (context, index) {
                    final item = faqList[index];
                    return FaqItemWidget(
                      question: item['question']!,
                      answer: item['answer']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Header ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Glass Back Button on left
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                     height: 40.r,
                     width: 40.r,
                     decoration: BoxDecoration(
                       color: Colors.white.withValues(alpha: 0.08),
                       shape: BoxShape.circle,
                       border: Border.all(
                         color: Colors.white.withValues(alpha: 0.15),
                         width: 1.r,
                       ),
                     ),
                     child: const Center(
                       child: Icon(
                         Icons.chevron_left,
                         color: Colors.white,
                         size: 24,
                       ),
                     ),
                  ),
                ),
              ),
            ),
          ),
          const CommonText(
            text: 'FAQ Question',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

// --- Accordion-style Stateful FAQ Item Widget ---
class FaqItemWidget extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItemWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FaqItemWidget> createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<FaqItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Question Row clickable area
          InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonText(
                      text: widget.question,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
          // Expanded Answer Detail Box
          if (_isExpanded)
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 18.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CommonText(
                  text: widget.answer,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

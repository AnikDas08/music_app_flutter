import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/payment_history_logs_controller.dart';

class ListnerPaymentHistoryLogsScreen extends StatelessWidget {
  const ListnerPaymentHistoryLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<PaymentHistoryLogsController>()
        ? Get.find<PaymentHistoryLogsController>()
        : Get.put(PaymentHistoryLogsController());

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
              SizedBox(height: 16.h),

              // Content Area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(() {
                    return Column(
                      children: [
                        // Dynamic Total Spent Card
                        _buildTotalSpentCard(controller),
                        SizedBox(height: 20.h),

                        // Transactions container card
                        _buildTransactionsCard(controller),
                        SizedBox(height: 24.h),
                      ],
                    );
                  }),
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
            text: 'Payment History',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Total Spent Card ---
  Widget _buildTotalSpentCard(PaymentHistoryLogsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF034A29), // Emerald forest green
            Color(0xFF082717), // Rich dark green glow
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'Total Spent',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.6),
              ),

              // Dropdown button for filtering
              PopupMenuButton<String>(
                color: const Color(0xFF1C1C1E),
                onSelected: (String filter) => controller.changeTimeFilter(filter),
                itemBuilder: (BuildContext context) {
                  return controller.timeFilters.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: CommonText(
                        text: choice,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    );
                  }).toList();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonText(
                        text: controller.selectedTimeFilter.value,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 16.r,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Total Spent Amount Text (corresponds to selected filter)
          CommonText(
            text: controller.totalSpent == 'UGX 45,000' && controller.selectedTimeFilter.value == 'All Time'
                ? controller.mockupTotalSpent
                : controller.totalSpent,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Transactions Card Group ---
  Widget _buildTransactionsCard(PaymentHistoryLogsController controller) {
    final list = controller.visibleTransactions;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.r,
        ),
      ),
      child: Column(
        children: [
          // List entries
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final tx = list[index];
              return Column(
                children: [
                  _buildTransactionRow(tx),
                  if (index < list.length - 1) _buildDivider(),
                ],
              );
            },
          ),
          SizedBox(height: 16.h),

          // View More / View Less using CommonButton
          CommonButton(
            titleText: controller.isExpanded.value ? 'View Less' : 'View More',
            buttonColor: Colors.transparent,
            borderColor: Colors.white.withValues(alpha: 0.1),
            titleColor: Colors.white,
            titleSize: 14,
            buttonRadius: 8.r,
            buttonHeight: 44.h,
            onTap: () => controller.toggleExpansion(),
          ),
        ],
      ),
    );
  }

  // --- Single Transaction Entry Row Builder ---
  Widget _buildTransactionRow(Map<String, dynamic> tx) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // Left: Green box with music note icon
          Container(
            height: 40.r,
            width: 40.r,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2E25),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Center(
              child: Icon(
                Icons.music_note,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // Middle: Date and Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: tx['date'],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: tx['title'],
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),

          // Right: Amount and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonText(
                text: tx['amount'],
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 4.h),
              CommonText(
                text: tx['status'],
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Thin Divider Builder ---
  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.05),
      height: 1.r,
      thickness: 1.r,
    );
  }
}

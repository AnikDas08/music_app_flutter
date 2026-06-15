import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/button/common_button.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/component/text_field/common_text_field.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';
import '../controller/listner_billing_payment_controller.dart';

class ListnerBillingPaymentScreen extends StatelessWidget {
  const ListnerBillingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ListnerBillingPaymentController>()
        ? Get.find<ListnerBillingPaymentController>()
        : Get.put(ListnerBillingPaymentController());

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
                    final defaultMethod = controller.defaultMethod;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Current Payment Method Header ---
                        _buildSectionHeader('CURRENT PAYMENT METHOD'),
                        SizedBox(height: 8.h),

                        // Current Payment Method Card with Green Border
                        _buildCurrentPaymentCard(defaultMethod),
                        SizedBox(height: 10.h),

                        // Secure Payment Text
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppColors.primaryColor,
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            const CommonText(
                              text: 'Your payments are secure and encrypted.',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        // --- Payment Methods Section ---
                        _buildSectionHeader('PAYMENT METHODS'),
                        SizedBox(height: 8.h),

                        // Payment Methods Card Group
                        _buildPaymentMethodsList(controller),
                        SizedBox(height: 24.h),

                        // --- Billing Details Section ---
                        _buildSectionHeader('BILLING DETAILS'),
                        SizedBox(height: 8.h),

                        // Billing Details Card Group
                        _buildBillingDetailsCard(),
                        SizedBox(height: 24.h),

                        // --- Actions Section ---
                        _buildSectionHeader('ACTIONS'),
                        SizedBox(height: 8.h),

                        // Actions Card
                        _buildActionsCard(context, controller),
                        SizedBox(height: 16.h),

                        // Auto Renew Footer Card
                        _buildAutoRenewCard(),
                        SizedBox(height: 32.h),
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
            text: 'Billing & Payment',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // --- Section Header ---
  Widget _buildSectionHeader(String title) {
    return CommonText(
      text: title,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextColor,
    );
  }

  // --- Current Payment Card ---
  Widget _buildCurrentPaymentCard(Map<String, dynamic> method) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.8),
          width: 1.5.r,
        ),
      ),
      child: Row(
        children: [
          _buildProviderLogo(method['provider']),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: method['title'],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: method['number'],
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0F2618),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: const CommonText(
              text: 'DEFAULT',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.chevron_right,
            color: Colors.white.withValues(alpha: 0.5),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  // --- Payment Methods List Group ---
  Widget _buildPaymentMethodsList(ListnerBillingPaymentController controller) {
    return Container(
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
          // List existing payment methods
          ...List.generate(controller.paymentMethods.length, (index) {
            final method = controller.paymentMethods[index];
            final bool isSelected = method['isDefault'] == true;
            return Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => controller.setDefaultMethod(index),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: Row(
                        children: [
                          _buildProviderLogo(method['provider']),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: method['title'],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 4.h),
                                CommonText(
                                  text: method['number'],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryTextColor,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          if (isSelected) ...[
                            Icon(
                              Icons.check_circle,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white.withValues(alpha: 0.5),
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildDivider(),
              ],
            );
          }),

          // Add New Payment Method trigger
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showAddPaymentMethodSheet(controller),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    // Plus Box Logo
                    Container(
                      height: 40.r,
                      width: 54.r,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: AppColors.primaryColor.withValues(alpha: 0.5),
                          width: 1.r,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: 'Add New Payment Method',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 4.h),
                          CommonText(
                            text: 'Add MTN, Airtel Money or Card',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryTextColor,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Billing Details Card Group ---
  Widget _buildBillingDetailsCard() {
    return Container(
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
          _buildBillingDetailRow(
            icon: Icons.calendar_today_outlined,
            title: 'Billing Cycle',
            value: 'Monthly',
          ),
          _buildDivider(),
          _buildBillingDetailRow(
            icon: Icons.calendar_month_outlined,
            title: 'Next Billing Date',
            value: 'May 15, 2026',
          ),
          _buildDivider(),
          _buildBillingDetailRow(
            icon: Icons.credit_card_outlined,
            title: 'Amount',
            value: 'UGX 1,000',
            valueColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildBillingDetailRow({
    required IconData icon,
    required String title,
    required String value,
    Color valueColor = Colors.white,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CommonText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              textAlign: TextAlign.left,
            ),
          ),
          CommonText(
            text: value,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ],
      ),
    );
  }

  // --- Actions Card ---
  Widget _buildActionsCard(BuildContext context, ListnerBillingPaymentController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.r,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showRemoveConfirmationDialog(context, controller),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                // Red Trash Container
                Container(
                  height: 38.r,
                  width: 38.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E1010),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColors.red,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Remove Payment Method',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 4.h),
                      CommonText(
                        text: 'Remove a saved payment method from your account',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Auto Renew Notification Card ---
  Widget _buildAutoRenewCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.access_time_rounded,
            color: AppColors.primaryColor,
            size: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.lato(fontSize: 13.sp, height: 1.4, color: Colors.white),
                children: [
                  const TextSpan(
                    text: 'Your subscription will auto-renew on the next billing date. You can ',
                  ),
                  TextSpan(
                    text: 'cancel anytime.',
                    style: GoogleFonts.lato(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Reusable Provider Logo Builder ---
  Widget _buildProviderLogo(String provider) {
    if (provider == 'MTN') {
      return Container(
        height: 40.r,
        width: 54.r,
        decoration: BoxDecoration(
          color: const Color(0xFFFFCC00), // MTN yellow
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: const Center(
          child: CommonText(
            text: 'MTN',
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      );
    } else if (provider == 'Airtel') {
      return Container(
        height: 40.r,
        width: 54.r,
        decoration: BoxDecoration(
          color: const Color(0xFFFF0000), // Airtel red
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: const Center(
          child: CommonText(
            text: 'airtel',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container(
        height: 40.r,
        width: 54.r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: const Center(
          child: CommonText(
            text: 'VISA',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F1B5F), // Visa blue
          ),
        ),
      );
    }
  }

  // --- Thin Divider Builder ---
  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.05),
      height: 1.r,
      thickness: 1.r,
      indent: 16.w,
      endIndent: 16.w,
    );
  }

  // --- Add New Payment Method Bottom Sheet Dialog ---
  void _showAddPaymentMethodSheet(ListnerBillingPaymentController controller) {
    final providerRx = 'MTN'.obs;
    final detailsController = TextEditingController();
    final nameController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CommonText(
                  text: 'Add New Payment Method',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),

              // Provider Type Selection
              const CommonText(
                text: 'Select Provider',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProviderSelectionPill('MTN', providerRx.value == 'MTN', () => providerRx.value = 'MTN'),
                      _buildProviderSelectionPill('Airtel', providerRx.value == 'Airtel', () => providerRx.value = 'Airtel'),
                      _buildProviderSelectionPill('Visa', providerRx.value == 'Visa', () => providerRx.value = 'Visa'),
                    ],
                  )),
              SizedBox(height: 20.h),

              // Number or Card Input
              Obx(() => CommonText(
                    text: providerRx.value == 'Visa' ? 'Card Number' : 'Phone Number (Last 9 digits)',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    textAlign: TextAlign.left,
                  )),
              SizedBox(height: 8.h),
              CommonTextField(
                controller: detailsController,
                hintText: 'e.g. 772123456 or 16-digit card number',
                fillColor: const Color(0xFF131315),
                textColor: Colors.white,
                hintTextColor: AppColors.textFiledColor,
                borderColor: Colors.white.withValues(alpha: 0.1),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),

              // Holder Name Input
              const CommonText(
                text: 'Account Holder Name',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              CommonTextField(
                controller: nameController,
                hintText: 'e.g. John Doe',
                fillColor: const Color(0xFF131315),
                textColor: Colors.white,
                hintTextColor: AppColors.textFiledColor,
                borderColor: Colors.white.withValues(alpha: 0.1),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 24.h),

              // Save button using CommonButton
              CommonButton(
                titleText: 'Add Method',
                titleWeight: FontWeight.bold,
                buttonHeight: 48.h,
                onTap: () {
                  if (detailsController.text.trim().isEmpty || nameController.text.trim().isEmpty) {
                    Get.snackbar(
                      'Validation Error',
                      'Please fill in all the details.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF2E1010),
                      colorText: Colors.white,
                    );
                    return;
                  }
                  controller.addPaymentMethod(providerRx.value, detailsController.text.trim());
                  Get.back(); // close bottom sheet
                },
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildProviderSelectionPill(String name, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.15) : const Color(0xFF131315),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.white.withValues(alpha: 0.1),
            width: 1.r,
          ),
        ),
        child: Center(
          child: CommonText(
            text: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.primaryColor : Colors.white,
          ),
        ),
      ),
    );
  }

  // --- Remove Method Confirmation Dialog ---
  void _showRemoveConfirmationDialog(BuildContext context, ListnerBillingPaymentController controller) {
    final String currentTitle = controller.defaultMethod['title'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: const Color(0xFF1C1C1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
            title: const CommonText(
              text: 'Remove Payment Method',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            content: CommonText(
              text: 'Are you sure you want to remove your default method ($currentTitle) from your account? If you have an active subscription, we will switch your billing default.',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryTextColor,
              maxLines: 4,
              textAlign: TextAlign.left,
            ),
            actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.2), width: 1.r),
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: const CommonText(
                        text: 'Cancel',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CommonButton(
                      titleText: 'Remove',
                      buttonColor: AppColors.red,
                      borderColor: AppColors.red,
                      titleColor: Colors.white,
                      titleWeight: FontWeight.bold,
                      buttonHeight: 40.h,
                      onTap: () {
                        controller.removeSelectedMethod();
                        Get.back();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

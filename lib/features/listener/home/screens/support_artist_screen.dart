import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportArtistScreen extends StatefulWidget {
  const SupportArtistScreen({super.key});

  @override
  State<SupportArtistScreen> createState() => _SupportArtistScreenState();
}

class _SupportArtistScreenState extends State<SupportArtistScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _otherAmountController = TextEditingController();
  
  final List<int> _presetAmounts = [1000, 2000, 5000, 10000, 20000];
  int _selectedAmount = 2000;
  bool _isOtherSelected = false;

  @override
  void dispose() {
    _messageController.dispose();
    _otherAmountController.dispose();
    super.dispose();
  }

  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _showOtherAmountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF131315),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            "Enter Amount",
            style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: _otherAmountController,
            keyboardType: TextInputType.number,
            style: GoogleFonts.lato(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter amount in UGX",
              hintStyle: GoogleFonts.lato(color: Colors.white38),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF00C853)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _otherAmountController.clear();
                Get.back();
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.lato(color: Colors.white54),
              ),
            ),
            TextButton(
              onPressed: () {
                final int? parsed = int.tryParse(_otherAmountController.text);
                if (parsed != null && parsed > 0) {
                  setState(() {
                    _selectedAmount = parsed;
                    _isOtherSelected = true;
                  });
                  Get.back();
                } else {
                  Get.snackbar(
                    "Invalid Amount",
                    "Please enter a valid number greater than 0",
                    backgroundColor: const Color(0xFF1E1E1E),
                    colorText: Colors.white,
                  );
                }
              },
              child: Text(
                "Confirm",
                style: GoogleFonts.lato(color: const Color(0xFF00C853), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String artistName = Get.arguments?['name'] ?? "Kendi Mustiq";
    final String artistImage = Get.arguments?['image'] ?? "assets/images/artist_onboarding_first.png";

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white, size: 24.sp),
            padding: EdgeInsets.zero,
            onPressed: () => Get.back(),
          ),
        ),
        title: Text(
          "Support Artist",
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Circle
                    Center(
                      child: Container(
                        height: 96.r,
                        width: 96.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF00C853),
                            width: 2.r,
                          ),
                          image: DecorationImage(
                            image: AssetImage(artistImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Artist Name Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          artistName,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.verified,
                          color: const Color(0xFF00C853),
                          size: 18.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Subtext description
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Your support helps me create more music and bring you the best experience.",
                        style: GoogleFonts.lato(
                          color: Colors.white60,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Green thank you support row
                    Text(
                      "Thank you for supporting! 💜",
                      style: GoogleFonts.lato(
                        color: const Color(0xFF00C853),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),

                    // Send a Tip Title
                    Text(
                      "Send a Tip",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Preset amounts Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 2.1,
                      ),
                      itemBuilder: (context, index) {
                        if (index < 5) {
                          // Presets
                          final amount = _presetAmounts[index];
                          final isSelected = !_isOtherSelected && _selectedAmount == amount;
                          final isPopular = amount == 2000;

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedAmount = amount;
                                    _isOtherSelected = false;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF131315),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF00C853)
                                          : Colors.white.withValues(alpha: 0.05),
                                      width: 1.5.r,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "UGX ${_formatAmount(amount)}",
                                      style: GoogleFonts.lato(
                                        color: isSelected ? Colors.white : Colors.white70,
                                        fontSize: 12.sp,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (isPopular)
                                Positioned(
                                  top: -8.h,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00C853),
                                        borderRadius: BorderRadius.circular(100.r),
                                      ),
                                      child: Text(
                                        "🔥 MOST POPULAR",
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 7.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } else {
                          // Other Amount Selector Card
                          final isSelected = _isOtherSelected;
                          return GestureDetector(
                            onTap: _showOtherAmountDialog,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF131315),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF00C853)
                                      : Colors.white.withValues(alpha: 0.05),
                                  width: 1.5.r,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isOtherSelected
                                        ? "UGX ${_formatAmount(_selectedAmount)}"
                                        : "Other Amount",
                                    style: GoogleFonts.lato(
                                      color: isSelected ? Colors.white : Colors.white70,
                                      fontSize: 12.sp,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.edit_outlined,
                                    color: isSelected ? Colors.white : Colors.white70,
                                    size: 12.sp,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Message optional
                    Text(
                      "Add a message (optional)",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131315),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 1.r,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _messageController,
                            maxLength: 100,
                            maxLines: 3,
                            style: GoogleFonts.lato(color: Colors.white, fontSize: 13.sp),
                            buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                            onChanged: (text) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: "Write a message for the artist...",
                              hintStyle: GoogleFonts.lato(color: Colors.white38, fontSize: 13.sp),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "${_messageController.text.length}/100",
                              style: GoogleFonts.lato(
                                color: Colors.white38,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Payment Method Title
                    Text(
                      "Payment Method",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // MTN Payment card
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131315),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 1.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          // MTN Square logo box
                          Container(
                            height: 40.r,
                            width: 40.r,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFCC00),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                "MTN",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "MTN Mobile Money",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "+256 772 123 456",
                                  style: GoogleFonts.lato(
                                    color: Colors.white38,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white54,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Fixed bottom green action button
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      "Tip Sent Successfully",
                      "Thank you for supporting $artistName with UGX ${_formatAmount(_selectedAmount)}!",
                      backgroundColor: const Color(0xFF131315),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 3),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Send Tip UGX ${_formatAmount(_selectedAmount)}",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

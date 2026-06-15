import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_string.dart';
import '../../services/storage/storage_services.dart';
import '../../utils/helpers/validation.dart';
import '../button/common_button.dart';
import '../text/common_text.dart';
import '../text_field/common_text_field.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
    this.height = 30,
    this.selectedColor = AppColors.primaryColor,
    this.unselectedColor = Colors.transparent,
    this.style,
    this.isContainer = false,
    this.iconColor = AppColors.black,
    this.iconData = Icons.keyboard_arrow_down_outlined,
  });

  final List<String> items;
  final List<String> selectedItem;
  final Color selectedColor;
  final Color iconColor;
  final Color unselectedColor;
  final double height;
  final Function(int index) onTap;
  final TextStyle? style;
  final bool isContainer;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: PopupMenuButton<String>(
        shape: RoundedRectangleBorder(
          borderRadius: .circular(8.r),
          side: BorderSide(color: selectedColor),
        ),
        offset: const Offset(1, 1),
        padding: .zero,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'option1',
            child: Column(
              children: List.generate(
                items.length,
                (index) => GestureDetector(
                  onTap: () async {
                    await AnimationPopUpState.closeDialog();
                    onTap(index);
                  },
                  child: Padding(
                    padding: const .all(12.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const .all(10),
                          decoration: BoxDecoration(
                            border: .all(color: selectedColor),
                            color:
                                selectedItem.contains(items[index].toString())
                                ? selectedColor
                                : unselectedColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(items[index].toString(), style: style),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        icon: Padding(
          padding: .only(left: isContainer ? 40 : 0),
          child: Icon(iconData, color: iconColor, size: height),
        ),
      ),
    );
  }
}

void logOutPopUp() {
  showDialog(
    context: Get.context!,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: AnimationPopUp(
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.2,
                ), // Frosted white glass effect
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.22),
                  width: 1.r,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20.r,
                    spreadRadius: 2.r,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Red Logout Icon inside thin square border
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.r,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.logout,
                        color: const Color(0xffE53935), // Red icon
                        size: 28.r,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Title
                  const CommonText(
                    text: 'Log out of your account?',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),

                  // Subtitle
                  const CommonText(
                    text: 'You can sign back in anytime',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTextColor,
                  ),
                  SizedBox(height: 24.h),

                  // Actions Buttons
                  Row(
                    children: [
                      // Cancel Button (stadium outline shape)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 44.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.03),
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.25),
                                width: 1.r,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const CommonText(
                              text: 'Cancel',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),

                      // Logout Button (stadium solid shape)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            LocalStorage.removeAllPrefData();
                          },
                          child: Container(
                            height: 44.h,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xffE53935,
                              ), // Solid red matching mockup
                              borderRadius: BorderRadius.circular(100.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xffE53935,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 10.r,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const CommonText(
                              text: 'Logout',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void deletePopUp({
  required TextEditingController controller,
  required VoidCallback onTap,
  bool isLoading = false,
}) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AnimationPopUp(
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: .circular(12.0)),
          contentPadding: const .only(bottom: 12),
          title: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Center(
                  child: CommonText(
                    text: AppString.areYouSure,
                    fontSize: 20.sp,
                    fontWeight: .w700,
                    bottom: 24.h,
                  ),
                ),
                CommonText(
                  text: AppString.deleteDetails,
                  fontSize: 16.sp,
                  maxLines: 2,
                  bottom: 20.h,
                ),
                CommonTextField(
                  controller: controller,
                  labelText: AppString.enterYouPassword,
                  validator: AppValidation.required,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    titleText: AppString.cancel,
                    titleColor: AppColors.black,
                    borderColor: AppColors.black,
                    buttonColor: AppColors.transparent,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: AnimationPopUpState.closeDialog,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CommonButton(
                    titleText: AppString.done,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await AnimationPopUpState.closeDialog();
                        onTap();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class AnimationPopUp extends StatefulWidget {
  const AnimationPopUp({super.key, required this.child});

  final Widget child;

  @override
  AnimationPopUpState createState() => AnimationPopUpState();
}

class AnimationPopUpState extends State<AnimationPopUp>
    with TickerProviderStateMixin {
  static late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static Future<void> closeDialog() async {
    await _animationController.reverse();
    if (Get.context!.mounted) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: ModalRoute.of(context)!.animation!,
            child: widget.child,
          ),
        );
      },
    );
  }
}

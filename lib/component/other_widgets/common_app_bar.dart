import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../text/common_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: Center(
        child: GestureDetector(
          onTap: onBackPressed ?? () => Get.back(),
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
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ),
      ),
      title: CommonText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

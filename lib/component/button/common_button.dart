import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../other_widgets/common_loader.dart';
import '../text/common_text.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;
  final bool isLoading;

  const CommonButton({
    this.onTap,
    required this.titleText,
    this.titleColor = AppColors.white,
    this.buttonColor = AppColors.primaryColor,
    this.titleSize = 16,
    this.buttonRadius = 100,
    this.titleWeight = FontWeight.w700,
    this.buttonHeight = 47,
    this.borderWidth = 1,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.borderColor = AppColors.primaryColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _buildElevatedButton();
  }

  Widget _buildElevatedButton() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(buttonRadius),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
          boxShadow: [
            // White highlight for top and left border effect
            BoxShadow(
              color: Colors.white,
              offset: const Offset(-1.5, -1.5),
              blurRadius: 0,
              spreadRadius: 0,
            ),
            // Shadow 1: X=-0.5, Y=-0.5, Blur=0, Spread=0, #952B00 @ 53%
            BoxShadow(
              color: const Color(0xFF952B00).withOpacity(0.53),
              offset: const Offset(-0.5, -0.5),
              blurRadius: 0,
              spreadRadius: 0,
            ),
            // Shadow 2: X=10, Y=10, Blur=21.21, Spread=-3.75, #000000 @ 23%
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.23),
              offset: const Offset(10, 10),
              blurRadius: 21.21,
              spreadRadius: -3.75,
            ),
            // Shadow 3: X=5.9, Y=5.9, Blur=8.35, Spread=-3, #000000 @ 19.2%
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.192),
              offset: const Offset(5.9, 5.9),
              blurRadius: 8.35,
              spreadRadius: -3,
            ),
            // Shadow 4: X=-1, Y=-1, Blur=1, Spread=0, #000000 @ 23%
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.23),
              offset: const Offset(-1, -1),
              blurRadius: 1,
              spreadRadius: 0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: isLoading ? _buildLoader() : _buildText(),
      ),
    );
  }

  Widget _buildLoader() {
    return CommonLoader(size: buttonHeight - 12);
  }

  Widget _buildText() {
    return CommonText(
      text: titleText,
      fontSize: titleSize,
      color: titleColor,
      fontWeight: titleWeight,
    );
  }
}

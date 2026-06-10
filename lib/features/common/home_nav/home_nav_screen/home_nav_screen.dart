import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzikgen_app/component/text/common_text.dart';
import 'package:muzikgen_app/features/profile/presentation/screen/profile_screen.dart';
import '../../../listener/home/screens/listner_home_screen.dart';
import '../../../listener/search/screens/listner_search_screen.dart';
import '../controller/home_nav_controller.dart';
import 'package:muzikgen_app/utils/constants/app_colors.dart';

class HomeNavScreen extends StatelessWidget {
  HomeNavScreen({super.key}) {
    Get.put(HomeNavController());
  }

  final List<Map<String, String>> _navItems = [
    {
      "icon": "assets/icons/home_icon.svg",
      "label": "Home"
    },
    {
      "icon": "assets/icons/search_icon.svg",
      "label": "Search"
    },
    {
      "icon": "assets/icons/library_icon.svg",
      "label": "Library"
    },
    {
      "icon": "assets/icons/profile.svg",
      "label": "Profile"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeNavController>();

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            ListnerHomeScreen(),
            ListnerSearchScreen(),
            Scaffold(backgroundColor: Color(0xFF131315), body: Center(child: CommonText(text: "Library Screen", color: Colors.white, fontSize: 18))),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF131315),
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1.r,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF131315),
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: const Color(0xFF9F9FA9),
            selectedLabelStyle: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              fontSize: 11.sp,
            ),
            unselectedLabelStyle: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
            ),
            iconSize: 24.sp,
            items: List.generate(_navItems.length, (index) {
              final isSelected = controller.selectedIndex.value == index;
              return BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                  child: SvgPicture.asset(
                    _navItems[index]["icon"]!,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.primaryColor : const Color(0xFF9F9FA9),
                      BlendMode.srcIn,
                    ),
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                label: _navItems[index]["label"]!,
              );
            }),
          ),
        ),
      ),
    );
  }
}

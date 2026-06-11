import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/notifications_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Put the controller if not already registered
    final NotificationsController controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
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
          "Notifications",
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.white, size: 24.sp),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            // Top buttons (Mark All Read, Clear All)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () => controller.markAllRead(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C853),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Mark All Read",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () => controller.clearAll(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C2C2E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Clear All",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Notifications List
            Expanded(
              child: controller.mockNotifications.isEmpty
                  ? Center(
                      child: Text(
                        "No Notifications",
                        style: GoogleFonts.lato(
                          color: Colors.white38,
                          fontSize: 16.sp,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      itemCount: controller.mockNotifications.length,
                      itemBuilder: (context, index) {
                        final item = controller.mockNotifications[index];
                        final String id = item['id'];
                        final String type = item['type'];
                        final String title = item['title'];
                        final String subtitle = item['subtitle'];
                        final String mainContent = item['mainContent'];
                        final String imagePath = item['imagePath'];
                        final String time = item['time'];
                        final bool isUnread = item['isUnread'] ?? false;

                        return SwipableNotificationCard(
                          onDelete: () {
                            controller.deleteNotification(id);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFF131315),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Thumbnail Image or Custom Payment Box
                                type == "payment_success"
                                    ? Container(
                                        height: 52.r,
                                        width: 52.r,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF152A22), // Dark green-teal
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.credit_card,
                                            color: const Color(0xFFFFB300),
                                            size: 24.sp,
                                          ),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: Image.asset(
                                          imagePath,
                                          height: 52.r,
                                          width: 52.r,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                SizedBox(width: 12.w),

                                // Details Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Category Title Row
                                      Row(
                                        children: [
                                          if (type == "new_release") ...[
                                            Icon(
                                              Icons.music_note_outlined,
                                              color: const Color(0xFF00C853),
                                              size: 13.sp,
                                            ),
                                            SizedBox(width: 4.w),
                                          ],
                                          Text(
                                            type == "unlocked"
                                                ? "● $title"
                                                : type == "payment_success"
                                                    ? "● $title"
                                                    : title,
                                            style: GoogleFonts.lato(
                                              color: type == "unlocked"
                                                  ? const Color(0xFFFFB300)
                                                  : type == "payment_success"
                                                      ? const Color(0xFF00C853)
                                                      : const Color(0xFF00C853),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (isUnread)
                                            Container(
                                              height: 6.r,
                                              width: 6.r,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFE53935),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          SizedBox(width: 6.w),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),

                                      // Subtitle Info
                                      Text(
                                        subtitle,
                                        style: GoogleFonts.lato(
                                          color: Colors.white38,
                                          fontSize: 11.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4.h),

                                      // Main content title + badges
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              mainContent,
                                              style: GoogleFonts.lato(
                                                color: type == "payment_success"
                                                    ? const Color(0xFF00C853)
                                                    : Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (type == "payment_success") ...[
                                            SizedBox(width: 8.w),
                                            // Mini network badges (MTN, Mastercard, Visa)
                                            _buildPaymentBadge("MTN", const Color(0xFFFFCC00), Colors.black),
                                            SizedBox(width: 4.w),
                                            _buildPaymentBadge("MC", const Color(0xFFFF5F00), Colors.white),
                                            SizedBox(width: 4.w),
                                            _buildPaymentBadge("VISA", const Color(0xFF00579F), Colors.white),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),

                                // Chevron & Time column
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.white24,
                                      size: 18.sp,
                                    ),
                                    SizedBox(height: 18.h),
                                    Text(
                                      time,
                                      style: GoogleFonts.lato(
                                        color: Colors.white24,
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPaymentBadge(String label, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 7.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SwipableNotificationCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onDelete;

  const SwipableNotificationCard({
    super.key,
    required this.child,
    required this.onDelete,
  });

  @override
  State<SwipableNotificationCard> createState() => _SwipableNotificationCardState();
}

class _SwipableNotificationCardState extends State<SwipableNotificationCard> {
  double _slideOffset = 0.0;
  final double _maxSlide = 72.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Left side revealed delete button
        Positioned(
          left: 10.w,
          top: 0,
          bottom: 12.h, // matches margin of notification item card
          child: Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _slideOffset = 0.0;
                });
                widget.onDelete();
              },
              child: Container(
                height: 44.r,
                width: 44.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ),

        // Slidable Foreground Card
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              _slideOffset += details.primaryDelta ?? 0.0;
              if (_slideOffset < 0) _slideOffset = 0.0;
              if (_slideOffset > _maxSlide) _slideOffset = _maxSlide;
            });
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              if (_slideOffset > _maxSlide / 2) {
                _slideOffset = _maxSlide;
              } else {
                _slideOffset = 0.0;
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            transform: Matrix4.translationValues(_slideOffset, 0, 0),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}

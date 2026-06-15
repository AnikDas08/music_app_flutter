import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListnerBillingPaymentController extends GetxController {
  // Reactive list of payment methods
  final paymentMethods = <Map<String, dynamic>>[
    {
      'provider': 'MTN',
      'title': 'MTN Mobile Money',
      'number': '+256 772 123 456',
      'isDefault': true,
    },
    {
      'provider': 'Airtel',
      'title': 'Airtel Money',
      'number': '+256 701 987 654',
      'isDefault': false,
    },
    {
      'provider': 'Visa',
      'title': 'Visa Card',
      'number': '**** **** **** 4582',
      'isDefault': false,
    },
  ].obs;

  // Selected default method index (always matches the default method)
  RxInt get selectedIndex {
    final idx = paymentMethods.indexWhere((method) => method['isDefault'] == true);
    return (idx != -1 ? idx : 0).obs;
  }

  // Get active payment method map
  Map<String, dynamic> get defaultMethod => paymentMethods[selectedIndex.value];

  // Change default payment method
  void setDefaultMethod(int index) {
    for (int i = 0; i < paymentMethods.length; i++) {
      final updated = Map<String, dynamic>.from(paymentMethods[i]);
      updated['isDefault'] = (i == index);
      paymentMethods[i] = updated;
    }
    update();
    Get.snackbar(
      'Payment Method Updated',
      '${paymentMethods[index]['title']} is now your default payment method.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0F2618),
      colorText: Colors.white,
    );
  }

  // Add a new payment method
  void addPaymentMethod(String provider, String details) {
    String title = '';
    String cleanDetails = details;
    if (provider == 'MTN') {
      title = 'MTN Mobile Money';
      if (!cleanDetails.startsWith('+')) {
        cleanDetails = '+256 $cleanDetails';
      }
    } else if (provider == 'Airtel') {
      title = 'Airtel Money';
      if (!cleanDetails.startsWith('+')) {
        cleanDetails = '+256 $cleanDetails';
      }
    } else {
      title = 'Visa Card';
      if (cleanDetails.length >= 4) {
        cleanDetails = '**** **** **** ${cleanDetails.substring(cleanDetails.length - 4)}';
      } else {
        cleanDetails = '**** **** **** $cleanDetails';
      }
    }

    // Add it to the list
    paymentMethods.add({
      'provider': provider,
      'title': title,
      'number': cleanDetails,
      'isDefault': false,
    });
    update();

    Get.snackbar(
      'Success',
      'New payment method added successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0F2618),
      colorText: Colors.white,
    );
  }

  // Remove the currently selected payment method
  void removeSelectedMethod() {
    if (paymentMethods.length <= 1) {
      Get.snackbar(
        'Action Denied',
        'You must keep at least one payment method for active subscriptions.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF2E1010),
        colorText: Colors.white,
      );
      return;
    }

    final int targetIdx = selectedIndex.value;
    final String removedTitle = paymentMethods[targetIdx]['title'];
    paymentMethods.removeAt(targetIdx);

    // Set the first remaining method as default
    final first = Map<String, dynamic>.from(paymentMethods[0]);
    first['isDefault'] = true;
    paymentMethods[0] = first;

    update();

    Get.snackbar(
      'Removed',
      '$removedTitle has been removed from your account.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2E1010),
      colorText: Colors.white,
    );
  }
}

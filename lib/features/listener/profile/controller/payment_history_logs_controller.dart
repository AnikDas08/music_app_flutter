import 'package:get/get.dart';

class PaymentHistoryLogsController extends GetxController {
  // Current time filter selection
  final selectedTimeFilter = 'This Year'.obs;

  // Track if full list is visible
  final isExpanded = false.obs;

  // Full mock list of payment transactions matching mockup
  final allTransactions = <Map<String, dynamic>>[
    {
      'date': 'May 15, 2025',
      'title': 'Subscription • Nakosi Beats',
      'amount': 'UGX 10,000',
      'status': 'Success',
    },
    {
      'date': 'April 15, 2025',
      'title': 'Subscription • Zara Nova',
      'amount': 'UGX 1,000',
      'status': 'Success',
    },
    {
      'date': 'March 15, 2025',
      'title': 'Subscription • Nakosi Beats',
      'amount': 'UGX 10,000',
      'status': 'Success',
    },
    {
      'date': 'Feb 15, 2025',
      'title': 'Subscription • Zara Nova',
      'amount': 'UGX 1,000',
      'status': 'Success',
    },
    {
      'date': 'Jan 15, 2025',
      'title': 'Subscription • Nakosi Beats',
      'amount': 'UGX 10,000',
      'status': 'Success',
    },
    {
      'date': 'Dec 15, 2024',
      'title': 'Subscription • Zara Nova',
      'amount': 'UGX 1,000',
      'status': 'Success',
    },
    // Extra history records shown when user clicks "View More"
    {
      'date': 'Nov 15, 2024',
      'title': 'Subscription • Kendy Mustaq',
      'amount': 'UGX 1,000',
      'status': 'Success',
    },
    {
      'date': 'Oct 15, 2024',
      'title': 'Subscription • Zara Nova',
      'amount': 'UGX 1,000',
      'status': 'Success',
    },
    {
      'date': 'Sept 15, 2024',
      'title': 'Subscription • Nakosi Beats',
      'amount': 'UGX 10,000',
      'status': 'Success',
    },
  ].obs;

  // Filter timeframes list
  final List<String> timeFilters = ['This Year', 'Last 6 Months', 'All Time'];

  // Change time filter
  void changeTimeFilter(String filter) {
    selectedTimeFilter.value = filter;
    update();
  }

  // Toggle list expansion
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
    update();
  }

  // Get list of transactions to show based on expansion state and filter
  List<Map<String, dynamic>> get visibleTransactions {
    // For simplicity, we filter by mock dates / categories or just slice
    List<Map<String, dynamic>> filteredList = allTransactions;
    if (selectedTimeFilter.value == 'Last 6 Months') {
      filteredList = allTransactions.take(4).toList();
    } else if (selectedTimeFilter.value == 'This Year') {
      filteredList = allTransactions.where((tx) => tx['date'].toString().contains('2025')).toList();
    }

    if (!isExpanded.value && filteredList.length > 6) {
      return filteredList.sublist(0, 6);
    }
    return filteredList;
  }

  // Calculate dynamic spent amount based on filter
  String get totalSpent {
    if (selectedTimeFilter.value == 'Last 6 Months') {
      return 'UGX 22,000';
    } else if (selectedTimeFilter.value == 'This Year') {
      return 'UGX 32,000';
    } else {
      return 'UGX 45,000'; // mockup uses UGX 61,000 as default or overall
    }
  }

  // Static total spent that matches the mockup initial state
  String get mockupTotalSpent => 'UGX 61,000';
}

import 'package:get/get.dart';

class ListnerNotificationSettingsController extends GetxController {
  // Main push toggle
  final pushNotifications = true.obs;

  // Subscription section toggles
  final billingUpdates = true.obs;
  final expiringSoon = true.obs;
  final paymentReceipts = true.obs;
  final renewalSuccessful = true.obs;
  final paymentFailed = true.obs;

  // Music & Artist section toggles
  final newReleases = true.obs;
  final newSongs = true.obs;
  final exclusiveContent = true.obs;
  final downloadCompleted = true.obs;

  // App notification toggles
  final appUpdates = true.obs;
  final maintenance = true.obs;
  final securityAlerts = true.obs;

  void togglePushNotifications(bool val) => pushNotifications.value = val;

  void toggleBillingUpdates(bool val) => billingUpdates.value = val;
  void toggleExpiringSoon(bool val) => expiringSoon.value = val;
  void togglePaymentReceipts(bool val) => paymentReceipts.value = val;
  void toggleRenewalSuccessful(bool val) => renewalSuccessful.value = val;
  void togglePaymentFailed(bool val) => paymentFailed.value = val;

  void toggleNewReleases(bool val) => newReleases.value = val;
  void toggleNewSongs(bool val) => newSongs.value = val;
  void toggleExclusiveContent(bool val) => exclusiveContent.value = val;
  void toggleDownloadCompleted(bool val) => downloadCompleted.value = val;

  void toggleAppUpdates(bool val) => appUpdates.value = val;
  void toggleMaintenance(bool val) => maintenance.value = val;
  void toggleSecurityAlerts(bool val) => securityAlerts.value = val;
}

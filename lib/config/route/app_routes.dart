import 'package:get/get.dart';
import '../../features/common/home_nav/home_nav_screen/home_nav_screen.dart';
import '../../features/common/onboarding_screen/artist_onboarding/artist_onboarding_screen.dart';
import '../../features/common/onboarding_screen/listener_onboarding/listener_onboarding_screen.dart';
import '../../features/common/select_role_screen/select_role_screen.dart';
import '../../features/listener/home/screens/details_featuredartists_screen.dart';
import '../../features/listener/home/screens/details_trendingartist_screen.dart';
import '../../features/listener/home/screens/artist_profile_screen.dart';
import '../../features/listener/home/screens/artist_all_songs_screen.dart';
import '../../features/listener/home/screens/subscribe_plan_screen.dart';
import '../../features/listener/home/screens/music_player_screen.dart';
import '../../features/listener/home/screens/support_artist_screen.dart';
import '../../features/listener/home/screens/report_song_screen.dart';
import '../../features/listener/library/screens/recently_played_screen.dart';
import '../../features/listener/library/screens/song_info_screen.dart';
import '../../features/listener/library/screens/create_playlist_screen.dart';
import '../../features/listener/library/screens/add_song_to_playlist_screen.dart';
import '../../features/listener/library/screens/review_playlist_screen.dart';
import '../../features/listener/library/screens/playlist_created_screen.dart';

import '../../features/auth/change_password/presentation/screen/change_password_screen.dart';
import '../../features/auth/forgot password/presentation/screen/create_password.dart';
import '../../features/auth/forgot password/presentation/screen/forgot_password.dart';
import '../../features/auth/forgot password/presentation/screen/verify_screen.dart';
import '../../features/auth/sign in/presentation/screen/sign_in_screen.dart';
import '../../features/auth/sign up/presentation/screen/sign_up_screen.dart';
import '../../features/auth/sign up/presentation/screen/verify_user.dart';
import '../../features/common/onboarding_screen/onboarding_screen.dart';
import '../../features/message/presentation/screen/chat_screen.dart';
import '../../features/message/presentation/screen/message_screen.dart';
import '../../features/notifications/presentation/screen/notifications_screen.dart';
import '../../features/profile/presentation/screen/edit_profile.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/listener/profile/screens/listner_edit_profile_screen.dart';
import '../../features/listener/profile/screens/listner_active_subscription_screen.dart';
import '../../features/listener/profile/screens/listner_subscription_detail_screen.dart';
import '../../features/listener/profile/screens/listner_cancel_subscription_screen.dart';
import '../../features/listener/profile/screens/listner_manage_subscription_screen.dart';
import '../../features/listener/profile/screens/listner_subscription_renew_screen.dart';
import '../../features/listener/profile/screens/listner_settings_screen.dart';
import '../../features/listener/profile/screens/listner_payment_history_screen.dart';
import '../../features/listener/profile/screens/listner_billing_payment_screen.dart';
import '../../features/listener/profile/screens/listner_payment_history_logs_screen.dart';
import '../../features/listener/profile/screens/listner_notification_settings_screen.dart';
import '../../features/listener/profile/screens/listner_about_screen.dart';
import '../../features/listener/profile/screens/listner_delete_account_screen.dart';
import '../../features/listener/profile/screens/listner_help_support_screen.dart';
import '../../features/listener/profile/screens/listner_faq_screen.dart';
import '../../features/listener/profile/screens/listner_playback_preferences_screen.dart';
import '../../features/listener/profile/screens/listner_download_quality_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRoutes {
  static const String test = '/test_screen.dart';
  static const String splash = '/';
  static const String onboarding = '/onboarding_screen.dart';
  static const String artistOnboarding = '/artist_onboarding_screen.dart';
  static const String listenerOnboarding = '/listener_onboarding_screen.dart';
  static const String signUp = '/sign_up_screen.dart';
  static const String verifyUser = '/verify_user.dart';
  static const String signIn = '/sign_in_screen.dart';
  static const String homeNav = '/home_nav_screen.dart';
  static const String forgotPassword = '/forgot_password.dart';
  static const String verifyEmail = '/verify_screen.dart';
  static const String createPassword = '/create_password.dart';
  static const String changePassword = '/change_password_screen.dart';
  static const String notifications = '/notifications_screen.dart';
  static const String chat = '/chat_screen.dart';
  static const String message = '/message_screen.dart';
  static const String profile = '/profile_screen.dart';
  static const String editProfile = '/edit_profile.dart';
  static const String listnerEditProfile = '/listner_edit_profile_screen.dart';
  static const String listnerActiveSubscription =
      '/listner_active_subscription_screen.dart';
  static const String listnerSubscriptionDetail =
      '/listner_subscription_detail_screen.dart';
  static const String listnerCancelSubscription =
      '/listner_cancel_subscription_screen.dart';
  static const String listnerManageSubscription =
      '/listner_manage_subscription_screen.dart';
  static const String listnerSubscriptionRenew =
      '/listner_subscription_renew_screen.dart';
  static const String listnerPaymentHistory =
      '/listner_payment_history_screen.dart';
  static const String listnerBillingPayment =
      '/listner_billing_payment_screen.dart';
  static const String listnerPaymentHistoryLogs =
      '/listner_payment_history_logs_screen.dart';
  static const String listnerNotificationSettings =
      '/listner_notification_settings_screen.dart';
  static const String listnerAbout =
      '/listner_about_screen.dart';
  static const String listnerDeleteAccount =
      '/listner_delete_account_screen.dart';
  static const String listnerHelpSupport = '/listner_help_support_screen.dart';
  static const String listnerFaq = '/listner_faq_screen.dart';
  static const String playbackPreferences = '/playback_preferences_screen.dart';
  static const String downloadQuality = '/download_quality_screen.dart';
  static const String privacyPolicy = '/privacy_policy_screen.dart';
  static const String termsOfServices = '/terms_of_services_screen.dart';
  static const String setting = '/setting_screen.dart';
  static const String selectRole = '/selectRole';
  static const String detailsFeaturedArtists =
      '/details_featuredartists_screen.dart';
  static const String detailsTrendingArtists =
      '/details_trendingartist_screen.dart';
  static const String artistProfile = '/artist_profile_screen.dart';
  static const String artistAllSongs = '/artist_all_songs_screen.dart';
  static const String subscribePlan = '/subscribe_plan_screen.dart';
  static const String musicPlayer = '/music_player_screen.dart';
  static const String supportArtist = '/support_artist_screen.dart';
  static const String recentlyPlayed = '/recently_played_screen.dart';
  static const String songInfo = '/song_info_screen.dart';
  static const String createPlaylist = '/create_playlist_screen.dart';
  static const String addSongToPlaylist = '/add_song_to_playlist_screen.dart';
  static const String reviewPlaylist = '/review_playlist_screen.dart';
  static const String playlistCreated = '/playlist_created_screen.dart';
  static const String reportSong = '/report_song_screen.dart';

  static List<GetPage<String>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: artistOnboarding, page: () => const ArtistOnboardingScreen()),
    GetPage(
      name: listenerOnboarding,
      page: () => const ListenerOnboardingScreen(),
    ),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUser()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: homeNav, page: () => HomeNavScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: verifyEmail, page: () => VerifyScreen()),
    GetPage(name: createPassword, page: () => CreatePassword()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: notifications, page: () => const NotificationScreen()),
    GetPage(name: chat, page: () => const ChatListScreen()),
    GetPage(name: message, page: () => const MessageScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(
      name: listnerEditProfile,
      page: () => const ListnerEditProfileScreen(),
    ),
    GetPage(
      name: listnerActiveSubscription,
      page: () => const ListnerActiveSubscriptionScreen(),
    ),
    GetPage(
      name: listnerSubscriptionDetail,
      page: () => const ListnerSubscriptionDetailScreen(),
    ),
    GetPage(
      name: listnerCancelSubscription,
      page: () => const ListnerCancelSubscriptionScreen(),
    ),
    GetPage(
      name: listnerManageSubscription,
      page: () => const ListnerManageSubscriptionScreen(),
    ),
    GetPage(
      name: listnerSubscriptionRenew,
      page: () => const ListnerSubscriptionRenewScreen(),
    ),
    GetPage(name: setting, page: () => const ListnerSettingsScreen()),
    GetPage(
      name: listnerPaymentHistory,
      page: () => const ListnerPaymentHistoryScreen(),
    ),
    GetPage(
      name: listnerBillingPayment,
      page: () => const ListnerBillingPaymentScreen(),
    ),
    GetPage(
      name: listnerPaymentHistoryLogs,
      page: () => const ListnerPaymentHistoryLogsScreen(),
    ),
    GetPage(
      name: listnerNotificationSettings,
      page: () => const ListnerNotificationSettingsScreen(),
    ),
    GetPage(
      name: listnerAbout,
      page: () => const ListnerAboutScreen(),
    ),
    GetPage(
      name: listnerDeleteAccount,
      page: () => const ListnerDeleteAccountScreen(),
    ),
    GetPage(
      name: listnerHelpSupport,
      page: () => const ListnerHelpSupportScreen(),
    ),
    GetPage(name: listnerFaq, page: () => const ListnerFaqScreen()),
    GetPage(
      name: playbackPreferences,
      page: () => const ListnerPlaybackPreferencesScreen(),
    ),
    GetPage(
      name: downloadQuality,
      page: () => const ListnerDownloadQualityScreen(),
    ),
    GetPage(name: selectRole, page: () => SelectRoleScreen()),
    GetPage(
      name: detailsFeaturedArtists,
      page: () => const DetailsFeaturedArtistsScreen(),
    ),
    GetPage(
      name: detailsTrendingArtists,
      page: () => const DetailsTrendingArtistScreen(),
    ),
    GetPage(name: artistProfile, page: () => const ArtistProfileScreen()),
    GetPage(name: artistAllSongs, page: () => const ArtistAllSongsScreen()),
    GetPage(name: subscribePlan, page: () => const SubscribePlanScreen()),
    GetPage(name: musicPlayer, page: () => const MusicPlayerScreen()),
    GetPage(name: supportArtist, page: () => const SupportArtistScreen()),
    GetPage(name: recentlyPlayed, page: () => const RecentlyPlayedScreen()),
    GetPage(name: songInfo, page: () => const SongInfoScreen()),
    GetPage(name: createPlaylist, page: () => const CreatePlaylistScreen()),
    GetPage(
      name: addSongToPlaylist,
      page: () => const AddSongToPlaylistScreen(),
    ),
    GetPage(name: reviewPlaylist, page: () => const ReviewPlaylistScreen()),
    GetPage(name: playlistCreated, page: () => const PlaylistCreatedScreen()),
    GetPage(name: reportSong, page: () => const ReportSongScreen()),
  ];
}

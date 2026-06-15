import 'package:get/get.dart';

class PlaybackPreferencesController extends GetxController {
  // Reactive states
  final audioQuality = 'High (320 kbps)'.obs;
  final crossfade = '5 seconds'.obs;
  final equalizer = 'Custom'.obs;
  final gaplessPlayback = true.obs;
  final normalizeVolume = true.obs;
  final autoplay = true.obs;
  final restrictedContent = false.obs;

  // Actions
  void setAudioQuality(String value) {
    audioQuality.value = value;
  }

  void setCrossfade(String value) {
    crossfade.value = value;
  }

  void setEqualizer(String value) {
    equalizer.value = value;
  }

  void toggleGaplessPlayback(bool value) {
    gaplessPlayback.value = value;
  }

  void toggleNormalizeVolume(bool value) {
    normalizeVolume.value = value;
  }

  void toggleAutoplay(bool value) {
    autoplay.value = value;
  }

  void toggleRestrictedContent(bool value) {
    restrictedContent.value = value;
  }

  void resetToDefault() {
    audioQuality.value = 'High (320 kbps)';
    crossfade.value = '5 seconds';
    equalizer.value = 'Custom';
    gaplessPlayback.value = true;
    normalizeVolume.value = true;
    autoplay.value = true;
    restrictedContent.value = false;
  }
}

import 'dart:async';
import 'package:get/get.dart';

class MusicPlayerController extends GetxController {
  var playlist = <Map<String, dynamic>>[].obs;
  var currentSongIndex = 0.obs;
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = const Duration(minutes: 3, seconds: 50).obs;
  var isShuffle = false.obs;
  var isRepeat = false.obs;
  var isFavorite = false.obs;
  var isAutoPlay = true.obs;

  Timer? _timer;

  Map<String, dynamic> get currentSong => playlist.isNotEmpty ? playlist[currentSongIndex.value] : {};

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void loadPlaylist(List<Map<String, dynamic>> songs, int index) {
    playlist.assignAll(songs);
    currentSongIndex.value = index;
    _loadCurrentSong();
    play();
  }

  void selectSong(int index) {
    if (playlist.isEmpty) return;
    currentSongIndex.value = index;
    _loadCurrentSong();
    play();
  }

  void _loadCurrentSong() {
    if (playlist.isEmpty) return;
    final song = playlist[currentSongIndex.value];
    
    // Parse duration string like "3:50" or "4:20" to Duration
    final durationStr = song['duration'] ?? "3:50";
    final parts = durationStr.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 3;
      final seconds = int.tryParse(parts[1]) ?? 50;
      totalDuration.value = Duration(minutes: minutes, seconds: seconds);
    } else {
      totalDuration.value = const Duration(minutes: 3, seconds: 50);
    }
    
    currentPosition.value = Duration.zero;
    isFavorite.value = false;
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  void play() {
    isPlaying.value = true;
    _startTimer();
  }

  void pause() {
    isPlaying.value = false;
    _timer?.cancel();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentPosition.value.inSeconds < totalDuration.value.inSeconds) {
        currentPosition.value = Duration(seconds: currentPosition.value.inSeconds + 1);
      } else {
        // Track finished
        if (isRepeat.value) {
          currentPosition.value = Duration.zero;
        } else {
          nextSong();
        }
      }
    });
  }

  void nextSong() {
    if (playlist.isEmpty) return;
    if (isShuffle.value) {
      // Pick random
      final randomIdx = DateTime.now().millisecond % playlist.length;
      currentSongIndex.value = randomIdx;
    } else {
      currentSongIndex.value = (currentSongIndex.value + 1) % playlist.length;
    }
    _loadCurrentSong();
    if (isPlaying.value) {
      _startTimer();
    }
  }

  void previousSong() {
    if (playlist.isEmpty) return;
    currentSongIndex.value = (currentSongIndex.value - 1 + playlist.length) % playlist.length;
    _loadCurrentSong();
    if (isPlaying.value) {
      _startTimer();
    }
  }

  void seek(Duration position) {
    if (position < Duration.zero) {
      currentPosition.value = Duration.zero;
    } else if (position > totalDuration.value) {
      currentPosition.value = totalDuration.value;
    } else {
      currentPosition.value = position;
    }
  }

  void toggleShuffle() {
    isShuffle.value = !isShuffle.value;
  }

  void toggleRepeat() {
    isRepeat.value = !isRepeat.value;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/app_constants.dart';

class MusicProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMusicEnabled = true; // Default: Music is ON

  bool get isMusicEnabled => _isMusicEnabled;

  MusicProvider() {
    _playMusic();
  }

  void toggleMusic(bool value) {
    _isMusicEnabled = value;
    if (_isMusicEnabled) {
      _playMusic();
    } else {
      _stopMusic();
    }
    notifyListeners();
  }

  Future<void> _playMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource(AppConstants.backgroundMusicStorytelling));
  }

  Future<void> _stopMusic() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

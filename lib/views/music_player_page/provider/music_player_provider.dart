import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MusicProvider with ChangeNotifier {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  void initPlayer() {
    audioPlayer.open(Audio.network(
        'https://pagalfree.com/musics/128-Singham%20Again%20Title%20Track%20-%20Singham%20Again%20128%20Kbps.mp3'));
    log('open');
    notifyListeners();
  }

  void playOrPause() {
    log('${audioPlayer.isPlaying.value}');
    if (audioPlayer.isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    notifyListeners();
  }
}

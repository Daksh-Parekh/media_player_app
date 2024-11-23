import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/views/home_page/model/music_model.dart';

class MusicProvider with ChangeNotifier {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  List<Audio> musicList = [
    Audio.network(
        "https://pagalfree.com/musics/128-Singham%20Again%20Title%20Track%20-%20Singham%20Again%20128%20Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Bhool Bhulaiyaa 3 - Title Track (Feat. Pitbull) - Bhool Bhulaiyaa 3 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Pushpa Pushpa - Pushpa 2 The Rule 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Aayi Nai - Stree 2 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Aaj Ki Raat - Stree 2 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Tu Hai Champion - Chandu Champion 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Tauba Tauba - Bad Newz 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Kesariya - Brahmastra 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Saath Hum Rahein - Drishyam 2 128 Kbps.mp3"),
    Audio.network(
        "https://pagalfree.com/musics/128-Satyanaas - Chandu Champion 128 Kbps.mp3"),
  ];

  List<MusicModel> allMusics = [
    MusicModel(
      title: 'Singham',
      image:
          'https://pagalfree.com/images/128Singham%20Again%20Title%20Track%20-%20Singham%20Again%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Bhool Bulaiyaa 3',
      image:
          'https://pagalfree.com/images/128Bhool%20Bhulaiyaa%203%20-%20Title%20Track%20(Feat.%20Pitbull)%20-%20Bhool%20Bhulaiyaa%203%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Pushpa',
      image:
          'https://pagalfree.com/images/128Pushpa%20Pushpa%20-%20Pushpa%202%20The%20Rule%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Aayi Nai',
      image:
          'https://pagalfree.com/images/128Aayi%20Nai%20-%20Stree%202%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Aaj Ki Raat',
      image:
          'https://pagalfree.com/images/128Aaj%20Ki%20Raat%20-%20Stree%202%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Tu Hai Champion',
      image:
          'https://pagalfree.com/images/128Tu%20Hai%20Champion%20-%20Chandu%20Champion%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Tauba Tauba',
      image:
          'https://pagalfree.com/images/128Tauba%20Tauba%20-%20Bad%20Newz%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Kesariya',
      image:
          'https://pagalfree.com/images/128Kesariya%20-%20Brahmastra%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Saath Hum Rahein',
      image:
          'https://pagalfree.com/images/128Saath%20Hum%20Rahein%20-%20Drishyam%202%20128%20Kbps.jpg',
    ),
    MusicModel(
      title: 'Satyanaas',
      image:
          'https://pagalfree.com/images/128Satyanaas%20-%20Chandu%20Champion%20128%20Kbps.jpg',
    ),
  ];

  int index = 0;
  bool isPlay = false;

  Duration liveTime = Duration(seconds: 0);
  Duration totalTime = Duration(seconds: 0);

  void initPlayer() async {
    await audioPlayer.open(Playlist(audios: musicList, startIndex: index),
        autoStart: false);
    log('open');
    totalMusicTime();
    notifyListeners();
  }

  void playOrPause() {
    log('${audioPlayer.isPlaying.value}');
    if (audioPlayer.isPlaying.value) {
      audioPlayer.pause();
      isPlay = false;
    } else {
      audioPlayer.play();
      isPlay = true;
      liveMusicTime();
    }
    notifyListeners();
  }

  void backMusic() {
    audioPlayer.previous();
    // changeImageIndex--;
    index--;
    isPlay = false;
    notifyListeners();
  }

  void forwardMusic() {
    audioPlayer.next();
    playOrPause();
    if (index < 9) {
      index++;
    } else {
      index = 0;
    }
    isPlay = true;
    notifyListeners();
  }

  void totalMusicTime() {
    audioPlayer.current.listen(
      (event) {
        totalTime = event!.audio.duration;
      },
    );
  }

  void liveMusicTime() {
    audioPlayer.currentPosition.listen(
      (event) {
        liveTime = event;
        notifyListeners();
      },
    );
  }

  void seekMusic(Duration value) {
    audioPlayer.seek(value);
    notifyListeners();
  }

  void setIndex(int inx) {
    index = inx;
    notifyListeners();
  }
}

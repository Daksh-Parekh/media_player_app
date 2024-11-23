import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoHomeProvider with ChangeNotifier {
  late VideoPlayerController videoController;

  void initVideo() {
    videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    videoController.initialize();
  }
}

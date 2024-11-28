import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoHomeProvider with ChangeNotifier {
  VideoPlayerController? videoController;
  ChewieController? chewieController;

  Future<void> initVideo() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    await videoController?.initialize();
    log('{path------------------${videoController}}');
    chewieController = ChewieController(
        videoPlayerController: videoController!, autoPlay: true);
    log('-------------patg${chewieController}');
    notifyListeners();
  }
}

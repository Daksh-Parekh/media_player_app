import 'package:flutter/material.dart';
import 'package:media_player_app/utils/extensions.dart';
import 'package:media_player_app/views/home_page/model/music_model.dart';
import 'package:media_player_app/views/music_player_page/provider/music_player_provider.dart';
import 'package:provider/provider.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late MusicProvider mRead, mWatch;
  @override
  void initState() {
    context.read<MusicProvider>().initPlayer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mRead = context.read<MusicProvider>();
    mWatch = context.watch<MusicProvider>();
    Size size = MediaQuery.sizeOf(context);
    // MusicModel model = ModalRoute.of(context)!.settings.arguments as MusicModel;
    MusicModel model = mWatch.allMusics[mWatch.index];
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: Center(
        child: Stack(
          // fit: StackFit.expand,
          alignment: Alignment(0, 0),
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              '${model.image}',
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.74),
              colorBlendMode: BlendMode.darken,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    '${model.image}',
                    height: size.height * 0.38,
                    fit: BoxFit.cover,
                  ),
                ),
                30.h,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${mWatch.liveTime.inMinutes}:${mWatch.liveTime.inSeconds % 60}"),
                      Expanded(
                        child: Slider(
                          value: mWatch.liveTime.inSeconds.toDouble(),
                          onChanged: (value) {
                            mRead.seekMusic(Duration(seconds: value.toInt()));
                          },
                          max: mWatch.totalTime.inSeconds.toDouble(),
                        ),
                      ),
                      Text(
                          "${mWatch.totalTime.inMinutes}:${mWatch.totalTime.inSeconds % 60}"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        mRead.backMusic();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        mRead.playOrPause();
                        // mRead.playOrPause();
                      },
                      icon: mWatch.isPlay
                          ? Icon(Icons.pause_circle_filled_rounded)
                          : Icon(Icons.play_circle_fill_rounded),
                    ),
                    IconButton(
                        onPressed: () {
                          mRead.forwardMusic();
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

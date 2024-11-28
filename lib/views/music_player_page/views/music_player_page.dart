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
          alignment: Alignment(0, 0),
          children: [
            Image.network(
              '${model.image}',
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.8),
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
                20.h,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${model.title}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                10.h,
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
                      icon: Icon(
                        Icons.arrow_left_rounded,
                        size: 100,
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        mRead.playOrPause();
                        // mRead.playOrPause();
                      },
                      icon: mWatch.isPlay
                          ? Icon(
                              Icons.pause_circle_filled_rounded,
                              size: 30,
                            )
                          : Icon(
                              Icons.play_circle_fill_rounded,
                              size: 30,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        mRead.forwardMusic();
                      },
                      icon: Icon(
                        Icons.arrow_right_rounded,
                        size: 100,
                      ),
                    ),
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

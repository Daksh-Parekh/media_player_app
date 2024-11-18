import 'package:flutter/material.dart';
import 'package:media_player_app/utils/extensions.dart';
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
              'https://pagalfree.com/images/128Singham%20Again%20Title%20Track%20-%20Singham%20Again%20128%20Kbps.jpg',
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.88),
              colorBlendMode: BlendMode.darken,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    'https://pagalfree.com/images/128Singham%20Again%20Title%20Track%20-%20Singham%20Again%20128%20Kbps.jpg',
                    height: size.height * 0.38,
                    fit: BoxFit.cover,
                  ),
                ),
                12.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
                    IconButton.filledTonal(
                        onPressed: () {
                          mRead.playOrPause();
                          // mRead.playOrPause();
                        },
                        icon: Icon(Icons.play_circle_fill_rounded)),
                    IconButton(
                        onPressed: () {},
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

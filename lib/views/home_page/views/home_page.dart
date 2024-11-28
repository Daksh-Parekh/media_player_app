import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/utils/extensions.dart';
import 'package:media_player_app/views/home_page/provider/music_home_provider.dart';
import 'package:media_player_app/views/music_player_page/provider/music_player_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MusicProvider hRead, hWatch;
  late VideoHomeProvider hvRead, hvWatch;

  @override
  void initState() {
    context.read<VideoHomeProvider>().initVideo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hRead = context.read<MusicProvider>();
    hWatch = context.watch<MusicProvider>();
    hvRead = context.read<VideoHomeProvider>();
    hvWatch = context.watch<VideoHomeProvider>();

    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.music_note_rounded),
                text: "Music",
              ),
              Tab(
                icon: Icon(Icons.video_collection_rounded),
                text: "Video",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trending Songs",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: hWatch.allMusics.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            hWatch.setIndex(index);
                            Navigator.pushNamed(context, '/music_player',
                                arguments: hRead.allMusics[index]);
                          },
                          minTileHeight: 120,
                          leading: Image.network(
                            '${hWatch.allMusics[index].image}',
                          ),
                          title: Text(
                            "${hWatch.allMusics[index].title}",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "~ ${hWatch.allMusics[index].singer}",
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.end,
                          ),
                        );
                      },
                    ),
                  ),
                  // 250.h,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: hvWatch.chewieController != null
                  ? SizedBox(
                      height: 100,
                      child: Chewie(controller: hvWatch.chewieController!),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

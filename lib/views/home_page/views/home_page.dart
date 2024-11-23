import 'package:flutter/material.dart';
import 'package:media_player_app/views/music_player_page/provider/music_player_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MusicProvider hRead, hWatch;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<MusicProvider>();
    hWatch = context.watch<MusicProvider>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.music_note),
                text: "Music",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: hRead.allMusics.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      hWatch.setIndex(index);
                      Navigator.pushNamed(context, '/music_player',
                          arguments: hRead.allMusics[index]);
                    },
                    minTileHeight: 80,
                    leading: Image.network('${hRead.allMusics[index].image}'),
                    title: Text("${hRead.allMusics[index].title}"),
                  );
                },
              ),
            ),
            Icon(Icons.music_note),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/music_player');
          },
          child: Icon(Icons.music_note_rounded),
        ),
      ),
    );
  }
}

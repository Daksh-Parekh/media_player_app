import 'package:flutter/material.dart';
import 'package:media_player_app/views/home_page/provider/music_home_provider.dart';
import 'package:media_player_app/views/home_page/views/home_page.dart';
import 'package:media_player_app/views/music_player_page/provider/music_player_provider.dart';
import 'package:media_player_app/views/music_player_page/views/music_player_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MusicProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MusicHomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        routes: {
          '/': (context) => HomePage(),
          '/music_player': (context) => MusicPlayer()
        },
      ),
    );
  }
}

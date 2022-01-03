import 'package:anime_list/components/animes_screen.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/screens/anime_list_screen.dart';
import 'package:anime_list/screens/crate_anime_screen.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AnimeList>(
          create: (_) => AnimeList(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.grey[800],
          secondary: Colors.red,
          onPrimary: Colors.red,
          onSecondary: Colors.white,
        )),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (_) => AnimeListScreen(),
          AppRoutes.CREATE_ANIME: (_) => CreateAnimeScreen(),
          AppRoutes.ANIME_LIST: (_) => AnimesScreen(),
        },
      ),
    );
  }
}

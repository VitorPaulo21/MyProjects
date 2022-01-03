import 'package:anime_list/components/animes_screen.dart';
import 'package:anime_list/components/home_screen.dart';
import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:flutter/material.dart';

class HomeScreenScrool extends StatelessWidget {
  const HomeScreenScrool({
    Key? key,
    required int currentIndex,
    required this.animeList,
  })  : _currentIndex = currentIndex,
        super(key: key);

  final int _currentIndex;
  final AnimeList animeList;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // expandedHeight: 150,
          pinned: true,
          floating: true,
          snap: true,
          backgroundColor: Colors.black54,
          flexibleSpace: const FlexibleSpaceBar(
            centerTitle: true,
            title: Text("My Animes"),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("lib/assets/profile.png")),
          ),
          actions: [
            PopupMenuButton<ListTile>(
                icon: Icon(Icons.search),
                itemBuilder: (ctx) => <PopupMenuEntry<ListTile>>[
                      PopupMenuItem<ListTile>(
                          child: ListTile(
                        enabled: true,
                        leading: Container(
                          height: 70,
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        title: Container(
                          height: 70,
                          width: 250,
                          child: TextField(
                            onSubmitted: (text) {
                              //TODO implement the search to go to the animes page
                            },
                            textInputAction: TextInputAction.search,
                            cursorColor: Colors.white,
                            decoration: DecorationWithLabel("Pesquisar Anime"),
                          ),
                        ),
                      ))
                    ])
          ],
        ),
        SliverToBoxAdapter(child: HomeScreen(animeList: animeList)),
      ],
    );
  }
}

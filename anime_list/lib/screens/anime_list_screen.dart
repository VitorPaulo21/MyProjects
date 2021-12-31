import 'package:anime_list/components/animes_list_view.dart';
import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/components/random_indication.dart';
import 'package:anime_list/components/titled_row_list.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({Key? key}) : super(key: key);

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    AnimeList animeList = Provider.of<AnimeList>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.CREATE_ANIME);
        },
      ),
      body: CustomScrollView(
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
                              decoration:
                                  DecorationWithLabel("Pesquisar Anime"),
                            ),
                          ),
                        ))
                      ])
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const RandomIndication(),
                const SizedBox(
                  height: 5,
                ),
                if (animeList.animeList.length > 0)
                  TitledRowList(
                    title: "Minha Lista",
                    hasArrow: true,
                    listTipe: ListTipe.ALL,
                    onTap: () {},
                  ),
                if (animeList.watchingAnimes.length > 0)
                  TitledRowList(
                    title: "Continue Assistino",
                    hasArrow: true,
                    listTipe: ListTipe.WATCHING,
                    onTap: () {},
                  ),
                if (animeList.prioAnimes.length > 0)
                  TitledRowList(
                    title: "Lista de Prioridades",
                    hasArrow: true,
                    listTipe: ListTipe.PRIO,
                    onTap: () {},
                  ),
                if (animeList.normalAnimes.length > 0)
                  TitledRowList(
                    title: "Lista sem Prioridades",
                    hasArrow: true,
                    listTipe: ListTipe.NORMAL,
                    onTap: () {},
                  ),
                if (animeList.concluidolAnimes.length > 0)
                  TitledRowList(
                    title: "Lista de Assistidos",
                    hasArrow: true,
                    listTipe: ListTipe.FINISHED,
                    onTap: () {},
                  ),
                if (!(animeList.animeList.length > 0))
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "lib/assets/luffy_like.png",
                          height: 270,
                          fit: BoxFit.fitHeight,
                        ),
                        const FittedBox(
                          child: Text(
                            "Parece que ainda nao temos nada cadastrado!",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                side:
                                    BorderSide(width: 2, color: Colors.white)),
                            onPressed: () {
                              //TODO implementar cadastro de anime
                            },
                            child: const Text(
                              "Que tal cadastrar algo?",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.grey[900],
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Animes",
          ),
        ],
      ),
    );
  }
}

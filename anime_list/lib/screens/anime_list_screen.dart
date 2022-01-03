import 'package:anime_list/components/animes_list_view.dart';
import 'package:anime_list/components/animes_screen.dart';
import 'package:anime_list/components/home_screen.dart';
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

import 'home-screen-scroll.dart';

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
     
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
        
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AppRoutes.CREATE_ANIME);
        },
      ) : null,
      body: _currentIndex == 0 ? HomeScreenScrool(currentIndex: _currentIndex, animeList: animeList) :
      AnimesScreen(),
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





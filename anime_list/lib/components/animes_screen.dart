import 'package:anime_list/components/row_anime_list_item.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimesScreen extends StatefulWidget {
  const AnimesScreen({Key? key}) : super(key: key);

  @override
  _AnimesScreenState createState() => _AnimesScreenState();
}

class _AnimesScreenState extends State<AnimesScreen> {
  List<Anime> animes = [];
  @override
  Widget build(BuildContext context) {
    AnimeList animeList = Provider.of<AnimeList>(context);
    animes = animeList.getListWithFilters();

    return GridView.builder(
        itemCount: animes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            crossAxisCount: 3),
        itemBuilder: (ctx, index) {
          // return RowAnimeListItem(animes[index]);
          return Container(
            child: RowAnimeListItem(animes[index]),
          );
        });
  }
}

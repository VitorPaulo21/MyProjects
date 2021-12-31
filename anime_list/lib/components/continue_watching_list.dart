import 'package:anime_list/components/continue_watching_list_item.dart';
import 'package:anime_list/models/anime.dart';
import 'package:flutter/material.dart';

class ContinueWatchingList extends StatelessWidget {
  final List<Anime> animeList;
  const ContinueWatchingList(this.animeList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    animeList.shuffle();
    return Container(
      height: 235,
      width: double.infinity,
      child: ListView.builder(
        
        scrollDirection: Axis.horizontal,
        itemCount: animeList.length < 10 ? animeList.length : 10,
        itemBuilder: (ctx, index) => 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ContinueWatchingListItem(animeList[index]),
      )),
    );
  }
}

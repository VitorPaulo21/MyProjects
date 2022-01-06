import 'dart:math';

import 'package:anime_list/components/row_anime_list_item.dart';
import 'package:anime_list/models/anime.dart';
import 'package:flutter/material.dart';

class rowAnimeList extends StatelessWidget {
  final List<Anime> animeList;
  const rowAnimeList(this.animeList, { Key? key }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    animeList.shuffle();
    return Container(
      height:180,
      child: ListView.builder(
        itemCount: animeList.length < 10 ? animeList.length : 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, Index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RowAnimeListItem(animeList[Index]),
        );
      }),
    );
  }
}
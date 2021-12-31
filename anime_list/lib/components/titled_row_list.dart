import 'package:anime_list/components/continue_watching_list.dart';
import 'package:anime_list/components/row_anime_list.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitledRowList extends StatelessWidget {
  final String title;
  final bool hasArrow;
  final ListTipe listTipe;
  final void Function()? onTap;
  const TitledRowList({ Key? key,
  required this.title,
  this.hasArrow = false,
  this.listTipe = ListTipe.ALL,
  this.onTap
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final List<Anime> animeList;
    if (listTipe == ListTipe.ALL) {
      animeList = Provider.of<AnimeList>(context, listen: false).animeList;
    } else if (listTipe == ListTipe.NORMAL) {
      animeList = Provider.of<AnimeList>(context, listen: false).normalAnimes;
    } else if (listTipe == ListTipe.FINISHED) {
      animeList = Provider.of<AnimeList>(context, listen: false).concluidolAnimes;
    } else if (listTipe == ListTipe.PRIO) {
      animeList = Provider.of<AnimeList>(context, listen: false).prioAnimes;
    } else if (listTipe == ListTipe.WATCHING) {
      animeList = Provider.of<AnimeList>(context, listen: false).watchingAnimes;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(
          padding: const EdgeInsets.only(top: 15, right: 10, left: 10,),
          child: InkWell(
            //TODO implementar o clique para ir para a lista completa
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                hasArrow 
                ? IconButton(onPressed: onTap, icon: const Icon(Icons.arrow_forward,),) 
                : const SizedBox(),
              ],
            ),
          ),
        ),
        listTipe == ListTipe.WATCHING? ContinueWatchingList(animeList) : rowAnimeList(animeList)
    ],);
  }
}
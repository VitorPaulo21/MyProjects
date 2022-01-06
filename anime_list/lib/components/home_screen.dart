import 'package:anime_list/components/random_indication.dart';
import 'package:anime_list/components/titled_row_list.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'not_find_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    AnimeList animeList = Provider.of<AnimeList>(context);
    return Column(
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
          NotFindScreen(),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }
}


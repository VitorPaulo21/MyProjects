import 'package:anime_list/components/random_indication.dart';
import 'package:anime_list/components/titled_row_list.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.animeList,
  }) : super(key: key);

  final AnimeList animeList;

  @override
  Widget build(BuildContext context) {
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
                        side: BorderSide(width: 2, color: Colors.white)),
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
    );
  }
}

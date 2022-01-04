import 'package:anime_list/components/anime_list_grid_item.dart';
import 'package:anime_list/components/row_anime_list_item.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoBotomSheet extends StatefulWidget {
  final Anime anime;
  const InfoBotomSheet(this.anime, {Key? key}) : super(key: key);

  @override
  _InfoBotomSheetState createState() => _InfoBotomSheetState();
}

class _InfoBotomSheetState extends State<InfoBotomSheet> {
  @override
  Widget build(BuildContext context) {
    AnimeList animeList = Provider.of<AnimeList>(context);
    Anime anime = widget.anime;
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 90,
                child: AnimeListGridItem(anime),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 145,
                          child: Text(
                            anime.title,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(Icons.cancel))
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 118,
                      child: Text(
                        anime.description,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      animeList.changeWacth(anime);
                    });
                  },
                  child: Row(
                    children: [
                      const Spacer(),
                      Icon(
                        anime.watching ? Icons.check : Icons.play_arrow,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        anime.watching ? "Finalizar" : "Assistir",
                        style: TextStyle(color: Colors.black),
                      ),
                      const Spacer(),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  animeList.changePrio(anime);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(anime.isPrio ? Icons.check : Icons.add),
                      Text("Prioridade")
                    ],
                  ),
                ),
              ))
            ],
          ),
          Divider(
            color: Colors.grey[350],
          ),
          InkWell(
            onTap: () {
              //TODO implementar click para informação completa do anime
            },
            child: Row(
              children: const [
                Icon(Icons.info_outline),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Informações",
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

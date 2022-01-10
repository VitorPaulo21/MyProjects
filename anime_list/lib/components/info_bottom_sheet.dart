import 'package:anime_list/components/anime_list_grid_item.dart';
import 'package:anime_list/components/finish_anime_dialog.dart';
import 'package:anime_list/components/reestart_watching_dialog.dart';
import 'package:anime_list/components/row_anime_list_item.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/copy_to_clipboard.dart';
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
                child: SingleChildScrollView(
                  child: Column(
                    
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: ()  {
                              Navigator.of(context).pop();
                              copyToClipBoard(context, anime.title);
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 165,
                              child: Text(
                                anime.title,
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                                copyToClipBoard(context, anime.title);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 4),
                              child: const Icon(Icons.copy, size: 18,))),
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
                    
                      if (anime.watched) {
                        
                        showDialog(context: context, builder: (ctx) {
                          return ReestartWatching();
                        },).then((value) {
                        bool result = value ?? false;
                        if (result) {
                          setState(() {
                            
                         animeList.changeWacth(anime);
                          });
                        }
                        } 
                        );
                      } else if (anime.watching) {
                        showDialog(context: context, builder: (ctx) {
                          return FinishAnimeDialog();
                        }).then((value) {
                        bool result = value ?? false;
                        if (result) {
                          setState(() {
                            animeList.changeFinalized(anime);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.HOME);
                          });
                        }
                      });
                      } else {
                        setState(() {
                        animeList.changeWacth(anime);
                      });
                      }
                      
                    
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      InkWell(
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
              ),
              InkWell(
                    onTap: () {
                      //TODO implement share here
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.share_outlined,
                            size: 23,
                          ),
                          Text("Compartilhar")
                        ],
                      ),
                    ),
                  ),
                    ],
                  ))
            ],
          ),
          Divider(
            color: Colors.grey[350],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  AppRoutes.ANIME_DETAILS,
                  arguments: anime);
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

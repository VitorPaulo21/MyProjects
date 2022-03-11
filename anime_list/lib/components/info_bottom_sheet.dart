

import 'package:anime_list/components/anime_list_grid_item.dart';
import 'package:anime_list/components/finish_anime_dialog.dart';
import 'package:anime_list/components/reestart_watching_dialog.dart';
import 'package:anime_list/components/row_anime_list_item.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/copy_to_clipboard.dart';
import 'package:anime_list/utils/methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    bool isSelfUser = Methods.isSelfUser(anime);
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 120,
                  width: 90,
                  child: AnimeListGridItem(
                    anime,
                    actvateClick: false,
                  ),
                ),
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
                    if (!isSelfUser) {
                      Methods.addAnimeToListDialog(context, anime);
                      return;
                    } else if (anime.watched) {
                        
                        showDialog(context: context, builder: (ctx) {
                          return ReestartWatching();
                        },).then((value) {
                        bool result = value ?? false;
                        if (result) {
                          setState(() {
                            
                            animeList.changeWacth(anime, context);
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
                            animeList.changeFinalized(anime, context);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.HOME);
                          });
                        }
                      });
                      } else {
                        setState(() {
                        animeList.changeWacth(anime, context);
                      });
                      }
                      
                    
                  },
                  child: Row(
                    children: [
                      const Spacer(),
                      Icon(
                        isSelfUser
                            ? anime.watching
                                ? Icons.check
                                : Icons.play_arrow
                            : Icons.add,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        isSelfUser
                            ? anime.watching
                                ? "Finalizar"
                                : "Assistir"
                            : "Adicionar",
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
                      
                  if (isSelfUser)
                    InkWell(
                onTap: () {
                      animeList.changePrio(anime, context);
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

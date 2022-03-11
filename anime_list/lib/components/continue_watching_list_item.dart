import 'package:anime_list/components/finish_anime_dialog.dart';
import 'package:anime_list/components/info_bottom_sheet.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContinueWatchingListItem extends StatelessWidget {
  final Anime anime;
  const ContinueWatchingListItem(this.anime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isSelfUser = Methods.isSelfUser(anime);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: anime.imageUrl,
                  fit: BoxFit.cover,
                  height: 170,
                  width: 125,
                  errorWidget: (ctx, txt, _) => Image.asset(
                    "lib/assets/PikPng.com_luffy-png_1127171.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      )),
                  child: const Icon(
                    Icons.check,
                    size: 40,
                  ),
                ),
                Consumer<AnimeList>(
                  builder: (ctx, animeList, _) => Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (!isSelfUser) {
                          Methods.addAnimeToListDialog(context, anime);
                        } else {

                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return FinishAnimeDialog();
                            }).then((value) {
                          bool result = value ?? false;
                          if (result) {
                            animeList.changeFinalized(anime, context);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.HOME);
                          }
                        });
                        }
                      },
                      child: const SizedBox(
                        height: 170,
                        width: 125,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Colors.black,
            ),
            width: 125,
            height: 45,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          context: context,
                          builder: (ctx) => InfoBotomSheet(anime));
                    },
                    icon: const Icon(Icons.info_outline)),
                const Spacer(),
                Consumer<AnimeList>(
                  builder: (ctx, animeList, _) => PopupMenuButton<int>(
                    onSelected: (index) {
                      if (index == 1) {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return FinishAnimeDialog();
                            }).then((value) {
                          bool result = value ?? false;
                          if (result) {
                            animeList.changeFinalized(anime, context);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.HOME);
                          }
                        });
                      } else if (index == 2) {
                        //TODO implement share
                      } else if (index == 3) {
                        showDialog<bool>(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text("Tem certeza?"),
                                content: const Text(
                                    "Deseja mesmo remover este anime da lista?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text(
                                      "sim",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text(
                                      "não",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              );
                            }).then((value) {
                          bool delete = value ?? false;

                          if (delete) {
                            animeList.deleteAnime(anime, context);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.HOME);
                          }
                        });
                      } else if (index == 0) {
                        Methods.addAnimeToListDialog(context, anime);
                      }
                    },
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (ctx) => [
                      if (!isSelfUser)
                        PopupMenuItem(
                            value: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Adicionar",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      if (isSelfUser)
                      PopupMenuItem(
                          value: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Finalizar",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                      PopupMenuItem(
                        value: 2,
                        //TODO implement share button
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Compartilhar",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      if (isSelfUser)
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Deletar",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

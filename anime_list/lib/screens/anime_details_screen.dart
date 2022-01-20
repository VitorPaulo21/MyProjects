import 'package:anime_list/components/finish_anime_dialog.dart';
import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/components/labeled_changeble_button.dart';
import 'package:anime_list/components/reestart_watching_dialog.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/copy_to_clipboard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AnimeDetailsScreen extends StatelessWidget {
  const AnimeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimeList animeList = Provider.of<AnimeList>(context);
    Anime anime = ModalRoute.of(context)?.settings.arguments as Anime;
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalhes do Anime"),
          centerTitle: true,
          actions: [
            PopupMenuButton<ListTile>(
                icon: Icon(Icons.search),
                itemBuilder: (ctx) => <PopupMenuEntry<ListTile>>[
                      PopupMenuItem<ListTile>(
                          child: ListTile(
                        enabled: true,
                        leading: Container(
                          height: 70,
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        title: Container(
                          height: 70,
                          width: 250,
                          child: TextField(
                            onSubmitted: (text) {
                              Navigator.of(context).pushReplacementNamed(
                                  AppRoutes.ANIME_LIST,
                                  arguments: {"query": text});
                            },
                            textInputAction: TextInputAction.search,
                            cursorColor: Colors.white,
                            decoration: DecorationWithLabel("Pesquisar Anime"),
                          ),
                        ),
                      ))
                    ])
          ],
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              LabeledChangebleButton(actualAnime: anime),
              const SizedBox(
                width: 10,
              ),
              LabeledChangebleButton(
                //Implementar Share button
                actualAnime: anime,
                icon: Icons.share_outlined,
                label: "Compartilhar",
                size: 30,
                function: labeledButtonFunctions.share,
              ),
              Spacer(),
              LabeledChangebleButton(
                label: "Remover",
                actualAnime: anime,
                color: Colors.red,
                icon: Icons.delete_outline,
                function: labeledButtonFunctions.delete,
              )
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (ctx, constraints) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                anime.imageUrl.isEmpty
                    ? Image.asset(
                        "lib/assets/PikPng.com_luffy-png_1127171.png",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: anime.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    copyToClipBoard(context, anime.title);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Container(
                          width: constraints.maxWidth * 0.85,
                          child: Text(
                            anime.title,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.copy),
                      )
                    ],
                  ),
                ),
                if (anime.watched)
                  Column(
                    children: const [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Assistido",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                if (anime.isPrio)
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            alignment: Alignment.center,
                            padding: EdgeInsetsDirectional.all(2),
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              "Prio",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text(
                            "Prioridade",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (anime.watched) {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return ReestartWatching();
                            },
                          ).then((value) {
                            bool result = value ?? false;
                            if (result) {
                              animeList.changeWacth(anime);
                            }
                          });
                        } else if (anime.watching) {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return FinishAnimeDialog();
                              }).then((value) {
                            bool result = value ?? false;
                            if (result) {
                              animeList.changeFinalized(anime);
                            }
                          });
                        } else {
                          animeList.changeWacth(anime);
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: Row(
                        children: [
                          const Spacer(),
                          Icon(
                            anime.watching ? Icons.check : Icons.play_arrow,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            anime.watching ? "Finalizar" : "Assistir",
                            style: const TextStyle(color: Colors.black),
                          ),
                          const Spacer()
                        ],
                      )),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.CREATE_ANIME,
                            arguments: anime);
                      },
                      style:
                          ElevatedButton.styleFrom(primary: Colors.grey[800]),
                      child: Row(
                        children: const [
                          Spacer(),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Editar",
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer()
                        ],
                      )),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  " ${anime.genero.fold("Genero: ", (previousValue, element) {
                        return previousValue.toString() + "," + element;
                      }).toString().replaceFirst(",", "")}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  child: Text("Desc: ${anime.description}"),
                ),
              ],

              //TODO implementar importar imagem da galeria
            ),
          ),
        ));
  }
}

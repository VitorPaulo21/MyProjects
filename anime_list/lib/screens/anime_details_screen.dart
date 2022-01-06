import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/components/labeled_changeble_button.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: anime.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              anime.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (anime.watched)
              const SizedBox(
                height: 5,
              ),
            const Text(
              "Assistido",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
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
                    animeList.changeWacth(anime);
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
                    Navigator.of(context)
                        .pushNamed(AppRoutes.CREATE_ANIME, arguments: anime);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.grey[800]),
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
              height: 10,
            ),
            Container(
                height: 100,
                width: double.infinity,
                child: Text(anime.description)),
            LabeledChangebleButton(actualAnime: anime)
          ],
          //TODO dar um jeito de manter o botao sempre em baixo e verificar se textos grandes aplicam rolagem
        ),
      ),
    );
  }
}

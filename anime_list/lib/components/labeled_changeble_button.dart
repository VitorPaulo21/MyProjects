import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabeledChangebleButton extends StatelessWidget {
  const LabeledChangebleButton({
    Key? key,
    required this.actualAnime,
  }) : super(key: key);

  final Anime actualAnime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AnimeList>(
        builder: (ctx, animeList, _) => Container(
          child: InkWell(
            highlightColor: Colors.white,
            onTap: () => animeList.changePriority(actualAnime),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  actualAnime.isPrio ? Icons.check : Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                const Text(
                  "Prioridade",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

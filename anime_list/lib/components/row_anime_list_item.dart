import 'package:anime_list/models/anime.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RowAnimeListItem extends StatelessWidget {
  final Anime anime;
  const RowAnimeListItem(this.anime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: anime.imageUrl,
            height: 180,
            width: 115,
            fit: BoxFit.cover,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                //TODO implementar o clique para ir nos detalhes do anime
              },
              child: const SizedBox(
                height: 180,
                width: 115,
              ),
            ),
          ),
          if (anime.isPrio && !anime.watched)
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                      ),
                      color: Colors.red[600]),
                  height: 30,
                  width: 21,
                  child: const FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Text(
                        "Prio",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )),
          if (anime.watched && !anime.watching)
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                      ),
                      color: Colors.green[600]),
                  height: 30,
                  width: 21,
                  child: const FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(Icons.check),
                    ),
                  ),
                )),
          if (anime.watching)
            Positioned(
              width: 115,
              bottom: 0,
              child: Container(
                width: 115,
                color: Colors.black54,
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    "Assistindo",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

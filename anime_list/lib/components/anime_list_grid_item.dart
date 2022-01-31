import 'package:anime_list/components/info_bottom_sheet.dart';
import 'package:anime_list/models/anime.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeListGridItem extends StatelessWidget {
  final Anime anime;
  const AnimeListGridItem(this.anime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Stack(
          children: [
            CachedNetworkImage(
              imageUrl: anime.imageUrl,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.cover,
              errorWidget: (ctx, txt, _) => Image.asset(
                "lib/assets/PikPng.com_luffy-png_1127171.png",
                fit: BoxFit.cover,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      context: context,
                      builder: (ctx) => InfoBotomSheet(anime));
                },
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
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
                width: constraints.maxWidth,
                bottom: 0,
                child: Container(
                  width: constraints.maxWidth,
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
      ),
    );
  }
}

import 'package:anime_list/components/info_bottom_sheet.dart';
import 'package:anime_list/models/anime.dart';
import 'package:flutter/material.dart';

class ContinueWatchingListItem extends StatelessWidget {
  final Anime anime;
  const ContinueWatchingListItem(this.anime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  anime.imageUrl,
                  fit: BoxFit.cover,
                  height: 170,
                  width: 125,
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      //TODO implement to go to the anime info
                    },
                    child: const SizedBox(
                      height: 170,
                      width: 125,
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
                          context: context,
                          builder: (ctx) => InfoBotomSheet(anime));
                    },
                    icon: const Icon(Icons.info_outline)),
                const Spacer(),
                PopupMenuButton(
                  //TODO implement delete button
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                        //TODO implement finalizar button
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
                    PopupMenuItem(
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
                    )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

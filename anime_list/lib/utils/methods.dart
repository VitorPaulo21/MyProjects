import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../providers/anime_list.dart';

class Methods {
  static void addAnimeToListDialog(BuildContext context, Anime anime) {
    bool containsInLIst =
        Provider.of<AnimeList>(context, listen: false).animeList.any(
              (element) =>
                  element.title == anime.title &&
                  element.genero.toString() == anime.genero.toString() &&
                  element.imageUrl == anime.imageUrl &&
                  element.description == anime.description,
            );
    showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Adicionar"),
            content: Text(containsInLIst
                ? "Voce Ja possui este anime em sua lista"
                : "Deseja adicionar este anime a sua lista?"),
            actions: [
              if (!containsInLIst)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Sim",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              if (!containsInLIst)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Não",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              if (containsInLIst)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
            ],
          );
        }).then((value) {
      if (value ?? false) {
        Provider.of<AnimeList>(context, listen: false)
            .addAnime(anime.getMap()..["id"] = "", context);
      }
    });
  }

  static bool isSelfUser(Anime anime) {
    String acessingUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
    return anime.userId == acessingUserId;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/user_profile.dart';
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

  static Future<bool?> addFriendDialog(
      UserProfile profile, BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Adicionar ${profile.name} como Amigo?"),
            content: const Text(
                "Voces poderao ver a Lista de Animes um do outro e enviar mensagens"),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(ctx, rootNavigator: true).pop(true),
                child: Text(
                  "Sim",
                  style: TextStyle(color: Theme.of(ctx).colorScheme.secondary),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(ctx, rootNavigator: true).pop(false),
                child: Text(
                  "Não",
                  style: TextStyle(color: Theme.of(ctx).colorScheme.secondary),
                ),
              ),
            ],
          );
        });
  }

  static Future<bool?> removeFriendDialog(
      UserProfile user, BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Remover ${user.name} como Amigo?"),
            content: const Text("Voces não verao mais informaões um do outro"),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(true),
                child: Text(
                  "Sim",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(false),
                child: Text(
                  "Não",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          );
        });
  }
}

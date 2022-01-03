import 'dart:math';

import 'package:anime_list/data/dummy_data.dart';
import 'package:anime_list/models/anime.dart';
import 'package:flutter/cupertino.dart';

class AnimeList with ChangeNotifier {
  List<Anime> _animeList = data().DUMMY_ANIMES;

  void changePriority(Anime anime) {
    _animeList.lastWhere((oldElement) => oldElement == anime).isPrio =
        !anime.isPrio;
    notifyListeners();
  }

  void addAnime(Map<String, Object> anime) {
    print(anime["title"].toString());
    Anime newAnime = Anime(
      id: anime.containsKey("id")
          ? anime["id"].toString()
          : Random().nextDouble().toString(),
      title: anime["title"].toString(),
      genero: anime["genders"] as List<String>,
      description: anime.containsKey("desc") ? anime["desc"].toString() : "",
      isPrio: anime.containsKey("isPrio") ? anime["isPrio"] as bool : false,
    );
    if (anime.containsKey("imgUrl")) {
      newAnime.setImageUrl(anime["imgUrl"].toString());
    }
    _animeList.add(newAnime);
    notifyListeners();
  }

  List<Anime> get animeList {
    return [..._animeList];
  }

  List<Anime> get normalAnimes {
    return _animeList
        .where((anime) =>
            anime.watching && !anime.isPrio || !anime.watched && !anime.isPrio)
        .toList();
  }

  List<Anime> get watchingAnimes {
    return _animeList
        .where((anime) => anime.watching && !anime.watched)
        .toList();
  }

  List<Anime> get concluidolAnimes {
    return _animeList
        .where((anime) => anime.watched && !anime.watching)
        .toList();
  }

  List<Anime> get prioAnimes {
    return _animeList.where((anime) => anime.isPrio && !anime.watched).toList();
  }

  List<Anime> getListWithFilters({
    bool watching = true,
    bool prio = true,
    bool normal = true,
    bool watched = true,
  }) {
    List<Anime> result = [];

    if (watching) {
      result.addAll(watchingAnimes);
    }
    if (prio) {
      if (watching) {
        result.addAll(prioAnimes.where((element) =>
            !result.contains(element) && !concluidolAnimes.contains(element)));
      } else {
        result.addAll(prioAnimes);
      }
    }

    if (normal) {
      if (watching || prio) {
        result.addAll(normalAnimes.where((element) =>
            !result.contains(element) && !concluidolAnimes.contains(element)));
      } else {
        result.addAll(normalAnimes);
      }
    }

    if (watched) {
      result.addAll(concluidolAnimes);
    }

    return result;
  }
}

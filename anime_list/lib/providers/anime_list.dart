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

  List<Anime> get animeList {
    return [..._animeList];
  }

  List<Anime> get normalAnimes {
    return _animeList
        .where((anime) => anime.watching || !anime.watched && !anime.isPrio)
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
}

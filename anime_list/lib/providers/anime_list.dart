import 'dart:collection';
import 'dart:convert';

import 'dart:math';

import 'package:anime_list/models/anime.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';



class AnimeList with ChangeNotifier {
  List<Anime> _animeList = [];
  List<Anime> randomAnimes = [];
  String baseUrl = "https://stormapp-80b5f.firebaseio.com";
  String connectUrl = "/Animes.json";
  final BuildContext _context;
  AnimeList(BuildContext context) : _context = context{
    getAnimes();
  }
  Future<List<Anime>> getAnimes() async {
    await get(Uri.parse(baseUrl + connectUrl)).then((value) {
      final loadedData = jsonDecode(
        value.body,
      ) as Map<String, dynamic>;
      loadedData.forEach((key, value) {
        Map<String, dynamic> entry =
            (value as LinkedHashMap<String, dynamic>).cast();
        _animeList.add(Anime(
          id: entry["id"].runtimeType == Null ? "" : entry["id"],
          genero: (entry["genero"] as List<dynamic>).cast<String>(),
          title: entry["title"].runtimeType == Null ? "" : entry["title"],
          description: entry["description"].runtimeType == Null
              ? ""
              : entry["description"],
          imageUrl:
              entry["imageUrl"].runtimeType == Null ? "" : entry["imageUrl"],
          isPrio: entry["isPrio"],
          watched: entry["watched"],
          watching: entry["watching"],
        ));
      });
    });
    getRandomAnimes();
    notifyListeners();

    return _animeList;
  }

  void getRandomAnimes() {
    randomAnimes.clear();
    List<Anime> animeList =
        _animeList.where((anime) => !anime.watched).toList();
    animeList.shuffle();
    if (animeList.length >= 3) {
      randomAnimes = [animeList[0], animeList[1], animeList[2]];
    } else if (animeList.length > 0) {
      for (int i = 0; i < animeList.length; i++) {
        randomAnimes.add(animeList[i]);
      }
    } else {
      randomAnimes = [];
    }
  }

  void changeFinalized(Anime anime) {
    Anime animeFinal =
        _animeList.lastWhere((oldElement) => oldElement == anime);
    animeFinal.watching = false;
    animeFinal.watched = true;
    patch(Uri.parse("$baseUrl/Animes/${animeFinal.id}.json"),
        body: jsonEncode({
          "watched": animeFinal.watched,
          "watching": animeFinal.watching,
        }));
    notifyListeners();
  }

  void addAnime(Map<String, Object> anime) {
    if (anime.containsKey("id")) {
      updateAnime(anime);
      return;
    }
    Anime newAnime = mapToAnime(anime);
    post(Uri.parse(baseUrl + connectUrl),
        body: jsonEncode({
          "id": newAnime.id,
          "title": newAnime.title,
          "description": newAnime.description,
          "genero": newAnime.genero,
          "imageUrl": newAnime.imageUrl,
          "watched": newAnime.watched,
          "watching": newAnime.watching,
          "isPrio": newAnime.isPrio,
        })).then((response) {
      String id = jsonDecode(response.body)["name"];
      patch(Uri.parse("$baseUrl/Animes/$id.json"),
          body: jsonEncode({"id": id}));
    });
    _animeList.add(newAnime);
    notifyListeners();
  }

  Anime mapToAnime(Map<String, Object> anime) {
    Anime newAnime = Anime(
      id: anime.containsKey("id")
          ? anime["id"].toString()
          : Random().nextDouble().toString(),
      title: anime["title"].toString(),
      genero: anime["genders"] as List<String>,
      description: anime.containsKey("desc") ? anime["desc"].toString() : "",
      isPrio: anime.containsKey("prio") ? anime["prio"] as bool : false,
    );
    if (anime.containsKey("imgUrl")) {
      newAnime.setImageUrl(anime["imgUrl"].toString());
    }
    return newAnime;
  }

  void updateAnime(Map<String, Object> anime) {
    if (findAnimeById(anime["id"].toString()) != null) {
      Anime animeUpdate = findAnimeById(anime["id"].toString())!;

      animeUpdate.title = anime["title"].toString();
      animeUpdate.genero = anime["genders"] as List<String>;
      if (anime.containsKey("imgUrl")) {
        animeUpdate.imageUrl = anime["imgUrl"].toString();
      }
      if (anime.containsKey("desc")) {
        animeUpdate.description = anime["desc"].toString();
      }
      if (anime.containsKey("prio")) {
        animeUpdate.isPrio = anime["prio"] as bool;
      }
      if (anime.containsKey("watched")) {
        animeUpdate.watched = anime["watched"] as bool;
      }
      if (anime.containsKey("watching")) {
        animeUpdate.watching = anime["watching"] as bool;
      }
      animeList.insert(
          animeList.indexOf(findAnimeById(anime["id"].toString())!),
          animeUpdate);
      put(Uri.parse("$baseUrl/Animes/${animeUpdate.id}.json"),
          body: jsonEncode(animeUpdate.getMap()));
      notifyListeners();
    }
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

  void changeWacth(Anime anime) {
    Anime updatedAnime = findFirst(anime);
    updatedAnime.watching = !updatedAnime.watching;
    updatedAnime.watched = false;
    patch(Uri.parse("$baseUrl/Animes/${updatedAnime.id}.json"),
        body: jsonEncode({
          "watched": updatedAnime.watched,
          "watching": updatedAnime.watching,
        }));
    notifyListeners();
  }

  void changePrio(Anime anime) {
    Anime updatedAnime = findFirst(anime);
    updatedAnime.isPrio = !updatedAnime.isPrio;
    patch(
      Uri.parse("$baseUrl/Animes/${updatedAnime.id}.json"),
      body: jsonEncode(
        {
          "isPrio": updatedAnime.isPrio,
        },
      ),
    );
    notifyListeners();
  }

  Anime findFirst(Anime anime) {
    return _animeList.firstWhere((element) => element.id == anime.id);
  }

  Anime? findAnimeById(String id) {
    return _animeList.firstWhere((element) => element.id == id, orElse: null);
  }

  void deleteAnime(Anime anime, BuildContext context) {
    String id = "";
    _animeList.removeWhere((element) {
      id = element.id;
      return element == anime;
    });
   
    delete(
      Uri.parse("$baseUrl/Animes/${anime.id}.json"),
    );
    notifyListeners();
  }

  List<Anime> getListWithFilters(
      {bool watching = true,
      bool prio = true,
      bool normal = true,
      bool watched = true,
      ListTipe? listTipe}) {
    if (listTipe != null) {
      if (listTipe == ListTipe.ALL) {
        watching = true;
        prio = true;
        normal = true;
        watched = true;
      } else if (listTipe == ListTipe.WATCHING) {
        watching = true;
        prio = false;
        normal = false;
        watched = false;
      } else if (listTipe == ListTipe.PRIO) {
        watching = false;
        prio = true;
        normal = false;
        watched = false;
      } else if (listTipe == ListTipe.NORMAL) {
        watching = false;
        prio = false;
        normal = true;
        watched = false;
      } else if (listTipe == ListTipe.FINISHED) {
        watching = false;
        prio = false;
        normal = false;
        watched = true;
      }
    }
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

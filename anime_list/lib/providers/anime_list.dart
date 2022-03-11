import 'dart:collection';
import 'dart:convert';

import 'dart:math';

import 'package:anime_list/components/show_text_snackbar.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/check_connection.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AnimeList with ChangeNotifier {
  List<Anime> _animeList = [];
  List<Anime> randomAnimes = [];
  String baseUrl = "https://stormapp-80b5f.firebaseio.com";
  String connectUrl = "/Animes";
  final BuildContext _context;
  bool isLoaded = false;
  AnimeList(BuildContext context,{List<Anime>? userList}) : _context = context {
    if (userList == null) {
    getAnimes(context);
      
    } else {
      _animeList = userList;
    }
  }

  //CRUD
  Future<List<Anime>> getAnimes(BuildContext context) async {
    
    _animeList.clear();
    isLoaded = false;
    try {
      await get(Uri.parse(
              "$baseUrl$connectUrl/$userID.json?auth=${await getToken()}"))
          .then((value) {
        dynamic decoded = jsonDecode(
          value.body,
        );
        final loadedData =
            decoded.runtimeType == Null ? {} : decoded as Map<String, dynamic>;
        loadedData.forEach((key, value) {
          Map<String, dynamic> entry =
              (value as LinkedHashMap<String, dynamic>).cast();
          _animeList.add(Anime(
            id: entry["id"].runtimeType == Null ? "" : entry["id"],
            genero: entry["genero"].runtimeType == Null
                ? []
                : (entry["genero"] as List<dynamic>).cast<String>(),
            title: entry["title"].runtimeType == Null ? "" : entry["title"],
            description: entry["description"].runtimeType == Null
                ? ""
                : entry["description"],
            imageUrl:
                entry["imageUrl"].runtimeType == Null ? "" : entry["imageUrl"],
            isPrio: entry["isPrio"],
            watched: entry["watched"],
            watching: entry["watching"],
              userId: entry["userId"]
          ));
        });
      });
    } catch (_) {
      
    }

    getRandomAnimes();
    isLoaded = true;
    notifyListeners();
    return _animeList;
  }

  void changeFinalized(Anime anime, BuildContext context) async {
    if (await CheckConnection.isConnected()) {
      Anime animeFinal =
          _animeList.lastWhere((oldElement) => oldElement == anime);
      animeFinal.watching = false;
      animeFinal.watched = true;
      notifyListeners();
      patch(
          Uri.parse(
              "$baseUrl/Animes/$userID/${animeFinal.id}.json?auth=${await getToken()}"),
          body: jsonEncode({
            "watched": animeFinal.watched,
            "watching": animeFinal.watching,
          }));
    } else {
      TextSnackbar.show(context, text: "Sem Conexão com a Internet!");
    }
  }

  void updateAnime(Map<String, Object> anime, BuildContext context) async {
    if (await CheckConnection.isConnected()) {
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
        if (anime.containsKey("userID")) {
          animeUpdate.userId = anime["userId"] as String;
        }
        animeList.insert(
            animeList.indexOf(findAnimeById(anime["id"].toString())!),
            animeUpdate);
        notifyListeners();
        String token = "?auth=${await getToken()}";
        put(
            Uri.parse(
                "$baseUrl$connectUrl/$userID/${animeUpdate.id}.json$token"),
            body: jsonEncode(animeUpdate.getMap()));
      }
    } else {
      TextSnackbar.show(context, text: "Sem Conexão com a Internet!");
    }
  }

  void addAnime(Map<String, Object> anime, BuildContext context) async {
    if (await CheckConnection.isConnected()) {
      if (anime.containsKey("id")) {
        if (anime["id"] != "") {
        updateAnime(anime, context);
        getRandomAnimes();
        return;
          
        }
      }
      Anime newAnime = mapToAnime(anime);
      newAnime.userId = userID;
      _animeList.add(newAnime);
      notifyListeners();
      String token = "?auth=${await getToken()}";
      post(Uri.parse('$baseUrl$connectUrl/$userID.json$token'),
          body: jsonEncode({
            "id": newAnime.id,
            "title": newAnime.title,
            "description": newAnime.description,
            "genero": newAnime.genero,
            "imageUrl": newAnime.imageUrl,
            "watched": newAnime.watched,
            "watching": newAnime.watching,
            "isPrio": newAnime.isPrio,
            "userId": newAnime.userId
          })).then((response) {
        String id = jsonDecode(response.body)["name"];

        patch(Uri.parse("$baseUrl$connectUrl/$userID/$id.json$token"),
            body: jsonEncode({"id": id}));
      });
      getRandomAnimes();
    } else {
      TextSnackbar.show(context, text: "Sem Conexão com a Internet!");
    }
  }

  void changeWacth(Anime anime, BuildContext context) async {
    if (await CheckConnection.isConnected()) {
      Anime updatedAnime = findFirst(anime);
      updatedAnime.watching = !updatedAnime.watching;
      updatedAnime.watched = false;
      notifyListeners();
      String token = "?auth=${await getToken()}";
      patch(
          Uri.parse(
              "$baseUrl$connectUrl/$userID/${updatedAnime.id}.json$token"),
          body: jsonEncode({
            "watched": updatedAnime.watched,
            "watching": updatedAnime.watching,
          }));
    } else {
      TextSnackbar.show(context, text: "Sem Conexão com a Internet!");
    }
  }

  void changePrio(Anime anime, BuildContext context) async {
    if (await CheckConnection.isConnected()) {
      Anime updatedAnime = findFirst(anime);
      updatedAnime.isPrio = !updatedAnime.isPrio;
      notifyListeners();
      String token = "?auth=${await getToken()}";
      patch(
        Uri.parse("$baseUrl$connectUrl/$userID/${updatedAnime.id}.json$token"),
        body: jsonEncode(
          {
            "isPrio": updatedAnime.isPrio,
          },
        ),
      );
    } else {
      TextSnackbar.show(context, text: "Sem Conexão com a Internet!");
    }
  }

  void deleteAnime(Anime anime, BuildContext context) async {
    if (await CheckConnection.isConnected()) {
      String id = "";
      _animeList.removeWhere((element) {
        id = element.id;
        return element == anime;
      });
      notifyListeners();
      String token = "?auth=${await getToken()}";
      delete(
        Uri.parse("$baseUrl$connectUrl/$userID/${anime.id}.json$token"),
      );
      getRandomAnimes();
    } else {
      TextSnackbar.show(context, text: "Sem Conexão com a Internet!");
    }
  }
  void deleteAllAnimes(String userId, BuildContext? context) async {
    if (await CheckConnection.isConnected()) {
      String id = "";
      String token = "?auth=${await getToken()}";
      delete(
        Uri.parse("$baseUrl$connectUrl/$userID.json$token"),
      );
    } else {
      if (context == null) {
        return;
      }
      TextSnackbar.show(context, text: "Sem Conexão com a Internet!");
    }
  }

  //FUNCTIONS

  Future<List<Anime>> getAnimeListFromUserProfile(UserProfile userProfile) async{
    List<Anime> userAnimes = [];
    try {
      //TODO voltar o id ao original ISdpsa0JnuhQVjHYNz8juQb3okI2
      await get(Uri.parse(
              "$baseUrl$connectUrl/${userProfile.id}.json?auth=${await getToken()}"))
          .then((value) {
        dynamic decoded = jsonDecode(
          value.body,
        );
        final loadedData =
            decoded.runtimeType == Null ? {} : decoded as Map<String, dynamic>;
        loadedData.forEach((key, value) {
          Map<String, dynamic> entry =
              (value as LinkedHashMap<String, dynamic>).cast();
          userAnimes.add(Anime(
            id: entry["id"].runtimeType == Null ? "" : entry["id"],
            genero: entry["genero"].runtimeType == Null
                ? []
                : (entry["genero"] as List<dynamic>).cast<String>(),
            title: entry["title"].runtimeType == Null ? "" : entry["title"],
            description: entry["description"].runtimeType == Null
                ? ""
                : entry["description"],
            imageUrl:
                entry["imageUrl"].runtimeType == Null ? "" : entry["imageUrl"],
            isPrio: entry["isPrio"],
            watched: entry["watched"],
            watching: entry["watching"],
              userId: entry["userId"]
          ));
        });
      });
    } catch (_) {
      
    }
    return userAnimes;
  }

  Future<String> getToken() async {
    if (await CheckConnection.isConnected()) {
      return await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
    } else {
      Navigator.of(_context).pushReplacementNamed(AppRoutes.NO_CONNECTION);
      return "";
    }
  }

  void getRandomAnimes() {
    randomAnimes.clear();
    if (_animeList.isEmpty) {
      randomAnimes = [];
      notifyListeners();
      return;
    }
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

  Anime mapToAnime(Map<String, Object> anime) {
    //TODO verify where this method is in use, then add the user id to map
    Anime newAnime = Anime(
      id: anime.containsKey("id")
          ? anime["id"].toString()
          : Random().nextDouble().toString(),
      title: anime["title"].toString(),
        genero: anime["genero"] as List<String>,
        description: anime.containsKey("description")
            ? anime["description"].toString()
            : "",
        isPrio: anime.containsKey("isPrio") ? anime["isPrio"] as bool : false,
        userId: anime["userId"].toString()
    );
    if (anime.containsKey("imageUrl")) {
      newAnime.setImageUrl(anime["imageUrl"].toString());
    }
    return newAnime;
  }

  Anime findFirst(Anime anime) {
    return _animeList.firstWhere((element) => element.id == anime.id);
  }

  Anime? findAnimeById(String id) {
    return _animeList.firstWhere((element) => element.id == id, orElse: null);
  }

  //GETTERS AND SETTERS

  String get userID {
   
    return FirebaseAuth.instance.currentUser?.uid ?? "";
   
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

import 'dart:convert';

import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class UserProfileProvider with ChangeNotifier {
  String _baseUrl = "https://stormapp-80b5f.firebaseio.com";
  String _pasteUrl = "User-Profiles";
  UserProfile? userProfile;

  String get userId {
    return FirebaseAuth.instance.currentUser?.uid ?? "";
  }

  Future<String> get _authToken async {
    return "?auth=${await FirebaseAuth.instance.currentUser?.getIdToken()}";
  }

  set updateImageProfile(String url) {
    if (userProfile == null) {
      return;
    } else {
      userProfile!.profileImageUrl = url;
      addUser(userProfile);
    }
    notifyListeners();
  }

  set updateProfileName(String name) {
    if (userProfile == null) {
      return;
    } else {
      userProfile!.name = name;
      addUser(userProfile);
    }
    notifyListeners();
  }

  bool isvalidUser() {
    return (userProfile?.name.isNotEmpty ?? false) &&
        (userProfile?.profileImageUrl.isNotEmpty ?? false);
  }

  Future<void> addUser(UserProfile? user) async {
    if (user == null) {
      return;
    }
    if (await currentUser == null) {
      await put(
        Uri.parse("$_baseUrl/$_pasteUrl/$userId.json${await _authToken}"),
        body: jsonEncode(
          {
            "name": user.name,
            "profileImageUrl": user.profileImageUrl,
            "id": userId,
            "friends": user.friends
          },
        ),
      );
      await put(
        Uri.parse(
            "$_baseUrl/$_pasteUrl/UserNames/${user.name}.json${await _authToken}"),
        body: jsonEncode(
          userId,
        ),
      );
    } else {
      await updateUser(user);
    }
    await setUserProfile();
    notifyListeners();
  }

  Future<void> updateUser(UserProfile? user) async {
    if (user == null) {
      return;
    }
    await patch(
      Uri.parse("$_baseUrl/$_pasteUrl/$userId.json${await _authToken}"),
      body: jsonEncode(
        {
          "name": user.name,
          "profileImageUrl": user.profileImageUrl,
          "id": userId,
          "friends": user.friends
        },
      ),
    );
    await put(
      Uri.parse(
          "$_baseUrl/$_pasteUrl/UserNames/${user.name}.json${await _authToken}"),
      body: jsonEncode(userId),
    );
  }

  void deleteUser(UserProfile user) async {
    await delete(
      Uri.parse("$_baseUrl/$_pasteUrl/$userId.json${await _authToken}"),
    );
    await delete(
      Uri.parse(
          "$_baseUrl/$_pasteUrl/UserNames/${user.name}.json${await _authToken}"),
    );
    notifyListeners();
  }

  Future<void> setUserProfile() async {
    userProfile = await currentUser;
  }

  Future<bool> isUserNameExist(String userName) async {
    bool exists = true;
    await get(Uri.parse(
            "$_baseUrl/$_pasteUrl/UserNames/$userName.json${await _authToken}"))
        .then((value) {
      if (value.body == "null") {
        exists = false;
      }
    });
    return exists;
  }

  Future<UserProfile?> get currentUser async {
    late UserProfile? user;
    await get(
            Uri.parse("$_baseUrl/$_pasteUrl/$userId.json${await _authToken}"))
        .then(
      (value) {
        if (value.body == "null") {
          user = null;
        } else {
          Map<String, dynamic> newUser =
              jsonDecode(value.body) as Map<String, dynamic>;
          user = UserProfile(
            name: newUser["name"] ?? "",
            profileImageUrl: newUser["profileImageUrl"] ?? "",
            id: userId,
              friends: (newUser["friends"] as List<dynamic>).cast<String>()
          );
        }
      },
    );
    return user;
  }
  Future<UserProfile?> getUserByUid(String uid) async {
    late UserProfile? user;
    await get(
            Uri.parse("$_baseUrl/$_pasteUrl/$uid.json${await _authToken}"))
        .then(
      (value) {
        if (value.body == "null") {
          user = null;
        } else if(value.statusCode < 200 || value.statusCode > 299 ){
          user = null;
        } else {
          Map<String, dynamic> newUser =
              jsonDecode(value.body) as Map<String, dynamic>;
          user = UserProfile(
            name: newUser["name"] ?? "",
            profileImageUrl: newUser["profileImageUrl"] ?? "",
              id: newUser["id"] as String,
              friends: ((newUser["friends"] ?? <dynamic>[]) as List<dynamic>)
                  .cast<String>()
          );
        }
      },
    );
    return user;
  }

}

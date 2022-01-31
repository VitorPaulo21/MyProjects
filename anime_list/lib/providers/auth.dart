import 'dart:io';

import 'package:anime_list/components/auth_form.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/check_connection.dart';
import 'package:encrypt/encrypt.dart' as a;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String baseUrl = "https://identitytoolkit.googleapis.com/v1/accounts:";

  Auth() {
    FirebaseAuth auth = FirebaseAuth.instance;
  }
  Future<void> Autenticate(
    LoginStyle loginStyle,
    Map<String, String> userData,
  ) async {
    if (userData.isEmpty ||
        !userData.containsKey("email") ||
        !userData.containsKey("password")) {
      return;
    } else {
      if (userData["email"]!.isEmpty || userData["password"]!.isEmpty) {
        return;
      }
    }
    if (loginStyle == LoginStyle.LOGIN) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userData["email"]!,
          password: userData["password"]!,
        );
      } on FirebaseAuthException catch (e) {
        rethrow;
      } catch (e) {
        print(e);
      }
    } else if (loginStyle == LoginStyle.SIGNUP) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userData["email"]!,
          password: userData["password"]!,
        );
      } on FirebaseAuthException catch (e) {
        rethrow;
      } catch (e) {
        print(e);
        //TODO remove it

      }
    } else {
      return;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences sharedData = await SharedPreferences.getInstance();
    sharedData.setString("email", "");
    sharedData.setString("password", "");
  }

  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

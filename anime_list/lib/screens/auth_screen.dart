import 'dart:ui';

import 'package:anime_list/components/auth_form.dart';
import 'package:anime_list/providers/auth.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _containsSaveLoginKey = false;
  bool _saveLogin = false;
  bool _goToHome = false;
  bool isConnected = false;

  Future<void> haveSaveLoginKey(BuildContext context) async {
    _containsSaveLoginKey = await SharedPreferences.getInstance()
        .then<bool>((value) => value.containsKey("saveLogin"));
    if (_containsSaveLoginKey) {
      _saveLogin = await SharedPreferences.getInstance()
          .then<bool>((value) => value.getBool("saveLogin")!);
    }
    if (_containsSaveLoginKey) {
      if (_saveLogin) {
        if (FirebaseAuth.instance.currentUser != null) {
          _goToHome = true;
        } else {
          _goToHome = false;
        }
      } else {
        _goToHome = false;
      }
    } else {
      _goToHome = false;
    }
    if (_goToHome) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }
  }

  @override
  void initState() {
    // haveSaveLoginKey(context).then((value) {
    //   if (!_goToHome) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Animes"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/backgorund_image2.jpg"),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const AuthForm(),
            ),
          )
        ],
      ),
    );
  }
}

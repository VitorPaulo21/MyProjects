import 'dart:ui';

import 'package:anime_list/components/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Animes"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("lib/assets/backgorund_image.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: AuthForm(),
              ),
            ),
          ),
        ],
        alignment: Alignment.center,
      ),
    );
  }
}

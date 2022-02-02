import 'package:flutter/material.dart';

class TextSnackbar {
  static void show(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[850],
        content: Text(
          text,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

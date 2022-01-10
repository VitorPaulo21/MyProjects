import 'package:flutter/material.dart';

class FinishAnimeDialog extends StatelessWidget {
  const FinishAnimeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Concluir?"),
      content: const Text("Deseja mesmo concluir este anime?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              "Sim",
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              "Não",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}

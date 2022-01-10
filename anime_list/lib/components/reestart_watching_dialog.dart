import 'package:flutter/material.dart';

class ReestartWatching extends StatelessWidget {
  const ReestartWatching({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Rever?"),
      content: const Text("Deseja voltar a rever este anime?"),
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

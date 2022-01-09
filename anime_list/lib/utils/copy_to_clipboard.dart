import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipBoard(BuildContext context, String text) {
  ClipboardData data = ClipboardData(text: text);
  Clipboard.setData(data);
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.grey[800],
    content: const Text(
      "Copiado para a Área de Transferencia",
      style: TextStyle(
        color: Colors.orange,
        fontSize: 15,
      ),
    ),
  ));
}

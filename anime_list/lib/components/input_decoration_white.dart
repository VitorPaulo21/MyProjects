import 'package:flutter/material.dart';

InputDecoration DecorationWithLabel(String label) {
  return InputDecoration(
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  );
}

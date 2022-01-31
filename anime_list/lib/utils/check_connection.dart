import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class CheckConnection {
  static Future<bool> isConnected() async {
    return await _internetConnection();
  }

  static Future<bool> _internetConnection() async {
    late final List<InternetAddress> response;
    try {
      response = await InternetAddress.lookup("google.com.br",
          type: InternetAddressType.IPv4);
    } on SocketException catch (e) {
      return false;
    }

    return response.isNotEmpty;
  }
}

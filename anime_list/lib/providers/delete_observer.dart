import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeleteObserver with ChangeNotifier {
  void notifyObservers() {
    notifyListeners();
  }
}

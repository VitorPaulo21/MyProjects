import 'package:flutter/cupertino.dart';
import 'package:my_expenses/models/credit_card.dart';

class CardsProvider with ChangeNotifier {
  List<CreditCard> _cards = [];

  void addCards(CreditCard card) {
    _cards.add(card);
    notifyListeners();
  }

  List<CreditCard> get cards => [..._cards];
}

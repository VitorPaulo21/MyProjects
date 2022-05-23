import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/credit_card.dart';
import 'package:my_expenses/models/expense.dart';

class CardsProvider with ChangeNotifier {
  List<CreditCard> _cards = [];

  void addCards(CreditCard card) {
    if (_cards.contains(card)) {
      _cards[_cards.indexOf(card)] = card;
    } else {

    _cards.add(card);
      notifyListeners();
    }
  }

  addExpense(Expense expense, CreditCard card) {
    if (_cards.contains(card)) {
      _cards[_cards.indexOf(card)]
          .expenses[DateFormat("MM/yyyy").format(expense.date)]
          ?.add(expense);
      notifyListeners();
    }
  }

  double cardsTotalValueByMonth(String month) {
    return _cards
        .map<double>((card) => card.getValueByMonth(month))
        .fold<double>(0, (previousValue, element) => element + previousValue);
  }
  List<CreditCard> get cards => [..._cards];
}

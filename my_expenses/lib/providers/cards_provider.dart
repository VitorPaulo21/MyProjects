import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/credit_card.dart';
import 'package:my_expenses/models/expense.dart';

class CardsProvider with ChangeNotifier {
  List<CreditCard> _cards = [];

  void addCards(CreditCard card) {
    if (_cards.contains(card)) {
      _cards[_cards.indexOf(card)] = card;
      notifyListeners();
    } else {

    _cards.add(card);
      notifyListeners();
    }
  }

  addExpense(Expense expense, CreditCard card) {
    String date = DateFormat("MM/yyyy").format(expense.date);
    if (_cards.contains(card)) {
      
      if (_cards[_cards.indexOf(card)].expenses.containsKey(date)) {
        _cards[_cards.indexOf(card)].expenses[date]!.add(expense);
      } else {
        _cards[_cards.indexOf(card)]
            .expenses
            .putIfAbsent(date, () => [expense]);
      }
    } else {
      print("nao tem cartao");

    }
  }

  double cardsTotalValueByMonth(String month) {
    return _cards
        .map<double>((card) => card.getValueByMonth(month))
        .fold<double>(0, (previousValue, element) => element + previousValue);
  }
  List<CreditCard> get cards => [..._cards];
}

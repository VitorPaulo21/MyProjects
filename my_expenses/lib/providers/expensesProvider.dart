import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/credit_card.dart';
import 'package:my_expenses/models/expense.dart';

import 'package:my_expenses/models/wallet.dart';
import 'package:my_expenses/providers/cards_provider.dart';

import 'salary_provider.dart';

class ExpensesProvider with ChangeNotifier {
  Wallet _wallet = Wallet(0);
  
  CardsProvider? cardsProvider;
  SalaryProvider? salaryProvider;
  ExpensesProvider(this.cardsProvider, this.salaryProvider);
set wallet(Wallet newWallet) => _wallet = newWallet;
  Wallet get wallet {
    calculateWallet();
    return _wallet;
  }
  void addExpense(Expense expense, CreditCard card) {
    cardsProvider!.addExpense(expense, card);
    notifyListeners();
  }
    // calculateWallet();

  
bool _compareDates(DateTime date1, DateTime date2) {
    return DateFormat("dd/MM/yyyy").format(date1) ==
        DateFormat("dd/MM/yyyy").format(date2);
  }

  String formatDate(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }

double allValueByDate(DateTime date) {
    List<CreditCard> loadMonthCards = cardsProvider!.cards
        .where((card) =>
            card.expenses.containsKey(DateFormat("MM/yyyy").format(date)))
        .toList();
    if (loadMonthCards.isNotEmpty) {
      return loadMonthCards
          .map((cards) => cards.expenses[DateFormat("MM/yyyy").format(date)]!
              .fold<double>(
                  0, (previousValue, element) => element.value + previousValue))
          .fold(0, (previousValue, element) => element + previousValue);
    } else {
      return 0;
    }
  }

  void calculateWallet() {
    //TODO implement the date here when date provider is ready
    _wallet.value = salaryProvider!.getTotalSalaryValueByMonth("05/2022") -
        cardsProvider!.cardsTotalValueByMonth("05/2022");

    // _wallet.value = expenses.values
    //     .map<List<double>>((lists) => lists.map((e) => e.value).toList())
    //     .fold<double>(
    //         0,
    //         (previousValue, element) =>
    //             element.fold<double>(
    //                 0, (previousValue, element) => element + previousValue) +
    //             previousValue);
  }
}

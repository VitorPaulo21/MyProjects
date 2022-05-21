import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/expense.dart';
import 'package:my_expenses/models/to_pay.dart';
import 'package:my_expenses/models/wallet.dart';

class ExpensesProvider with ChangeNotifier {
  Wallet _wallet = Wallet(0);
  Map<String, List<Expense>> expenses = {};
set wallet(Wallet newWallet) => _wallet = newWallet;
  Wallet get wallet {
    calculateWallet();
    return _wallet;
  }
  void addToPay(ToPay toPay) {
    if (_compareDates(toPay.compensation, toPay.expiryDate)) {
      if (expenses.containsKey(formatDate(toPay.compensation))) {
        expenses[formatDate(toPay.compensation)]?.add(toPay);
      } else {
        expenses.putIfAbsent(formatDate(toPay.compensation), () => [toPay]);
      }
    } else {
      if (expenses.containsKey(formatDate(toPay.compensation))) {
        expenses[formatDate(toPay.compensation)]?.add(toPay);
      } else {
        expenses.putIfAbsent(formatDate(toPay.compensation), () => [toPay]);
      }
      if (expenses.containsKey(formatDate(toPay.expiryDate))) {
        expenses[formatDate(toPay.expiryDate)]?.add(toPay);
      } else {
        expenses.putIfAbsent(formatDate(toPay.expiryDate), () => [toPay]);
      }

    }
    // calculateWallet();

    notifyListeners();
  }
bool _compareDates(DateTime date1, DateTime date2) {
    return DateFormat("dd/MM/yyyy").format(date1) ==
        DateFormat("dd/MM/yyyy").format(date2);
  }

  String formatDate(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }

double allValueByDate(DateTime date) {
    return expenses[formatDate(date)]
            ?.map((expense) => expense.value)
            .fold<double>(
                0, (previousValue, nextValue) => previousValue + nextValue) ??
        0;
  }

  void calculateWallet() {
    _wallet.value = expenses.values
        .map<List<double>>((e) => e.map((e) => e.value).toList())
        .fold<double>(
            0,
            (previousValue, element) =>
                element.fold<double>(
                    0, (previousValue, element) => element + previousValue) +
                previousValue);

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

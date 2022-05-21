import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/expense.dart';
import 'package:my_expenses/models/to_pay.dart';
import 'package:my_expenses/models/wallet.dart';

class ExpensesProvider with ChangeNotifier {
  Wallet wallet = Wallet(0);
  Map<String, List<Expense>> expenses = {};

  void addToPay(ToPay toPay) {
    if (_compareDates(toPay.compensation, toPay.expiryDate)) {
      expenses.putIfAbsent(formatDate(toPay.compensation), () => [toPay]);
    } else {
      expenses[formatDate(toPay.compensation)]?.add(toPay);
      expenses[formatDate(toPay.expiryDate)]?.add(toPay);
    }

    notifyListeners();
  }
bool _compareDates(DateTime date1, DateTime date2) {
    return DateFormat("dd/MM/yyyy").format(date1) ==
        DateFormat("dd/MM/yyyy").format(date2);
  }

  String formatDate(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }
}

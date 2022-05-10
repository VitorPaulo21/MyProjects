import 'package:flutter/cupertino.dart';
import 'package:my_expenses/models/expense.dart';
import 'package:my_expenses/models/to_pay.dart';
import 'package:my_expenses/models/wallet.dart';

class ExpensesProvider with ChangeNotifier {
  Wallet wallet = Wallet(0);
  Map<DateTime, List<Expense>> expenses = {};

  void addToPay(ToPay toPay) {
    if (toPay.compensation.isAtSameMomentAs(toPay.expiryDate)) {
      expenses[toPay.compensation]?.add(toPay);
    } else {
      expenses[toPay.compensation]?.add(toPay);
      expenses[toPay.expiryDate]?.add(toPay);
    }

    notifyListeners();
  }

}

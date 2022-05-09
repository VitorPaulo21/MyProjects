import 'package:flutter/cupertino.dart';
import 'package:my_expenses/models/expense.dart';
import 'package:my_expenses/models/wallet.dart';

class ExpensesProvider with ChangeNotifier {
  Wallet wallet = Wallet(0);
  List<Expense> expenses = [];
}

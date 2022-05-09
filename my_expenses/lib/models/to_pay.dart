import 'package:my_expenses/models/expense.dart';

class ToPay extends Expense {
  DateTime expiryDate;

  ToPay(
      {required this.expiryDate,
      required DateTime compensation,
      required double value})
      : super(compensation: compensation, value: value);
}

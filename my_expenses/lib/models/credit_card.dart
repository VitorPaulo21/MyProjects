class CreditCard {
  String name;
  double _value;
  List<double> expenses = [];
  DateTime closingDate;
  DateTime dueDate;

  CreditCard(
      {required this.name,
      required this.closingDate,
      required this.dueDate,
      double value = 0})
      : _value = value;

  set value(double value) {
    _value = value;
  }

  double get value {
    _value = _value +
        expenses.fold<double>(
            0, (previousValue, actual) => actual + previousValue);
    return _value;
  }
}

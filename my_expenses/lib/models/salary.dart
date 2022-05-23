class Salary {
  double value;
  DateTime receiptDate;
  double _advance;
  DateTime? advanceDate;

  Salary({
    required this.value,
    required this.receiptDate,
    double advance = 0,
    this.advanceDate,
  }) : _advance = advance;

  double get advance {
    return _advance;
  }

  void setAdvance({required double value, required DateTime advanceDate}) {
    _advance = value;
    this.advanceDate = advanceDate;
  }
}

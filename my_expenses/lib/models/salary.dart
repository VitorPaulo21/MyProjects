class Salary {
  double value;
  int receiptDate;
  double _advance;
  int? advanceDate;
  bool fixDate;

  Salary({
    required this.value,
    required this.receiptDate,
    double advance = 0,
    this.advanceDate,
      bool this.fixDate = false
  }) : _advance = advance;

  double get advance {
    return _advance;
  }

  void setAdvance({required double value, required int advanceDate}) {
    _advance = value;
    this.advanceDate = advanceDate;
  }
}

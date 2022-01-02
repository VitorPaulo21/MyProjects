class GenderSugestions {
  static final List<String> _sugestions = [
    "Ação",
    "Echi",
    "Comêdia",
    "Romance",
    "Drama",
    "Isekai",
    "Luta",
    "Maou",
  ];
  static List<String?> getSugestions(String query) {
    return _sugestions
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

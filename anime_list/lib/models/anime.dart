class Anime {
  final String id;
  final String description;
  final String title;
  late String _imageUrl;
  final List<String> genero;
  bool watched;
  bool watching;
  bool isPrio;
  void setImageUrl(String url) {
    _imageUrl = url;
  }

  String get imageUrl {
    return _imageUrl;
  }
  Anime(
      {required this.id,
      this.description = "",
      required this.title,
      imageUrl =
          "https://static.wikia.nocookie.net/onepiece/images/6/62/Luffy_Wanted_Poster.png/revision/latest/scale-to-width-down/250?cb=20140829112312&path-prefix=pt",
      required this.genero,
      this.watched = false,
      this.watching = false,
      this.isPrio = false}) {
    _imageUrl = imageUrl;
  } 
}

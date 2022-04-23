class UserProfile {
  String name;
  String profileImageUrl;
  final String? id;
  List<UserProfile>? friends = [];

  UserProfile(
      {required this.name,
      this.profileImageUrl =
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FAppImages%2FPikPng.com_luffy-png_1127171.png?alt=media&token=e25e4ffc-abca-48bf-ab7c-e7967d77016b",
      this.id,
      this.friends});
}

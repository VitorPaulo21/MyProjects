import 'package:anime_list/components/animes_screen.dart';
import 'package:anime_list/components/app_drawer.dart';
import 'package:anime_list/components/home_screen.dart';
import 'package:anime_list/components/row_anime_list.dart';
import 'package:anime_list/components/titled_row_list.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Anime> userListAnime = [];
  bool isLoading = true;

  getAnimes(UserProfile userProfile) async {
    if (userListAnime.isNotEmpty) {
      print("here");
      return;
    }
    setState(() {
      isLoading = true;
    });
    userListAnime = await Provider.of<AnimeList>(context, listen: false)
        .getAnimeListFromUserProfile(userProfile);

    setState(() {
      isLoading = false;
    });
  }
@override
  void dispose() {
    userListAnime = [];
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    UserProfile userProfile =
        ModalRoute.of(context)?.settings.arguments as UserProfile;
    print(userProfile.id);
    bool isSelfUser = userProfile.id ==
        (
        (Provider.of<UserProfileProvider>(context, listen: false)
                .userProfile
                ?.id) ??
            false);
    getAnimes(userProfile);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Scaffold(
              backgroundColor: Colors.black,
              drawer: AppDrawer(),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    // floating: true,
                    // snap: true,
                    expandedHeight: 350,
                    backgroundColor: Colors.black54,

                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        userProfile.name,
                      ),
                      centerTitle: true,
                      collapseMode: CollapseMode.parallax,
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            minRadius: 80,
                            maxRadius: 100,
                            foregroundImage:
                                NetworkImage(userProfile.profileImageUrl),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: isSelfUser
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  isSelfUser ? "Editar" : "Adicionar",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(92),
                                      ),
                                    ),
                                    primary: isSelfUser
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                    onPrimary: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.email_outlined,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: kToolbarHeight + 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: Container(
                          color: Colors.grey[850],
                          child: Column(
                            children: [
                              TitledRowList(
                                title: "Assistindo",
                                hasArrow: true,
                                listTipe: ListTipe.WATCHING,
                                userList:
                                    AnimeList(context, userList: userListAnime),
                                onTap: () {
                                  Provider.of<AnimeList>(context, listen: false)
                                      .getAnimeListFromUserProfile(userProfile)
                                      .then((userList) {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.ANIME_LIST,
                                        arguments: {
                                          "listTipe": ListTipe.WATCHING,
                                          "userList": AnimeList(context,
                                              userList: userList)
                                        });
                                  });
                                },
                              ),
                              TitledRowList(
                                title: "Prioridades",
                                hasArrow: true,
                                listTipe: ListTipe.PRIO,
                                userList:
                                    AnimeList(context, userList: userListAnime),
                                onTap: () {
                                  Provider.of<AnimeList>(context, listen: false)
                                      .getAnimeListFromUserProfile(userProfile)
                                      .then((userList) {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.ANIME_LIST,
                                        arguments: {
                                          "listTipe": ListTipe.PRIO,
                                          "userList": AnimeList(context,
                                              userList: userList)
                                        });
                                  });
                                },
                              ),
                              TitledRowList(
                                title: "Para Assistir",
                                hasArrow: true,
                                listTipe: ListTipe.NORMAL,
                                userList:
                                    AnimeList(context, userList: userListAnime),
                                onTap: () {
                                  Provider.of<AnimeList>(context, listen: false)
                                      .getAnimeListFromUserProfile(userProfile)
                                      .then((userList) {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.ANIME_LIST,
                                        arguments: {
                                          "listTipe": ListTipe.NORMAL,
                                          "userList": AnimeList(context,
                                              userList: userList)
                                        });
                                  });
                                },
                              ),
                              TitledRowList(
                                title: "Concluidos",
                                hasArrow: true,
                                listTipe: ListTipe.FINISHED,
                                userList:
                                    AnimeList(context, userList: userListAnime),
                                onTap: () {
                                  Provider.of<AnimeList>(context, listen: false)
                                      .getAnimeListFromUserProfile(userProfile)
                                      .then((userList) {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.ANIME_LIST,
                                        arguments: {
                                          "listTipe": ListTipe.FINISHED,
                                          "userList": AnimeList(context,
                                              userList: userList)
                                        });
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
    );
  }
}

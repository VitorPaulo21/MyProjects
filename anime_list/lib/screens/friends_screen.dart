

import 'package:anime_list/components/app_drawer.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class friendsScreen extends StatefulWidget {
  const friendsScreen({Key? key}) : super(key: key);

  @override
  State<friendsScreen> createState() => _friendsScreenState();
}

class _friendsScreenState extends State<friendsScreen> {
  List<UserProfile> friends = [];
  bool isLoading = true;
  @override
  void initState() {
    loadFriends();
    super.initState();
  }

  loadFriends() async {
    friends.clear();
    UserProfile? user =
        Provider.of<UserProfileProvider>(context, listen: false).userProfile;
    if (user != null) {
      if ((user.friends?.length ?? 0) > 0) {
        for (var i = 0; i < (user.friends?.length ?? 0); i++) {
          UserProfile? innerUser =
              await Provider.of<UserProfileProvider>(context, listen: false)
                  .getUserByUid(user.friends![i]);
          if (innerUser != null) {
            friends.add(innerUser);
          } else {
            continue;
          }
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double avaliableScreenSpace = MediaQuery.of(context).size.height -
        (kToolbarHeight +
            MediaQuery.of(context).padding.bottom +
            MediaQuery.of(context).padding.top);
    UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Amigos"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await SearchFriendDialog(context, userProfileProvider);
            },
            icon: const Icon(Icons.group_add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.11),
            alignment: Alignment.center,
            height: avaliableScreenSpace * 0.15,
            width: double.infinity,
            child: CupertinoTextField(
              placeholder: "Persquisar",
              placeholderStyle: const TextStyle(color: Colors.grey),
              textInputAction: TextInputAction.search,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              suffix: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.search,
                  color: Colors.grey[800],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(90),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: avaliableScreenSpace * 0.001,
            endIndent: MediaQuery.of(context).size.width * 0.06,
            indent: MediaQuery.of(context).size.width * 0.06,
            thickness: 1,
          ),
          if (isLoading)
            const Expanded(
                child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )),
          if (!isLoading && friends.length > 0)
            FriendsList(avaliableScreenSpace, context)
        ],
      ),
    );
  }

  Container FriendsList(double avaliableScreenSpace, BuildContext context) {
    return Container(
      height: avaliableScreenSpace * 0.84 -
          MediaQuery.of(context).viewInsets.bottom,
      child: RefreshIndicator(
        color: Colors.white,
        onRefresh: () async {
          setState(() {
            isLoading = true;
          });
          loadFriends();
        },
        child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (ctx, index) {
              ListTile? listile = ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                      AppRoutes.PROFILE_SCREEN,
                      arguments: friends[index]);
                },
                leading: CircleAvatar(
                  backgroundImage:
                      const AssetImage("lib/assets/luffy_like.png"),
                  foregroundImage: CachedNetworkImageProvider(
                      friends[index].profileImageUrl),
                ),
                title: Text(friends[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.email_outlined)),
                    IconButton(
                        onPressed: () {
                          removeFriendDialog(context, index).then((value) {
                            if (value ?? false) {
                              Provider.of<UserProfileProvider>(context,
                                      listen: false)
                                  .removeFriend(friends[index]);

                              setState(() {
                                isLoading = true;
                              });
                              loadFriends();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.group_remove_outlined,
                          color: Colors.red,
                        )),
                  ],
                ),
              );

              return listile;
            }),
      ),
    );
  }

  Future<bool?> removeFriendDialog(BuildContext context, int index) {
    return showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Remover ${friends[index].name} como Amigo?"),
            content: const Text("Voces não verao mais informaões um do outro"),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(true),
                child: Text(
                  "Sim",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(false),
                child: Text(
                  "Não",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          );
        });
  }

  SearchFriendDialog(
      BuildContext context, UserProfileProvider userProfileProvider) async {
    showDialog<bool>(
        context: context,
        builder: (ctx) {
          TextEditingController queryController = TextEditingController();
          bool isSearching = false;
          bool userNotFind = false;
          List<UserProfile> userQuery = [];
          return StatefulBuilder(builder: (context, setState) {
            void search() async {
              userQuery.clear();
              if (queryController.text.isNotEmpty) {
                userQuery.addAll(await userProfileProvider
                    .searchForRelatedUsers(queryController.text));
                if (userQuery.isNotEmpty) {
                  setState(() {
                    isSearching = false;
                  });
                } else {
                  setState(() {
                    isSearching = false;
                    userNotFind = true;
                  });
                }
              }
            }

            return AlertDialog(
              scrollable: true,
              titlePadding: EdgeInsets.all(8),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              title: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: Text("Adicionar Amigo")),
                    Wrap(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: false).pop();
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 18,
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoTextField(
                    controller: queryController,
                    placeholder: "Persquisar",
                    placeholderStyle: const TextStyle(color: Colors.grey),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (txt) {
                      setState(() {
                        isSearching = true;
                        userNotFind = false;
                      });
                      search();
                    },
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSearching = true;
                          userNotFind = false;
                        });
                        search();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(90),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (isSearching)
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  if (userNotFind)
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                        "Nenhum Usuário Encontrado",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  if (userQuery.isNotEmpty)
                    ...userQuery.map<ListTile>((profile) {
                      bool alreadyFriend =
                          friends.any((user) => user.id == profile.id);
                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundImage:
                              const AssetImage("lib/assets/luffy_like.png"),
                          foregroundImage: CachedNetworkImageProvider(
                              profile.profileImageUrl),
                        ),
                        title: Text(profile.name),
                        trailing: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            showDialog<bool>(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text(
                                        "Adicionar ${profile.name} como Amigo?"),
                                    content: const Text(
                                        "Voces poderao ver a Lista de Animes um do outro e enviar mensagens"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(true),
                                        child: Text(
                                          "Sim",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(false),
                                        child: Text(
                                          "Não",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ),
                                    ],
                                  );
                                }).then((value) {
                              if (value ?? false) {
                                userProfileProvider.addAFriend(profile);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                this.setState(() {
                                  isLoading = true;
                                });
                                loadFriends();
                              }
                            });
                          },
                          icon: Icon(
                            alreadyFriend
                                ? Icons.check_circle_outline
                                : Icons.person_add_alt_sharp,
                            color: alreadyFriend ? Colors.green : Colors.white,
                          ),
                        ),
                      );
                    }),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                      userNotFind = false;
                    });
                    search();
                  },
                  child: const Text(
                    "Pesquisar",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
        });
  }
}

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
  void didChangeDependencies() async {
    friends.clear();
    UserProfile? user =
        await Provider.of<UserProfileProvider>(context, listen: false)
            .currentUser;
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
    super.didChangeDependencies();
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
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    TextEditingController queryController =
                        TextEditingController();
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(child: Text("Adicionar Amigo")),
                            Wrap(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: false)
                                        .pop();
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
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoTextField(
                              controller: queryController,
                              placeholder: "Persquisar",
                              placeholderStyle:
                                  const TextStyle(color: Colors.grey),
                              textInputAction: TextInputAction.search,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 6),
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
                          ],
                        ),
                      );
                    });
                  });
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
            Container(
              height: avaliableScreenSpace * 0.84 -
                  MediaQuery.of(context).viewInsets.bottom,
              child: RefreshIndicator(
                color: Colors.white,
                onRefresh: () async {
                  setState(() {
                    isLoading = true;
                  });
                  didChangeDependencies();
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
                                onPressed: () {},
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
            )
        ],
      ),
    );
  }
}

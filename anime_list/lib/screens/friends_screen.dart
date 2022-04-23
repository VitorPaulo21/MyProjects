import 'package:anime_list/providers/user_profile_provider.dart';
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
            onPressed: () {},
            icon: const Icon(Icons.group_add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            alignment: Alignment.center,
            height: avaliableScreenSpace * 0.15,
            width: double.infinity,
            child: CupertinoTextField(
              prefix: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  )),
              placeholder: "Pesquisar",
              placeholderStyle: const TextStyle(color: Colors.grey),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(90),
                ),
              ),
            ),
          ),
          Divider(
            indent: MediaQuery.of(context).size.width * 0.05,
            endIndent: MediaQuery.of(context).size.width * 0.05,
            thickness: 2,
            height: avaliableScreenSpace * 0.01,
          ),
          Container(
            height: avaliableScreenSpace * 0.84,
            child: ListView.builder(
                itemCount:
                    userProfileProvider.userProfile?.friends?.length ?? 0,
                itemBuilder: (ctx, index) {
                  ListTile? listile = ListTile();

                  return listile;
                }),
          )
        ],
      ),
    );
  }

}

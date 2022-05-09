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
<<<<<<< HEAD
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
=======
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
>>>>>>> 01ce67f76d844ee73f226d9f8ab6d40f2c8c070d
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(90),
                ),
              ),
            ),
          ),
          Divider(
<<<<<<< HEAD
            color: Colors.grey,
            height: avaliableScreenSpace * 0.001,
            endIndent: MediaQuery.of(context).size.width * 0.06,
            indent: MediaQuery.of(context).size.width * 0.06,
            thickness: 1,
=======
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
>>>>>>> 01ce67f76d844ee73f226d9f8ab6d40f2c8c070d
          )
        ],
      ),
    );
  }

}

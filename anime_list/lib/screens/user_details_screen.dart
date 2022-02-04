import 'dart:convert';

import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/components/show_text_snackbar.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/check_connection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String defaultImage =
      "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FAppImages%2FPikPng.com_luffy-png_1127171.png?alt=media&token=e25e4ffc-abca-48bf-ab7c-e7967d77016b";
  bool validUrl = true;
  String currentUrl = "";
  GlobalKey<FormState> data = GlobalKey<FormState>();
  GlobalKey buttonKey = GlobalKey<State<ElevatedButton>>();
  TextEditingController urlEditingControler = TextEditingController();
  TextEditingController nameEditingControler = TextEditingController();

  bool isLoading = false;
  String getImageUrl() {
    if (getProfileProvider().userProfile == null) {
      if (currentUrl.isNotEmpty) {
        return currentUrl;
      } else {
        return defaultImage;
      }
    } else if ((getProfileProvider().userProfile?.profileImageUrl ?? "")
        .isEmpty) {
      if (currentUrl.isNotEmpty) {
        return currentUrl;
      } else {
        return defaultImage;
      }
    } else {
      return getProfileProvider().userProfile!.profileImageUrl;
    }
  }

  String getUserName() {
    if (getProfileProvider().userProfile == null) {
      return "";
    } else if ((getProfileProvider().userProfile?.name ?? "").isEmpty) {
      return "";
    } else {
      return getProfileProvider().userProfile!.name;
    }
  }

  UserProfileProvider getProfileProvider() {
    return Provider.of<UserProfileProvider>(context, listen: false);
  }

  void submitForm() async {
    if (!(await CheckConnection.isConnected())) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.NO_CONNECTION);
      return;
    }
    bool isValid = data.currentState?.validate() ?? false;
    setState(() {
      isLoading = true;
    });
    if (isValid) {
      getProfileProvider().addUser(UserProfile(
          name: nameEditingControler.text, profileImageUrl: getImageUrl()));
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    nameEditingControler.text = getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        centerTitle: true,
      ),
      body: Form(
        key: data,
        child: Container(
          padding: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    //TODO implement TAKE IMAGE FROM GALLERY
                    showDialog<String>(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text("Imagem de perfil"),
                            content: TextField(
                              controller: urlEditingControler,
                              decoration: DecorationWithLabel("Url da Imagem"),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "cancelar",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(urlEditingControler.text);
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  )),
                            ],
                          );
                        }).then((urlText) {
                      if (urlText == null || urlText.isEmpty) {
                        urlEditingControler.text = "";
                        return;
                      }
                      setState(() {
                        currentUrl = urlText;
                        urlEditingControler.text = "";
                      });
                    });
                  },
                  child: Stack(children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(getImageUrl()),
                      onBackgroundImageError: (obj, stackTrace) async {
                        if (!(await CheckConnection.isConnected())) {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.NO_CONNECTION);
                          return;
                        }
                        TextSnackbar.show(context,
                            text: "Url de Imagem Inválida");
                        setState(() {
                          currentUrl = "";
                        });
                      },
                    ),
                    Positioned(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                      right: 1,
                      bottom: 1,
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    onFieldSubmitted: (txt) => submitForm(),
                    controller: nameEditingControler,
                    maxLength: 20,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Nome de Usuário"),
                    validator: (txt) {
                      if (txt?.isEmpty ?? true) {
                        return "O nome de usuário não pode estar vazio";
                      }
                      if ((txt ?? "").length < 5) {
                        return "Necessita de no minimo 5 letras";
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: !isLoading
                  ? () {
                      submitForm();
                    }
                  : null,
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text("Avançar"),
              key: buttonKey,
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(91)))),
            ),
          ],
        ),
      ),
    );
  }
}

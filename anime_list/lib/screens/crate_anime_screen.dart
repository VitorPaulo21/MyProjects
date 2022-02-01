import 'package:anime_list/components/image_pick_dialog.dart';
import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/data/dummy_data.dart';
import 'package:anime_list/data/genders.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class CreateAnimeScreen extends StatefulWidget {
  const CreateAnimeScreen({Key? key}) : super(key: key);

  @override
  State<CreateAnimeScreen> createState() => _CreateAnimeScreenState();
}

class _CreateAnimeScreenState extends State<CreateAnimeScreen> {
  String ImgUrl = "";
  bool isPrio = false;
  bool isValidImage = true;
  bool edited = false;
  GlobalKey<FormState> data = GlobalKey<FormState>();
  Map<String, Object> anime = {};
  List<String> genders = [];
  TextEditingController genderController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  SuggestionsBoxController sugestionBoxController = SuggestionsBoxController();
  void _submitForm() {
    bool isValid = data.currentState?.validate() ?? false;
    if (isValid) {
      data.currentState?.save();
      if (genders.isNotEmpty) {
        anime["genders"] = genders;
      }
      if (isPrio) {
        anime["prio"] = true;
      }
      if (isValidImage) {
        if (ImgUrl == "") {
          ImgUrl =
              "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FAppImages%2FPikPng.com_luffy-png_1127171.png?alt=media&token=e25e4ffc-abca-48bf-ab7c-e7967d77016b";
        }
        anime["imgUrl"] = ImgUrl;
      }
      AnimeList animeList = Provider.of<AnimeList>(context, listen: false);
      animeList.addAnime(anime);
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        animeList.getAnimes();
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Object? obj = ModalRoute.of(context)?.settings.arguments;
    if (obj.runtimeType != Null && !edited) {
      setState(() {
        edited = true;
        Anime animeOld = obj as Anime;
        anime["id"] = animeOld.id;
        anime["title"] = animeOld.title;
        anime["desc"] = animeOld.description;
        anime["imgUrl"] = animeOld.imageUrl;
        anime["genders"] = animeOld.genero;
        anime["prio"] = animeOld.isPrio;
        anime["watched"] = animeOld.watched;
        anime["watching"] = animeOld.watching;

        if (anime.isNotEmpty) {
          if (anime.containsKey("title")) {
            titleController.text = anime["title"].toString();
          }
          if (anime.containsKey("desc")) {
            descriptionController.text = anime["desc"].toString();
          }
          if (anime.containsKey("imgUrl")) {
            ImgUrl = anime["imgUrl"].toString();
          }
          if (anime.containsKey("genders")) {
            genders = anime["genders"] as List<String>;
          }
          if (anime.containsKey("prio")) {
            isPrio = anime["prio"] as bool;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
        }

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Adicionar Anime"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                }
                ;
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: WillPopScope(
          onWillPop: () {
            if (sugestionBoxController.isOpened()) {
              sugestionBoxController.close();
              return Future<bool>.value(false);
            }
            return Future<bool>.value(true);
          },
          child: GestureDetector(
            onTap: () {
              if (sugestionBoxController.isOpened()) {
                sugestionBoxController.close();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: data,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  !ImgUrl.trim().isEmpty
                                      ? Image.network(
                                          ImgUrl,
                                          height: 180,
                                          width: 115,
                                          fit: BoxFit.cover,
                                          errorBuilder: (ctx, obj, _) {
                                            isValidImage = false;

                                            return Container(
                                              height: 180,
                                              width: 115,
                                              alignment: Alignment.center,
                                              child: Text("Imagem Invalida"),
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          "lib/assets/PikPng.com_luffy-png_1127171.png",
                                          height: 180,
                                          width: 115,
                                          fit: BoxFit.cover,
                                        ),
                                  Container(
                                    width: 115,
                                    height: 40,
                                    color: Colors.black54,
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Positioned(
                                      top: 3,
                                      right: 3,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.red,
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 20),
                                      )),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (ctx) {
                                            isValidImage = true;
                                            return ImagePickDialog();
                                          },
                                        ).then((url) {
                                          setState(() {
                                            ImgUrl = url ?? "";
                                          });
                                        });
                                      },
                                      child: const SizedBox(
                                        height: 180,
                                        width: 115,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: MediaQuery.of(context).size.width - 145,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  initialValue: anime.containsKey("title")
                                      ? anime["title"].toString()
                                      : "",
                                  cursorColor: Colors.white,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 50,
                                  decoration: DecorationWithLabel("Titulo:"),
                                  validator: (text) {
                                    if ((text ?? "").length < 3) {
                                      return "Precisa de no minimo 3 letras";
                                    }
                                  },
                                  onSaved: (title) {
                                    anime["title"] = title!;
                                  },
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  initialValue: anime.containsKey("desc")
                                      ? anime["desc"].toString()
                                      : "",
                                  maxLines: 3,
                                  minLines: 3,
                                  maxLength: 200,
                                  decoration: DecorationWithLabel("Descriçâo:"),
                                  onSaved: (desc) {
                                    if (desc.toString().trim().isNotEmpty) {
                                      anime["desc"] = desc ?? "";
                                    }
                                  },
                                )
                              ]),
                        )
                      ],
                    ),
                    if (genders.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text(
                              "Generos: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            ...genders.map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InputChip(
                                    label: Text(e),
                                    avatar: CircleAvatar(
                                      child: Text(e.substring(
                                          0, e.length >= 2 ? 2 : 1)),
                                    ),
                                    onDeleted: () => setState(() {
                                      genders.remove(e);
                                      data.currentState?.validate();
                                    }),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    TypeAheadFormField<String?>(
                      validator: (text) {
                        if (text.toString().trim().isNotEmpty &&
                            genders.length == 3) {
                          return "Só pode haver no máximo 3 gêneros";
                        }
                      },
                      direction: AxisDirection.up,
                      // hideOnEmpty: true,

                      hideOnError: true,
                      hideSuggestionsOnKeyboardHide: true,
                      suggestionsBoxController: sugestionBoxController,
                      noItemsFoundBuilder: (ctx) => ListTile(
                        
                       
                        title : TextButton(
                          style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                          onPressed: () {
                             if (genders.length == 3) {
                              data.currentState?.validate();
                              sugestionBoxController.close();
                            } else { 
                            setState(() {
                              if (genderController.text.isNotEmpty) {
                                genders.add(genderController.text);
                                genderController.text = "";
                                sugestionBoxController.close();
                              }
                            });

                            }
                          },
                          child: Text(
                            genderController.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17
                            ),
                          ),
                        ),
                      ),
                      autoFlipDirection: true,
                      textFieldConfiguration: TextFieldConfiguration(
                          onChanged: (txt) {
                            if (genders.length == 3) {
                              data.currentState?.validate();
                            }
                          },
                          onSubmitted: (txt) {
                            if (genders.length == 3) {
                              data.currentState?.validate();
                              sugestionBoxController.close();
                            } else {
                              setState(() {
                                genders.add(txt);
                                genderController.text = "";
                                sugestionBoxController.close();
                              });
                            }
                          },
                          cursorColor: Colors.white,
                          decoration: DecorationWithLabel("Generos"),
                          controller: genderController,
                          maxLength: 10,
                          maxLines: 1),
                      onSuggestionSelected: (text) {
                        if (genders.length + 1 < 4) {
                          setState(() {
                            genders.add(text!);
                            genderController.text = "";
                          });
                        }
                        data.currentState?.validate();
                      },
                      itemBuilder: (ctx, sugestion) => ListTile(
                        title: Text(sugestion!),
                      ),
                      suggestionsCallback: GenderSugestions.getSugestions,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                "Prioridade",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            CupertinoSwitch(
                                value: isPrio,
                                onChanged: (value) {
                                  setState(() {
                                    isPrio = value;
                                    anime["prio"] = value;
                                  });
                                }),
                          ],
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(90),
                          onTap: () {
                            _submitForm();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Chip(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                label: Text(
                                  Navigator.of(context).canPop()
                                      ? "Salvar"
                                      : "Adicionar",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/data/genders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CreateAnimeScreen extends StatefulWidget {
  const CreateAnimeScreen({Key? key}) : super(key: key);

  @override
  State<CreateAnimeScreen> createState() => _CreateAnimeScreenState();
}

class _CreateAnimeScreenState extends State<CreateAnimeScreen> {
  bool isPrio = false;
  GlobalKey<FormState> data = GlobalKey<FormState>();
  Map<String, String> anime = {};
  List<String> genders = [];
  TextEditingController genderController = TextEditingController();
  SuggestionsBoxController sugestionBoxController = SuggestionsBoxController();
  void _submitForm() {
    bool isValid = data.currentState?.validate() ?? false;
    print(isValid);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Anime"),
        centerTitle: true,
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
                                Image.asset(
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
                                      //TODO implement the add image button
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
                                maxLines: 3,
                                minLines: 3,
                                maxLength: 200,
                                decoration: DecorationWithLabel("Descriçâo:"),
                                onSaved: (desc) {
                                  anime["desc"] = desc ?? "";
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
                                    child: Text(
                                        e.substring(0, e.length >= 2 ? 2 : 1)),
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
                      if (genders.length == 3) {
                        return "Só pode haver no máximo 3 gêneros";
                      }
                    },
                    // hideOnEmpty: true,
                    hideOnError: true,
                    hideSuggestionsOnKeyboardHide: true,
                    suggestionsBoxController: sugestionBoxController,
                    noItemsFoundBuilder: (ctx) => const ListTile(
                      leading: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                      title: Text(
                        "Nenhum Gênero Encontrado",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    autoFlipDirection: true,
                    textFieldConfiguration: TextFieldConfiguration(
                        cursorColor: Colors.white,
                        decoration: DecorationWithLabel("Generos"),
                        controller: genderController,
                        maxLength: 10,
                        maxLines: 1),
                    onSuggestionSelected: (text) {
                      if (genders.length + 1 < 4) {
                        setState(() {
                          genders.add(text!);
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
                              label: const Text(
                                "Adiconar",
                                style: TextStyle(
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
    );
  }
}

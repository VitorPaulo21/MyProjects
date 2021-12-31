import 'package:anime_list/components/input_decoration_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class CreateAnimeScreen extends StatefulWidget {
  const CreateAnimeScreen({Key? key}) : super(key: key);

  @override
  State<CreateAnimeScreen> createState() => _CreateAnimeScreenState();
}

class _CreateAnimeScreenState extends State<CreateAnimeScreen> {
  List<Object?> genders = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Anime"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(alignment: Alignment.bottomRight, children: [
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
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            //TODO implement the add image button
                          },
                          child: const SizedBox(
                            height: 183,
                            width: 115,
                          ),
                        ),
                      )
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: MediaQuery.of(context).size.width - 135,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            maxLength: 50,
                            decoration: DecorationWithLabel("Titulo:"),
                            validator: (text) {
                              if ((text ?? "").length < 3) {
                                return "Precisa de no minimo 3 letras";
                              }
                            },
                          ),
                          TextFormField(
                            maxLines: 3,
                            minLines: 3,
                            maxLength: 200,
                            decoration: DecorationWithLabel("Descriçâo:"),
                          )
                        ]),
                  )
                ],
              ),
              FormField(
                builder: (formFieldState) => ChipsInput(
                  decoration: DecorationWithLabel("Genero"),
                  maxChips: 3,
                  allowChipEditing: false,
                  inputAction: TextInputAction.done,
                  findSuggestions: (String query) {
                    if (query.length != 0) {
                      //TODO quando a luista de sugestoes  no servidor estiver pronto adicione as sugestoes de genero aqui
                      String text = query.toLowerCase();
                      return <String>[
                        text,
                        "Ação",
                        "Ecchi",
                        "Comédia",
                        "Romance",
                        "Isekai",
                        "Magia",
                        "Maou",
                      ]
                          .where(
                              (element) => element.toLowerCase().contains(text))
                          .toList();
                    } else {
                      return const <String>[];
                    }
                  },
                  onChanged: (data) {
                    genders = data;
                  },
                  chipBuilder: (context, state, gender) {
                    return InputChip(
                      key: ObjectKey(gender),
                      label: Text(gender.toString()),
                      avatar: CircleAvatar(
                        child: Text(gender.toString().substring(
                            0, gender.toString().length >= 2 ? 2 : 1)),
                      ),
                      onDeleted: () => state.deleteChip(gender),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  },
                  suggestionBuilder: (context, state, gender) {
                    return ListTile(
                      key: ObjectKey(gender),
                      leading: CircleAvatar(
                        child: Text(gender.toString().substring(
                            0, gender.toString().length >= 2 ? 2 : 1)),
                      ),
                      title: Text(gender.toString()),
                      onTap: () => state.selectSuggestion(gender),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(90),
                  onTap: () {},
                  child: Chip(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      label: const Text(
                        "Adiconar",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

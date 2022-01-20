
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/providers/delete_observer.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabeledChangebleButton extends StatelessWidget {
  const LabeledChangebleButton({
    Key? key,
    required this.actualAnime,
      this.icon = Icons.add,
      this.label = "Prioridade",
      this.size = 30,
      this.function = labeledButtonFunctions.updatePrio,
      this.color = Colors.white
  }) : super(key: key);

  final Anime actualAnime;
  final IconData icon;
  final String label;
  final double size;
  final labeledButtonFunctions function;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AnimeList>(
        builder: (ctx, animeList, _) => Container(
          child: InkWell(
            highlightColor: Colors.white,
            onTap: () {
              if (function == labeledButtonFunctions.updatePrio) {
                animeList.changePrio(actualAnime);
              }
              if (function == labeledButtonFunctions.share) {}
              if (function == labeledButtonFunctions.delete) {
                showDialog<bool>(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text("Tem certeza?"),
                        content:
                            Text("Deseja mesmo remover este anime da lista?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              "sim",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text(
                              "não",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      );
                    }).then((value) {
                  bool delete = value ?? false;

                  if (delete) {
                    print(delete);
                    animeList.deleteAnime(actualAnime, context);
                    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                  }
                });
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (label == "Prioridade")
                Icon(
                  actualAnime.isPrio ? Icons.check : Icons.add,
                    size: size,
                    color: color,
                  ),
                if (label != "Prioridade")
                  Icon(
                    icon,
                    size: size,
                    color: color,
                  ),
                Text(
                  label,
                  style: TextStyle(color: color, fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum labeledButtonFunctions { updatePrio, share, delete }

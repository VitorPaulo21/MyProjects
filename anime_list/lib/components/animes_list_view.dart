import 'package:flutter/material.dart';

class AnimesListView extends StatelessWidget {
  final List<Map<String, String>> animeList;
  const AnimesListView(this.animeList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[850],
      child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10),
          itemCount: animeList.length,
          itemBuilder: (ctx, i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Card(
                  child: ListTile(
                    title: Text(animeList[i]["titulo"].toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(animeList[i]["genero"] ?? ""),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(animeList[i]["desc"] ?? ""),
                      ],
                    ),
                    leading: Image.network(
                      animeList[i]["url"] ??
                          "https://static.wikia.nocookie.net/onepiece/images/6/62/Luffy_Wanted_Poster.png/revision/latest/scale-to-width-down/250?cb=20140829112312&path-prefix=pt",
                      fit: BoxFit.fitHeight,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              )),
    );
  }
}

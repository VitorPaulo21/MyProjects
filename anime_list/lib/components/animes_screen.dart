import 'package:anime_list/components/anime_list_grid_item.dart';
import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/components/not_find_screen.dart';
import 'package:anime_list/components/row_anime_list_item.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimesScreen extends StatefulWidget {
 
  const AnimesScreen({Key? key})
      : super(key: key);

  @override
  _AnimesScreenState createState() => _AnimesScreenState();
}

class _AnimesScreenState extends State<AnimesScreen> {
  List<Anime> animes = [];
  ListTipe listTipe = ListTipe.ALL;
  late AnimeList animeList;

    @override
  void didChangeDependencies() {
    Object? listparam = ModalRoute.of(context)?.settings.arguments;
    listTipe = listparam.runtimeType == Null ? ListTipe.ALL : listparam as ListTipe;
    animeList = Provider.of<AnimeList>(context);
    animes = animeList.getListWithFilters(listTipe: listTipe);
    
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pushNamed(AppRoutes.HOME);
        return Future<bool>.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Anime List"),
            centerTitle: true,
            backgroundColor: Colors.black,
            actions: [
              PopupMenuButton<ListTipe>(
                onSelected: (tipe) {
                  setState(() {
                    listTipe = tipe;
                    animes = animeList.getListWithFilters(listTipe: listTipe);
                  });
                },
                icon: const Icon(Icons.sort, textDirection: TextDirection.rtl,),
                itemBuilder: (ctx) => const [
                  PopupMenuItem<ListTipe>(
                    value: ListTipe.ALL,
                    child: Text("Todos"),
                  ),
                  PopupMenuItem<ListTipe>(
                    value: ListTipe.WATCHING,
                    child: Text("Assistindo"),
                  ),
                  PopupMenuItem<ListTipe>(
                    value: ListTipe.PRIO,
                    child: Text("Prioridade"),
                  ),
                  PopupMenuItem<ListTipe>(
                    value: ListTipe.NORMAL,
                    child: Text("Normal"),
                  ),
                  PopupMenuItem<ListTipe>(
                    value: ListTipe.FINISHED,
                    child: Text("Assistidos"),
                  ),
                ],
              )
            ]),
        body: LayoutBuilder(builder: (ctx, constraints) => 
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  const Icon(Icons.search),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: constraints.maxWidth * 0.9,
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: DecorationWithLabel("Pesquisar Anime"),
                      
                      onChanged: (query){
                        if (query.isEmpty) {
                          setState(() {
                            animes = animeList.getListWithFilters(
                                        listTipe: listTipe);
                          });
                        } else {
                          setState(() {
                            animes = animeList.getListWithFilters(
                                        listTipe: listTipe);
                            animes = animes.where((anime) => anime.title.toLowerCase().contains(query.toLowerCase())).toList();
                            print(animes.length);
                          });
                        }
                      },
                    ))
                ],),
              ),
              animes.length > 0 ? Container(
                height: constraints.maxHeight * 0.87,
                child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: animes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 9 / 12,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 3),
                    itemBuilder: (ctx, index) {
        
                      // return RowAnimeListItem(animes[index]);
                      return AnimeListGridItem(animes[index]);
                    }),
              ) :
              NotFindScreen(message: animeList.animeList.length <= 0 ? null : "Nenhum anime encontrado",)
            ],
          ),
        ),)
      ),
    );
  }
}

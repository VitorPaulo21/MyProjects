import 'dart:math';

import 'package:anime_list/components/finish_anime_dialog.dart';
import 'package:anime_list/components/info_bottom_sheet.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/providers/delete_observer.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RandomIndication extends StatefulWidget {
  RandomIndication({
    Key? key,
  });

  @override
  State<RandomIndication> createState() => _RandomIndicationState();
}

class _RandomIndicationState  extends State<RandomIndication>{
  bool tela = false;
  List<Anime> animeList = [];
  List<Anime> randomAnimes = [];
  late Anime actualAnime;
  int actualIndex = 0;

  @override
  void didChangeDependencies() {
    tela = true;
     

     

  }
  @override
  Widget build(BuildContext context) {
        randomAnimes = 
            Provider.of<AnimeList>(context).randomAnimes;
    
    if (!(randomAnimes.length > 0)) {
      return SizedBox();
    } else {
      Anime actualAnime = randomAnimes[actualIndex];
      return Column(
        children: [
          Container(
            height: 450,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider.builder(
                          itemCount: randomAnimes.length,
                          itemBuilder: (ctx, index, realindex) {
                            return CachedNetworkImage(
                              imageUrl: randomAnimes[index].imageUrl,
                              height: 450,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (ctx, txt, _) => Image.asset(
                                "lib/assets/PikPng.com_luffy-png_1127171.png",
                              height: 450,
                              width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                actualAnime = randomAnimes[index];
                                actualIndex = index;
                              });
                            },
                            height: 450,
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayInterval:
                                const Duration(milliseconds: 10000),
                            enableInfiniteScroll: true,
                            pauseAutoPlayOnTouch: true,
                            scrollDirection: Axis.horizontal,
                          )),
                      Container(
                        width: double.infinity,
                        color: Colors.black54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            FittedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  actualAnime.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Consumer<AnimeList>(
                                    builder: (ctx, animeList, _) => Container(
                                      child: InkWell(
                                        highlightColor: Colors.white,
                                        onTap: () {
                                          tela = true;
                                          animeList.changePrio(actualAnime);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              actualAnime.isPrio
                                                  ? Icons.check
                                                  : Icons.add,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            const Text(
                                              "Prioridade",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Consumer<AnimeList>(
                                  builder: (ctx, animeListProvider, _) =>
                                      Container(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      onPressed: () {
                                        tela = true;
                                        if (actualAnime.watching) {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return FinishAnimeDialog();
                                              }).then((value) {
                                            bool result = value ?? false;
                                            if (result) {
                                              animeListProvider
                                                  .changeFinalized(actualAnime);
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      AppRoutes.HOME);
                                            }
                                          });
                                        } else {
                                          animeListProvider
                                              .changeWacth(actualAnime);

                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            actualAnime.watching
                                                ? Icons.check
                                                : Icons.play_arrow,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            
                                            actualAnime.watching
                                                ? "Finalizar"
                                                : "Assistir",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                            context: context,
                                            builder: (ctx) =>
                                                InfoBotomSheet(actualAnime));
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.info_outline,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Saiba Mais",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (tela)
                        Consumer<AnimeList>(builder: (ctx, animeList, _) {
                          tela = false;
                          return animeList.animeList
                                  .firstWhere(
                                      (oldAnime) => oldAnime == actualAnime)
                                  .isPrio
                              ? const Banner(
                                  message: "Prioridade",
                                  location: BannerLocation.topEnd,
                                  child: SizedBox(
                                    height: 450,
                                    width: double.infinity,
                                  ),
                                )
                              : const SizedBox();
                        }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedSmoothIndicator(
            activeIndex: actualIndex,
            count: 3,
            effect: WormEffect(
              activeDotColor: Theme.of(context).colorScheme.secondary,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ],
      );
    }
  }
}

import 'dart:math';

import 'package:anime_list/models/anime.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RandomIndication extends StatefulWidget {
  const RandomIndication({
    Key? key,
  }) : super(key: key);

  @override
  State<RandomIndication> createState() => _RandomIndicationState();
}

class _RandomIndicationState extends State<RandomIndication> {
  List<Anime> animeList = [];
  List<Anime> randomAnimes = [];
  late Anime actualAnime;
  int actualIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: implement didChangeDependencies
    animeList = Provider.of<AnimeList>(context, listen: false)
        .animeList
        .where((anime) => !anime.watched)
        .toList();
    animeList.shuffle();
    if (animeList.length >= 3) {
      randomAnimes = [animeList[0], animeList[1], animeList[2]];
    } else if (animeList.length > 0) {
      for (int i = 0; i < animeList.length; i++) {
        randomAnimes.add(animeList[i]);
      }
    } else {
      randomAnimes = [];
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            return Image.network(
                              randomAnimes[index].imageUrl,
                              height: 450,
                              width: double.infinity,
                              fit: BoxFit.cover,
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
                                        onTap: () => animeList
                                            .changePriority(actualAnime),
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
                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Assistir",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
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
                              ],
                            ),
                          ],
                        ),
                      ),
                      Consumer<AnimeList>(
                        builder: (ctx, animeList, _) => animeList.animeList
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
                            : const SizedBox(),
                      ),
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

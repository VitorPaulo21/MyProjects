import 'package:anime_list/models/anime.dart';

class data {
  List<Anime> get DUMMY_ANIMES {
    List<Anime> anime = [];
    _DUMMY_ANIMES.forEach((key, value) {
      anime.add(Anime(
        id: value["delete"]!,
        title: value["titulo"]!,
        genero: _stringToList(value["genero"]!),
        description: value.containsKey("desc") ? value["desc"]! : "",
        imageUrl: value.containsKey("url")
            ? value["url"]!
            : "https://static.wikia.nocookie.net/onepiece/images/6/62/Luffy_Wanted_Poster.png/revision/latest/scale-to-width-down/250?cb=20140829112312&path-prefix=pt",
        isPrio: value.containsKey("prio") ? value["prio"]! == "1" : false,
        watched: value.containsKey("Ass")
            ? value["Ass"]!.toLowerCase() == "true"
            : false,
        watching: value.containsKey("watch")
            ? value["watch"]!.toLowerCase() == "true"
            : false,
      ));
    });
    return anime;
  }

  List<String> _stringToList(String text) {
    List<String> gender = [];
    text
        .trim()
        .split(",")
        .forEach((element) => gender.add(element.replaceAll(",", "")));
    return gender;
  }

  final Map<String, Map<String, String>> _DUMMY_ANIMES = {
    "-M1hBlZcITW_5JdwBF1C": {
      "Ass": "false",
      "delete": "-M1hBlZcITW_5JdwBF1C",
      "desc":
          "Do cara que trabalha todo dia dai vem uma raposa Deusa de 300 anos cuidar dele pra ele ficar bem com a vida.",
      "genero": "Ecchi, Romanse",
      "prio": "1",
      "titulo": "SEWAYAKI KITSUNE NO SENKO-SAN",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FSEWAYAKI%20KITSUNE%20NO%20SENKO-SAN.jpg?alt=media&token=08d167b7-14b3-41ec-ad69-1801af1d9d9a",
      "watch": "false"
    },
    "-M1mwp9ojqtlYJjMSmeQ": {
      "Ass": "true",
      "delete": "-M1mwp9ojqtlYJjMSmeQ",
      "desc":
          "Do carinha la que pensa que é o thor, ainda nem sei i que ta acontecendo.",
      "genero": "Ação, Aventura. Ficção",
      "titulo": "Ragnarok",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FRagnarok.jpg?alt=media&token=92966060-53b8-4bd5-916c-e95803c6fdcc",
      "watch": "false"
    },
    "-M1nNFcRxqlB8u9KjwnC": {
      "Ass": "true",
      "delete": "-M1nNFcRxqlB8u9KjwnC",
      "desc": "Nada a declarar",
      "genero": "non",
      "titulo": "Assonishingod",
      "watch": "false"
    },
    "-M1syYF7f6gR2pXvJ_5C": {
      "Ass": "true",
      "delete": "-M1syYF7f6gR2pXvJ_5C",
      "desc":
          "O cara ma que nasceu fodao, Kapa todo mundo mas paga de humilde e n faz nada, as mina tudo balanga pra ele, e se ele solta ua peida ele explode o mundo.",
      "genero": "Aventura, Demonios, Magia",
      "titulo": "Xian Wang de Richang Shenghuo",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FXian%20Wang%20de%20Richang%20Shenghuo.jpg?alt=media&token=56678b5d-4072-4db9-8f2d-9c5c09df20b3"
    },
    "-M2LW4-keqNbzsaSmiL3": {
      "Ass": "true",
      "delete": "-M2LW4-keqNbzsaSmiL3",
      "desc":
          "Um lobo fortao, que vive num colegial de animais, ele é forte mas segura sua força, e tem uma coelinha safadona la",
      "genero": "Drama, Aventura, Teatro",
      "titulo": "Beastars - o Lobo Bom",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FBeastars%20-%20o%20Lobo%20Bom.jpg?alt=media&token=f609d684-af0b-4932-b581-d32c4b4cd29d"
    },
    "-M7d_vOyFwk2-AxAlDnW": {
      "Ass": "true",
      "delete": "-M7d_vOyFwk2-AxAlDnW",
      "desc":
          "o cara la q é otaku vai pra outra dimençao n tem poder e encontra as fadas",
      "genero": "Ecchi, Magia, Açao",
      "titulo": "Planting Manual",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FPlanting%20Manual.jpg?alt=media&token=df465251-8922-4cd8-b533-7c36b0bf8f1e"
    },
    "-M7jrDeDGaR7EstmO1Yc": {
      "Ass": "true",
      "delete": "-M7jrDeDGaR7EstmO1Yc",
      "desc": "os cara que fica revisando as garota esquizita",
      "genero": "Echi, comedia",
      "titulo": "Ishuzoko Reviewers",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FIshuzoko%20Reviewers.jpg?alt=media&token=6128059f-4e09-4cce-ab26-068750951300"
    },
    "-M7tNqk2Xc5Z_WDKaf5q": {
      "Ass": "true",
      "delete": "-M7tNqk2Xc5Z_WDKaf5q",
      "desc": "ainda n sei mt coisa sobre",
      "genero": "Comédia romântica",
      "titulo": "Gamers",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FGamers.jpg?alt=media&token=028b74c1-8e74-4fb7-bcd7-35c4451f8260"
    },
    "-M7tPn8YsDiBf9GDn1rP": {
      "Ass": "false",
      "delete": "-M7tPn8YsDiBf9GDn1rP",
      "desc": "Do cara la que é o asta so que sem poderes.",
      "genero": "Ação, Magia, Poderes",
      "titulo": "To aru majutsu no index",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FTo%20aru%20majutsu%20no%20index.jpg?alt=media&token=56a852a7-e951-44e8-a69a-1070c687e710",
      "watch": "false"
    },
    "-M886qOQKg-tUV-JU67y": {
      "Ass": "false",
      "delete": "-M886qOQKg-tUV-JU67y",
      "desc": "maluco overpower com o poder selado",
      "genero": "Romance, Overpower",
      "titulo": "gakusen toshi asterisk",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2Fgakusen%20toshi%20asterisk.jpg?alt=media&token=f804d136-a0c0-4eb0-86d7-45254eed9f11"
    },
    "-MGeHnmWzgY2xUzvBpz4": {
      "Ass": "true",
      "delete": "-MGeHnmWzgY2xUzvBpz4",
      "desc": "Indicaçao da Onêe, tem que ter prioridade.",
      "genero": "Romance, C9media, Sobrenatural",
      "prio": "1",
      "titulo": "Kamisama Hashimemashita",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FKamisama%20Hashimemashita.jpg?alt=media&token=e7e9f341-de73-44b4-be39-9e8f58ccf3a0",
      "watch": "false"
    },
    "-MHhz3NHuYWsNcE__nH0": {
      "Ass": "false",
      "delete": "-MHhz3NHuYWsNcE__nH0",
      "desc":
          "Do cara la que é vampiro ai ele é tipo o haikage, dai todo mundo tem medo dele e as mina quebra pra ele pq ele é over power",
      "genero": "Over ower, Sobrenatural, Romance",
      "titulo": "Strike The Blood",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FStrike%20The%20Blood.jpg?alt=media&token=9d15b5fc-b972-409b-b8ee-c82dd9b004c8"
    },
    "-MHhzslUY3CbmvPDzojK": {
      "Ass": "true",
      "delete": "-MHhzslUY3CbmvPDzojK",
      "desc":
          "Do cara la que é igual o diego  tem um monte de menina quebrando uma pra ele pq ele é overpower",
      "genero": "Romance,Poderes, Fantasia",
      "titulo": "Isekai mao to Shoukan Shoujo no dorei Majutso",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FIsekai%20mao%20to%20Shoukan%20Shoujo%20no%20dorei%20Majutso.jpg?alt=media&token=3e9f1d8e-3951-45ec-b26a-06880f001f23"
    },
    "-MYgraLfL7otyDhhC17F": {
      "Ass": "true",
      "delete": "-MYgraLfL7otyDhhC17F",
      "desc":
          "Anime de romance e harenzinho q vi no face, mt fofinho dos dois no cinema",
      "genero": "romance e echi provavelmente",
      "titulo": "Date a Live",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FDate%20a%20Live.jpg?alt=media&token=cb06d7e4-b711-498f-9245-9d3113422fd2"
    },
    "-MYguKFODCUFKSk_hhfK": {
      "delete": "-MYguKFODCUFKSk_hhfK",
      "desc": "Do cara la que nasceu pra matar o rei demonio",
      "genero": "echi romance",
      "titulo": "Yuusha ni Narenakatta Ore wa Shibushibu Shuushoku wo Ketsui",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FYuusha%20ni%20Narenakatta%20Ore%20wa%20Shibushibu%20Shuushoku%20wo%20Ketsui.jpg?alt=media&token=7bc808eb-83b0-4954-b796-03d93ec9b370",
      "watch": "false"
    },
    "-MYgwawexYZnRu1DXDcP": {
      "delete": "-MYgwawexYZnRu1DXDcP",
      "desc": "do cara la que tem snague pra controlar robo e é OP",
      "genero": "echi, romance, mecha",
      "titulo": "Kenzen robo daimidaler",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FKenzen%20robo%20daimidaler.jpg?alt=media&token=51a06daa-1666-49e0-ada6-f378e504ba77"
    },
    "-MYgyNKdByAlcUFsfNCP": {
      "Ass": "false",
      "delete": "-MYgyNKdByAlcUFsfNCP",
      "desc": "dos cara do mecha, parece fofinho, bom, vamo ve",
      "genero": "Mecha, Ação, Romance",
      "titulo": "Eureka Seven",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FEureka%20Seven.jpg?alt=media&token=f292d419-3572-4581-bb50-8f266761db1e",
      "watch": "false"
    },
    "-MZBV-cJXZHxrYDAEoDy": {
      "Ass": "true",
      "delete": "-MZBV-cJXZHxrYDAEoDy",
      "desc": "varios homem aranha",
      "genero": "Açao aventura Comedia",
      "titulo": "Homem aranha no aranha verso",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FHomem%20aranha%20no%20aranha%20verso.jpg?alt=media&token=2b6e8396-f385-4e7f-ad43-6c3fca0312cf"
    },
    "-MZBV79XoUlkfLmpPTge": {
      "Ass": "true",
      "delete": "-MZBV79XoUlkfLmpPTge",
      "desc": "O kong Perde",
      "genero": "Açao Drama",
      "titulo": "Kong vs Godzila",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FKong%20vs%20Godzila.jpg?alt=media&token=a4c12e01-00ff-4155-9952-66c1b2caf574"
    },
    "-MZBVFVQ9-c9Tm_NmVkC": {
      "delete": "-MZBVFVQ9-c9Tm_NmVkC",
      "desc": "Fo touro boiolinha la",
      "genero": "Comedia, Aventura",
      "titulo": "Ferdinando",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FFerdinando.jpg?alt=media&token=c0afb937-fd5d-4ea4-ac47-685cf919f762"
    },
    "-Mbm5WBH3x-bAWB4YRg4": {
      "Ass": "true",
      "delete": "-Mbm5WBH3x-bAWB4YRg4",
      "desc": "Do cara que levou um tiro no peito e virou o lorde demonio.",
      "genero": "Harem, Demonio, Açao",
      "titulo": "Hataru Maou Sama",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FHataru%20Maou%20Sama.jpg?alt=media&token=acf0a651-0d96-4b7f-a87f-3d1f7054560a"
    },
    "-Mbm6J8pEHcEXKNZ84UZ": {
      "Ass": "false",
      "delete": "-Mbm6J8pEHcEXKNZ84UZ",
      "desc": "Das minininha que fica na zombie land",
      "genero": "Zombie, Ação, Ecchi",
      "titulo": "Zombie Land Saga",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FZombie%20Land%20Saga.jpg?alt=media&token=8745a7fc-7823-40d5-84fc-c7539403c208"
    },
    "-MemQIJhautUMgqqBYGJ": {
      "Ass": "false",
      "delete": "-MemQIJhautUMgqqBYGJ",
      "desc": "Sei nao man mas quero ver",
      "genero": "Chorante",
      "prio": "1",
      "titulo": "To your eternity",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FTo%20your%20eternity.jpg?alt=media&token=57c5d98d-5218-4c9e-b0ba-3f74dcb3f20f",
      "watch": "false"
    },
    "-Mg7HlU4jZHMHOwWxeuL": {
      "delete": "-Mg7HlU4jZHMHOwWxeuL",
      "desc": "filme do cara la q n sente dor e tem poderes parece top",
      "genero": "Açao, Ficçao cientifica",
      "titulo": "The Unhealer",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FThe%20Unhealer.jpg?alt=media&token=c8a29900-63c2-4d79-91ae-6a88385e60de"
    },
    "-MgGuq-2R-g-uQQT_8H1": {
      "delete": "-MgGuq-2R-g-uQQT_8H1",
      "desc":
          "Do cara la das pernas mecanicas que é fodao, corre pra karolho fodasso",
      "genero": "Acão, Ficção cientifica",
      "prio": "1",
      "titulo": "O sinal: Frequencia de medo",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FO%20sinal%3A%20Frequencia%20de%20medo.jpg?alt=media&token=5c7106fe-7ed8-4c36-8998-c688843761f6"
    },
    "-MgMTEK-2FQxfSGRhnFD": {
      "Ass": "true",
      "delete": "-MgMTEK-2FQxfSGRhnFD",
      "desc": "Do povo la da espada, top de mais",
      "genero": "Espada, Açao, Suspense",
      "titulo": "Akame ga Kill",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FAkame%20ga%20Kill.jpg?alt=media&token=43917bb3-a30d-45b1-b0d4-3c710d71da43"
    },
    "-MgTYX9hinxokFSOaWHU": {
      "Ass": "true",
      "delete": "-MgTYX9hinxokFSOaWHU",
      "desc": "Das maid dragão la fofinha",
      "genero": "Ficçao, Ecchi, Açao",
      "titulo": "miss kobayashi's dragon maid",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2Fmiss%20kobayashi's%20dragon%20maid.jpg?alt=media&token=7eba753f-713d-4191-8d0b-ce66501dd93f",
      "watch": "false"
    },
    "-MgW6MLTXYb6oOYGnmII": {
      "delete": "-MgW6MLTXYb6oOYGnmII",
      "desc": "Do menino que pega a mascara do predador e mata todo mundo",
      "genero": "Açao, ficçao, Aliens",
      "titulo": "Predador: a caçada evoluiu",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FPredador%3A%20a%20ca%C3%A7ada%20evoluiu.jpg?alt=media&token=ba2a946f-d616-4d05-ab6e-092cc34dfe1c"
    },
    "-Mgg2gEYexoEZgHXe7Dr": {
      "delete": "-Mgg2gEYexoEZgHXe7Dr",
      "desc": "Animacao do dragaozinho la, mt bom",
      "genero": "Ficçao, Açao, Magia",
      "titulo": "Rava",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FRava.jpg?alt=media&token=41cc139e-ffb4-4f55-b079-8b1ab4b6296c"
    },
    "-MhH_oeb1dTq3lgvO1lH": {
      "delete": "-MhH_oeb1dTq3lgvO1lH",
      "desc": "Castores Zumbis",
      "genero": "Açao, Zumbi, Comédia",
      "titulo": "Zombeavers: Terror no lago",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FZombeavers%3A%20Terror%20no%20lago.jpg?alt=media&token=a5d1214b-2adf-4061-8a51-c0f030341788"
    },
    "-MhHaLFmW4Ro6N6TYvAt": {
      "delete": "-MhHaLFmW4Ro6N6TYvAt",
      "desc": "Pastor que vira um velociraptor e luta contra ninjas assassinos",
      "genero": "Açao, Suspense, Comédia",
      "titulo": "Velocipastor",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FVelocipastor.jpg?alt=media&token=fab30db1-3fb2-4891-ba6a-aa80ecba94bb"
    },
    "-MhHb0HdA42Wcl_Moa8T": {
      "delete": "-MhHb0HdA42Wcl_Moa8T",
      "desc": "tornado de tubaroes assassinos",
      "genero": "Açao, Comédia, Ficçao científica",
      "titulo": "Sharknado",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FSharknado.jpg?alt=media&token=4177c758-783a-4cb8-b4a3-14135c2998df"
    },
    "-MhLz_mMRMJ3MD6oC_8F": {
      "delete": "-MhLz_mMRMJ3MD6oC_8F",
      "desc": "Filme de romance bonitinho la",
      "genero": "Romance, Drama",
      "titulo": "Tenki no ko",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FTenki%20no%20ko.jpg?alt=media&token=576bac1c-7eda-4210-bdf6-e6b3a2e51c24"
    },
    "-MhMUI1Ehd7JYcepjHam": {
      "delete": "-MhMUI1Ehd7JYcepjHam",
      "desc":
          "Do cara la que tudo que ele joga no chão vira a namorada dele kaka",
      "genero": "Romance, Comédia, Dorama",
      "titulo": "You are not alone",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FYou%20are%20not%20alone.jpg?alt=media&token=5ab7f4fe-591d-4110-bd77-619701d48b90"
    },
    "-MhM_cyzFrdIL-1QGpJ9": {
      "delete": "-MhM_cyzFrdIL-1QGpJ9",
      "desc": "do cowboy la que é top d emais akakka",
      "genero": "Açao, Comédia, Oeste",
      "titulo": "the ballad of buster scrugs",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2Fthe%20ballad%20of%20buster%20scrugs.jpg?alt=media&token=d8e94a2b-b818-484a-8ab6-aa4b18ee8bcc"
    },
    "-MhVSQB9UgGmOMQqwp91": {
      "Ass": "true",
      "delete": "-MhVSQB9UgGmOMQqwp91",
      "desc": "Doidera la",
      "genero": "Comedia",
      "titulo": "Ueno Chan",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FUeno%20Chan.jpg?alt=media&token=6b787008-a768-4928-a5f5-75c24e19bc89",
      "watch": "false"
    },
    "-Mht-IWks6X7EllXAerA": {
      "delete": "-Mht-IWks6X7EllXAerA",
      "desc": "Do cara la que atira pelo dedo",
      "genero": "Açao, Fantasia, Ficção",
      "titulo": "linuyashiki",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2Flinuyashiki.jpg?alt=media&token=eeae6a3e-485b-473c-bca7-c058fb9cafbf"
    },
    "-MiNwi_GwhPhKYIAUAre": {
      "delete": "-MiNwi_GwhPhKYIAUAre",
      "desc": "Mt Fofinho",
      "genero": "Ficçao, Poderes",
      "titulo": "Azur Line",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FAzur%20Line.jpg?alt=media&token=1dcfd184-e618-4c9b-b056-96179da88d4a",
      "watch": "true"
    },
    "-MjLOdF2KvRnEmNbpwKK": {
      "delete": "-MjLOdF2KvRnEmNbpwKK",
      "desc": "Do cara la que tem um celular que tem poderes",
      "genero": "Ficçao, Comedia, Fantasia",
      "titulo": "Status Update",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FStatus%20Update.jpg?alt=media&token=d1367b47-d789-4a29-afa7-694c5c329cc5"
    },
    "-MjpvzzulGZ-6yvGA0yf": {
      "delete": "-MjpvzzulGZ-6yvGA0yf",
      "desc": "Cartoon mt bom mano do carunha que vai pro ceu mt bom",
      "genero": "Ficçao, Fantasia, Cartoom",
      "titulo": "Coco",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FCoco.jpg?alt=media&token=a16014ce-7beb-481a-9c6b-1fa325a21966"
    },
    "-Mm29cNG5hYdesEKY-39": {
      "Ass": "false",
      "delete": "-Mm29cNG5hYdesEKY-39",
      "desc": "Muito bom parece ser de vampiro",
      "genero": "ficçao, futurista",
      "prio": "1",
      "titulo": "Blood Blockade",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FBlood%20Blockade.jpg?alt=media&token=29ed9b2f-5c13-42bb-b373-f70b4504aa16",
      "watch": "true"
    },
    "-Mm2AHOF69VGG4ch74QK": {
      "Ass": "false",
      "delete": "-Mm2AHOF69VGG4ch74QK",
      "desc": "Dum assassino antigo mt bom",
      "genero": "açao, ficçao, romance",
      "prio": "1",
      "titulo": "the worlds finest assassins",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2Fthe%20worlds%20finest%20assassins.jpg?alt=media&token=3e286f4d-b0e5-437e-85e2-3f2bd8e5a4b3",
      "watch": "true"
    },
    "-Mm2B0W3qWMwJzjOURsu": {
      "Ass": "false",
      "delete": "-Mm2B0W3qWMwJzjOURsu",
      "desc": "da menina la que quer explorar o mundo mt bom",
      "genero": "Açao, Comedia, futurista",
      "prio": "1",
      "titulo": "sakugan",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2Fsakugan.jpg?alt=media&token=af9976eb-edfa-4302-a26f-951bee44b054",
      "watch": "true"
    },
    "-Mm2Bp39FozPe2M62f0n": {
      "Ass": "false",
      "delete": "-Mm2Bp39FozPe2M62f0n",
      "desc":
          "Anime mt boooooom caraaaa, dos maluco que nao pode ouvir musica, derrotar os bicho com os musicart e a parada toda, mt boooom manoo, animaçao foodaaa",
      "genero": "Açao, Ficção, Romance, Magia",
      "prio": "1",
      "titulo": "Takt op. destinity",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FTakt%20op.%20destinity.jpg?alt=media&token=024ad22b-f654-4a7a-8d10-1400324d47fd",
      "watch": "true"
    },
    "-Mm2D0lvSivE3cOYMBBK": {
      "Ass": "true",
      "delete": "-Mm2D0lvSivE3cOYMBBK",
      "desc":
          "do cara la que pode recolocar as partes do corpo, mt triste mt bom esse anime mano",
      "genero": "Magia, Açao, Drama",
      "prio": "1",
      "titulo": "UQ holder",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FUQ%20holder.jpg?alt=media&token=9a138c31-5e30-4773-bb37-7217ba28f163",
      "watch": "false"
    },
    "-Mm4w92woagAZ-cgiNuj": {
      "delete": "-Mm4w92woagAZ-cgiNuj",
      "desc": "Do cara la que é tipo o tony stark mt foda",
      "genero": "Açao, Ficçao, Medieval",
      "titulo": "Kabaneri of the iron fortress",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FKabaneri%20of%20the%20iron%20fortress.jpg?alt=media&token=0cfda6de-01d1-40bc-8fee-5cf23886d9d1"
    },
    "-MmDA4f4M_B-miN65MLM": {
      "delete": "-MmDA4f4M_B-miN65MLM",
      "desc": "Da menina doida la kakaka muito engraçado kaka",
      "genero": "Comedia, Romance",
      "titulo": "Castle Town Dandelion",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FCastle%20Town%20Dandelion.jpg?alt=media&token=3c0c8ee1-cf7c-48cb-a407-c72aee488694"
    },
    "-MmabOwqi8rxujtuDEq3": {
      "delete": "-MmabOwqi8rxujtuDEq3",
      "desc": "Anime mt fofinho da menina q n pode falar.",
      "genero": "Comedia, Romance",
      "titulo": "Komi san cant communicate",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FKomi%20san%20cant%20communicate.jpg?alt=media&token=095c61ce-94c8-46dd-a87b-5cd0c8ce4038",
      "watch": "true"
    },
    "-MmcMGi3G8Z1XV5VWNxB": {
      "delete": "-MmcMGi3G8Z1XV5VWNxB",
      "desc":
          "Anime de Mecha, to com muita preguiça, mas pode ser que seja bom.",
      "genero": "Mecha, Drama, Romance",
      "titulo": "kakumeiki valvrave",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2Fkakumeiki%20valvrave.jpg?alt=media&token=60ca4f7c-bd33-4246-a0e8-647da50ce79c",
      "watch": "false"
    },
    "-Mn02R2M05cDtmfHTe5G": {
      "delete": "-Mn02R2M05cDtmfHTe5G",
      "desc": "Da mininha la do teleporte, mt engraçado akkalaka",
      "genero": "Comedia, Ficçao, Magia",
      "titulo": "Dropout",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FDropout.jpg?alt=media&token=675db57a-c20c-4fe1-bdd9-2ba0bd90eefd",
      "watch": "false"
    },
    "-MnUQ4PPKw0ZYOw4HQHz": {
      "Ass": "false",
      "delete": "-MnUQ4PPKw0ZYOw4HQHz",
      "desc": "Mt bom fofinho e engraçado.",
      "genero": "Isekai, Comédia, Magia",
      "prio": "1",
      "titulo": "Mishuku Tensei",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2FMishuku%20Tensei.jpg?alt=media&token=1bc23da1-f407-4ee4-b648-09f8487b1af5",
      "watch": "false"
    },
    "-Mny3jo67LCgLcP-93UV": {
      "Ass": "false",
      "delete": "-Mny3jo67LCgLcP-93UV",
      "desc": "Do cara la que se transforma em gato, mt fofiinho 🖤",
      "genero": "Magia, Ficçao, Comédia",
      "titulo": "Servamp",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FServamp.jpg?alt=media&token=acd9648f-acdc-4c2b-b117-38ba75b955fa",
      "watch": "false"
    },
    "-Mo9fZpKi46cMyMHecJq": {
      "delete": "-Mo9fZpKi46cMyMHecJq",
      "desc": "Do cara la que é mó cimedia akkaa mt bom",
      "genero": "Magia, Ficçao, Isekay",
      "prio": "1",
      "titulo": "Musoku Tensei",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FMusoku%20Tensei.jpg?alt=media&token=850e0ded-1c4f-4808-b266-56fe82fac0c2"
    },
    "-MortTYnS7ii2r6ggdv3": {
      "delete": "-MortTYnS7ii2r6ggdv3",
      "desc": "Do menininho la que parece ser bem triste.",
      "genero": "Drama, Açao",
      "titulo": "Karakuri Circus",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FKarakuri%20Circus.jpg?alt=media&token=97d23922-a7dc-4faa-8994-f2dfbeaa8ab1"
    },
    "-MpDA1QFiFSoLWV7CwMz": {
      "delete": "-MpDA1QFiFSoLWV7CwMz",
      "desc": "Do cara la que é o hobin wood, mt bom",
      "genero": "Ação, Isekai, Fantasia",
      "titulo": "Lord Marksman",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FLord%20Marksman.jpg?alt=media&token=c3b05ab8-293b-4f27-b756-40721870b830"
    },
    "-MpDDr-kssepfonnr-Lb": {
      "Ass": "true",
      "delete": "-MpDDr-kssepfonnr-Lb",
      "desc": "Do cara la que é mago e tem a chama azul e é op.",
      "genero": "Magia, Ficçao, Açao",
      "titulo": "Kenja no mago",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FKenja%20no%20mago.jpg?alt=media&token=6edd4e54-7d81-4995-9f0a-8a6aeac5d060",
      "watch": "false"
    },
    "-MpYM7GGnBnn6e9QOF2_": {
      "delete": "-MpYM7GGnBnn6e9QOF2_",
      "desc": "Do cara la que é invejado mt bom, mt bom mesmo",
      "genero": "Comedia, Romance, Magia",
      "prio": "1",
      "titulo": "Witch Craft Works",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FWitch%20Craft%20Works.jpg?alt=media&token=0777ca26-34a3-42f5-b09c-572233fc5ac8"
    },
    "-MpiaLfXnJ-YJfuXHFLP": {
      "delete": "-MpiaLfXnJ-YJfuXHFLP",
      "desc": "Filme da menina que toca violino mt bom msm",
      "genero": "Ficçao, Fantasia, Drama",
      "prio": "1",
      "titulo": "Abominavel",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FAbominavel.jpg?alt=media&token=e6251900-af2c-4c75-b021-565d03e6a42e"
    },
    "-Mqc7NrwLgfJWhdF4FTf": {
      "Ass": "true",
      "delete": "-Mqc7NrwLgfJWhdF4FTf",
      "desc": "Do cara la que é aspirante a rei demonio Muuuuito bom",
      "genero": "Isekay, Mao, Magia",
      "titulo": "Marashita iruma kun",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FMarashita%20iruma%20kun.jpg?alt=media&token=86e067d1-ca33-4cff-89d3-664898c98196",
      "watch": "false"
    },
    "-Mqc89BGaekjbdKDOqNe": {
      "delete": "-Mqc89BGaekjbdKDOqNe",
      "desc":
          "do cara la que é op vai pra outro mundo e tem um pider lendario muuito foda tmbm",
      "genero": "shounee, isekai, acao",
      "prio": "1",
      "titulo": "kiba",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2Fkiba.jpg?alt=media&token=a93242cc-8a01-4b3e-8045-b3ebccd3b709"
    },
    "-Mqc9Cdbwf-S-2larQHL": {
      "delete": "-Mqc9Cdbwf-S-2larQHL",
      "desc":
          "Do cara la que nasce numa familia rica que na verdade é pobre mas ele é mt forte e vai construir sua riquesa com sua força mt bom tmbm",
      "genero": "isekai, comedia, harem",
      "prio": "1",
      "titulo": "Hashinan tte, sore wa nai desho",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FHashinan%20tte%2C%20sore%20wa%20nai%20desho.jpg?alt=media&token=0ef475f2-37af-4bdc-a02d-e13613582f95"
    },
    "-MqcBfveN6TYX5iU-CGu": {
      "delete": "-MqcBfveN6TYX5iU-CGu",
      "desc":
          "do cara la que é o maior gamer dp mundo é teletransportado tem que salvar a mina dele, ele é mt forte",
      "genero": "isekai, Echi, Açao",
      "prio": "1",
      "titulo": "Gin no guardian",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FGin%20no%20guardian.jpg?alt=media&token=88894685-c083-4b37-a057-012429da8288"
    },
    "-MqcCeJSUvOEfSIOdv1E": {
      "delete": "-MqcCeJSUvOEfSIOdv1E",
      "desc":
          "do cara la que foi enviado pr aputro mundo pra ser pai de 12 criança, parece interessante",
      "genero": "echi, isekai",
      "titulo": "Comception",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FComception.jpg?alt=media&token=68075369-f90a-4dd4-b946-a6a325bc878e"
    },
    "-MqcFBDi8zvqz1VUOhLw": {
      "delete": "-MqcFBDi8zvqz1VUOhLw",
      "desc": "Mano mt bom confia, só assiste logo",
      "genero": "isekai, echi,",
      "prio": "1",
      "titulo": "seiren gensouko",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2Fseiren%20gensouko.jpg?alt=media&token=fa85d781-a555-48e5-a7c7-13be2175feed"
    },
    "-MqcFs_kyHoRBEIr2dXt": {
      "delete": "-MqcFs_kyHoRBEIr2dXt",
      "desc":
          "na mina la que é ma mas toma decisao boa, indicaçao do tio bruce",
      "genero": "isekai",
      "titulo": "My Next Life as a Villainess: All Routes Lead to Doom!",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FMy%20Next%20Life%20as%20a%20Villainess%3A%20All%20Routes%20Lead%20to%20Doom!.jpg?alt=media&token=836cdc41-1fa1-4116-a2e1-4bbece45ac5d"
    },
    "-MqcGaOydV1_emyF3_Aq": {
      "delete": "-MqcGaOydV1_emyF3_Aq",
      "desc":
          "do cara la que rensasce no outro mundo com a mente antiga, é mt inteligente e se torna uma criança forte",
      "genero": "isekai, echi, magia",
      "prio": "1",
      "titulo": "Moshuku tensei",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FMoshuku%20tensei.jpg?alt=media&token=21cd989d-a44f-485e-a138-afa783721182"
    },
    "-MqcJlATHugAwdWAigfy": {
      "delete": "-MqcJlATHugAwdWAigfy",
      "desc":
          "do cara la que é fraquinho traz a deusa do outro mundo com ele e tem poder de roubar coisas",
      "genero": "echi,, isekai, romanc3",
      "titulo": "Konosuba",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FKonosuba.jpg?alt=media&token=f38635b2-bd0a-4165-b36c-7d8985659a44"
    },
    "-Mqh5vlnGCo2r11iWQj0": {
      "delete": "-Mqh5vlnGCo2r11iWQj0",
      "desc": "Mt fofo assiste vai, Confia",
      "genero": "Romance, Drama",
      "prio": "1",
      "titulo": "Given",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2FGiven.jpg?alt=media&token=56776605-54f5-4f64-b9e3-b9122c1ed014"
    },
    "-Mqk3XWTpOD9hyK8VzRP": {
      "Ass": "true",
      "delete": "-Mqk3XWTpOD9hyK8VzRP",
      "desc": "Indicaçao do fael, confia",
      "genero": "Isekai, comedia, magia",
      "prio": "1",
      "titulo": "shinchou yusha",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2Fshinchou%20yusha.jpg?alt=media&token=f135f20d-760b-413a-9627-8be00ef8903b",
      "watch": "false"
    },
    "-Mqk6DAV1tRwTcouzB4e": {
      "delete": "-Mqk6DAV1tRwTcouzB4e",
      "desc":
          "do cara la que vai ora outro mundo e uma gorila se apaixona por ele e depois ela vira uma waifu, mt engraçada akkska",
      "genero": "echi, isekai, romance",
      "prio": "1",
      "titulo": "shinka no mi",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/stormapp-80b5f.appspot.com/o/ImageAnime%2F5FvkU0eYRXahGA0Ab9N3yJbUJMJ2%2Fshinka%20no%20mi.jpg?alt=media&token=e4890366-8e20-47c4-b08f-fc5ee30fca7d"
    }
  };
}

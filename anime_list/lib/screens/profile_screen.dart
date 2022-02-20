import 'package:anime_list/components/animes_screen.dart';
import 'package:anime_list/components/app_drawer.dart';
import 'package:anime_list/components/home_screen.dart';
import 'package:anime_list/components/row_anime_list.dart';
import 'package:anime_list/components/titled_row_list.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/utils/list_tipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfile userProfile =
        ModalRoute.of(context)?.settings.arguments as UserProfile;
    bool isSelfUser = userProfile.id == (Provider.of<UserProfileProvider>(context).userProfile?.id ?? false);
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: AppDrawer(),
      body: CustomScrollView(
        
        slivers: [
          SliverAppBar(
            pinned: true,
            // floating: true,
            // snap: true,
            expandedHeight: 350,
            backgroundColor: Colors.black54,

            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                userProfile.name,
              ),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    minRadius: 80,
                    maxRadius: 100,
                    foregroundImage: NetworkImage(userProfile.profileImageUrl),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon:isSelfUser ? const Icon(Icons.favorite, color: Colors.red,) : const Icon(Icons.favorite_border),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          isSelfUser? "Editar" :"Adicionar",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(92),
                              ),
                            ),
                            primary:isSelfUser? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                            onPrimary: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.email_outlined,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: kToolbarHeight + 3,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  color: Colors.grey[850],

                  child: Column(
                    children: const [
                      TitledRowList(
                        title: "Assistindo",
                        hasArrow: true,
                        listTipe: ListTipe.WATCHING,
                      ),
                      TitledRowList(
                        title: "Prioridades",
                        hasArrow: true,
                        listTipe: ListTipe.PRIO,
                      ),
                      TitledRowList(
                        title: "Para Assistir",
                        hasArrow: true,
                        listTipe: ListTipe.NORMAL,
                      ),
                      TitledRowList(
                        title: "Concluidos",
                        hasArrow: true,
                        listTipe: ListTipe.FINISHED,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

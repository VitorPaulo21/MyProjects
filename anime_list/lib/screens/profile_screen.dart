import 'package:anime_list/components/animes_screen.dart';
import 'package:anime_list/components/app_drawer.dart';
import 'package:anime_list/components/home_screen.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfile userProfile =
        ModalRoute.of(context)?.settings.arguments as UserProfile;
    return Scaffold(
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
                        icon: const Icon(Icons.favorite_border),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Adicionar",
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
                            primary: Theme.of(context).colorScheme.secondary,
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
            child: HomeScreen(),
          )
        ],
      ),
    );
  }
}

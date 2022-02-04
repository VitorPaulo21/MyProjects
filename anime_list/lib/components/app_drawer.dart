import 'package:anime_list/providers/auth.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/screens/user_details_screen.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfileProvider profileProvider =
        Provider.of<UserProfileProvider>(context);
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return const AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            contentPadding: EdgeInsets.all(0),
                            content: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: UserDetailsScreen()),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          foregroundImage: CachedNetworkImageProvider(
                              profileProvider.userProfile?.profileImageUrl ??
                                  ""),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          profileProvider.userProfile?.name ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Divider(
                    color: Colors.grey[400],
                  ),
                ),
                ListTile(
                  onTap: ModalRoute.of(context)?.settings.name == AppRoutes.HOME
                      ? () => Navigator.of(context).pop()
                      : () => Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.HOME),
                  textColor:
                      ModalRoute.of(context)?.settings.name == AppRoutes.HOME
                          ? Colors.red
                          : Colors.white,
                  leading: const Icon(Icons.home),
                  title: const Text(
                    "Home",
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Perfil"),
                ),
                const ListTile(
                  enabled: false,
                  leading: Icon(Icons.message),
                  title: Text("Mensagens"),
                ),
                const ListTile(
                  leading: Icon(Icons.people),
                  title: Text("Amigos"),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                minLeadingWidth: 15,
                iconColor: Colors.grey[500],
                textColor: Colors.grey[500],
                leading: const Icon(Icons.settings),
                title: const Text("Configuraões"),
              ),
              Divider(
                color: Colors.grey[400],
              ),
              ListTile(
                minLeadingWidth: 15,
                iconColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.secondary,
                leading: const Icon(Icons.highlight_remove),
                title: const Text("logout"),
                onTap: () {
                  Provider.of<Auth>(context, listen: false).logout().then(
                        (value) => Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.INITIAL),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
// InkWell(
//               onTap: () {
//                 Provider.of<Auth>(context, listen: false).logout().then(
//                     (value) => Navigator.of(context)
//                         .pushReplacementNamed(AppRoutes.INITIAL));
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.highlight_remove,
//                       color: Theme.of(context).colorScheme.secondary,
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       "Logout",
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.secondary),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
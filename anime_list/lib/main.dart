import 'package:anime_list/components/animes_screen.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/providers/auth.dart';
import 'package:anime_list/providers/delete_observer.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/screens/anime_details_screen.dart';
import 'package:anime_list/screens/anime_list_screen.dart';
import 'package:anime_list/screens/auth_screen.dart';
import 'package:anime_list/screens/crate_anime_screen.dart';
import 'package:anime_list/screens/friends_screen.dart';
import 'package:anime_list/screens/no_connection_screen.dart';
import 'package:anime_list/screens/profile_screen.dart';
import 'package:anime_list/screens/user_details_screen.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/screens/initial_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


//on botonsheet recognize if the anime id is the same from the user id
//cause not show a botomsheet with add and share only, same for the anime info
//TODO modify the anime details if the user is other than not the self user
//TODO change the icon for the continue wath to add icon
//TODO remove the finalize and delete buttons from the continue watching item
//implement the edit profile
//TODO resolver bug do porque a lista do perfil nao mostra com a uid solicitada

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AnimeList>(
          create: (_) => AnimeList(context),
        ),
        ChangeNotifierProvider<DeleteObserver>(
          create: (_) => DeleteObserver(),
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (_) => UserProfileProvider(),
        ),
        ChangeNotifierProxyProvider<UserProfileProvider, Auth>(
          create: (_) => Auth(null),
          update: (ctx, profileProvider, previous) {
            return Auth(profileProvider);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.dark().copyWith(
            primary: Colors.grey[800],
            secondary: Colors.red,
            onPrimary: Colors.red,
            onSecondary: Colors.white,
          ),
          textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
                selectionHandleColor: Colors.red,
              ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.INITIAL: (_) => InitialScreen(),
          AppRoutes.AUTH: (_) => AuthScreen(),
          AppRoutes.HOME: (_) => AnimeListScreen(),
          AppRoutes.CREATE_ANIME: (_) => CreateAnimeScreen(),
          AppRoutes.ANIME_LIST: (_) => AnimesScreen(),
          AppRoutes.ANIME_DETAILS: (_) => AnimeDetailsScreen(),
          AppRoutes.NO_CONNECTION: (_) => NoConnectionScreen(),
          AppRoutes.USER_DETAILS_EDIT: (_) => UserDetailsScreen(),
          AppRoutes.PROFILE_SCREEN: (_) => ProfileScreen(),
          AppRoutes.FRIENDS_SCREEN: (_) => friendsScreen(),
        },
      ),
    );
  }
}

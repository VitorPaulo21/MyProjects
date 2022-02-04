import 'package:anime_list/components/auth_form.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/auth.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/check_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  Future<void> initialize(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (await CheckConnection.isConnected()) {
      SharedPreferences sharedData = await SharedPreferences.getInstance();
      if (sharedData.containsKey("email") &&
          sharedData.containsKey("password")) {
        if (sharedData.getString("email")!.isNotEmpty &&
            sharedData.getString("password")!.isNotEmpty) {
          try {
            await Provider.of<Auth>(context, listen: false).Autenticate(
              LoginStyle.LOGIN,
              {
                "email": sharedData.getString("email")!,
                "password": sharedData.getString("password")!
              },
            );
          } on Exception catch (e) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH);
            return;
          }
          await Provider.of<UserProfileProvider>(context, listen: false)
              .setUserProfile();
          if (Provider.of<UserProfileProvider>(context, listen: false)
                  .userProfile ==
              null) {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.USER_DETAILS_EDIT);
          } else if (!Provider.of<UserProfileProvider>(context, listen: false)
              .isvalidUser()) {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.USER_DETAILS_EDIT);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          }
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.NO_CONNECTION);
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize(context);
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

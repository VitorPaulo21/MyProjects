import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/check_connection.dart';
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool isLoading = false;
  Future<void> checkConnection() async {
    bool conected = await CheckConnection.isConnected();
    if (conected == true) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.INITIAL);
    } else {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        isLoading = conected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Animes"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const FittedBox(
                    child: Text(
                      "Sem Conexao com a internet !",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      checkConnection();
                    });
                  },
                  child: const Text(
                    "Tentar Novamente",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      primary: Theme.of(context).colorScheme.secondary,
                      onPrimary: Colors.white),
                )
              ],
            ),
    );
  }
}

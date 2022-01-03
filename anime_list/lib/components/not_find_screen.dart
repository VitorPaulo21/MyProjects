import 'package:anime_list/utils/app_routes.dart';
import 'package:flutter/material.dart';

class NotFindScreen extends StatelessWidget {
  final String? message;
  const NotFindScreen({
    this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool emptymessage = message == null;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "lib/assets/luffy_like.png",
            height: 270,
            fit: BoxFit.fitHeight,
          ),
          FittedBox(
            child: Text(
              !emptymessage
                  ? message.toString()
                  : "Parece que ainda nao temos nada cadastrado!",
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          if (emptymessage)
            TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(width: 2, color: Colors.white)),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.CREATE_ANIME);
                },
                child: const Text(
                  "Que tal cadastrar algo?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))
        ],
      ),
    );
  }
}

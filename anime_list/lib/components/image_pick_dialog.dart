import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagePickDialog extends StatelessWidget {
  const ImagePickDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> data = GlobalKey<FormState>();
    String ImageUrl = "";
    return AlertDialog(
      title: const Text("Selecione uma imagem"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            minLeadingWidth: 10,
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.computer,
                  size: 20,
                ),
              ],
            ),
            title: Form(
              key: data,
              child: TextFormField(
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (txt) {
                  if (data.currentState!.validate()) {
                    data.currentState!.save();
                    Navigator.of(context).pop(ImageUrl);
                  }
                },
                decoration: DecorationWithLabel("Url da imagem"),
                expands: false,
                onSaved: (url) {
                  ImageUrl = url ?? "";
                },
                validator: (url) {
                  String urlSafe = url ?? "";
                  if (urlSafe.trim().isEmpty) {
                    return "A url nao pode ser vazia";
                  }
                  if (!Uri.parse(urlSafe).isAbsolute) {
                    return "Url Invalida";
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
              enabled: false,
              onTap: () {},
              minLeadingWidth: 10,
              leading: const Icon(
                Icons.image,
                size: 20,
              ),
              title: const Text("Galeria (Futuramente)"))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            if (data.currentState!.validate()) {
              data.currentState!.save();
              Navigator.of(context).pop(ImageUrl);
            }
          },
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

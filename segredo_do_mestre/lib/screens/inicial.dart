import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_utils/flutter_file_utils.dart';
import 'package:flutter_file_utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class Inicial extends StatelessWidget {
  const Inicial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segredo do Mestre"),
      ),
      body: FutureBuilder(
          future: _files(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].path),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            } else {
              return Center(child: Text("Erro"));
            }
          }),
    );
  }

  _files() async {
    var root = await getExternalStorageDirectories();
    var files = await FileManager(root: root.toList()[0], filter: SimpleFileFilter()).walk().toList();
    return files;
  }
}

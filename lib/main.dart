import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_game/globals.dart';
import 'package:story_game/screens/main_screen.dart';
import 'package:hive/hive.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'database/id.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(IdAdapter());

  var idBox = await Hive.openBox('progress');
  if(idBox.length == 0) idBox.add(Id(0, []));     //Initialize with beginning block if its first time app is started

  runApp(MaterialApp(home: MyApp(), theme: ThemeData.dark(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    readJson();             //We can't wait for this to finish and it's driving me insane
                            //This is the cause for the error that happens at the beginning of the game.

    return FutureBuilder(
      future: Hive.openBox('progress'),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          else return SafeArea(
            child: Scaffold(
              body: MainScreen()
            )
          );
        } else return Center(child: CircularProgressIndicator());
      }
    );
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/story.json');
    final data = await json.decode(response);
    story.data = data["story"];
  }
}

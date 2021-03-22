import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_game/globals.dart';
import 'package:story_game/screens/main_screen.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), theme: ThemeData.dark(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    readJson();

    return story.data.length != 0
    ? SafeArea(
        child: Scaffold(
          body: MainScreen()
        )
      )
    : Center(child: CircularProgressIndicator());
  }


}

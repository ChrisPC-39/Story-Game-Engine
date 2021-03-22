import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Story story = Story();

class Story {
  //data is a list that contains all the values in the .json file.
  //Each index contains a "block".
  //Its basically used like a hash map to find the current and next ID for each block
  List data = [];
}

TextStyle defaultStyle() {
  return TextStyle(
    fontSize: 20,
    color: ThemeData.dark().primaryColor
  );
}

TextStyle defaultButtonStyle() {
  return TextStyle(
      fontSize: 20,
      color: Colors.indigo
  );
}

//This looks at the current story block and returns the next ID is in the whole list
int findNextIndex(List currChoice) {
  return story.data[currChoice.elementAt(currChoice.length - 1)["id"]]["next"];
}

//This looks at the current story block and returns the current ID
int findCurrIndex(List currChoice) {
  return story.data[currChoice.elementAt(currChoice.length - 1)["id"]]["id"];
}

Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/story.json');
  final data = await json.decode(response);
  story.data = data["story"];
  //How does this work without setState(() {}); ???????????????????????
}
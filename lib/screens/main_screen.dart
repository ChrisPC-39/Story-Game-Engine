import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:story_game/database/id.dart';
import 'package:story_game/globals.dart';
import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List blockList = [];

  @override
  Widget build(BuildContext context) {
    //initialize blockList only once (at the beginning of the game)
    if(!hasStarted(blockList)) _initBlockList();

    return Column(
      children: [
        _buildDelete(),
        _buildListView(),
        _buildChoices()
      ]
    );
  }

  Widget _buildListView() {
    return Flexible(
        child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: blockList.length,
        itemBuilder: (context, index) {
          return _buildTextContainer(index);
        }
      )
    );
  }

  Widget _buildTextContainer(int index) {
    return Container(
      child: Center(child: Text(blockList[index]["data"], style: defaultStyle())),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(10))
      )
    );
  }

  Widget _buildChoices() {
    int currIndex = findCurrIndex(blockList);

    if (story.data[currIndex]["option1"] != "none")
      return _buildButtonRow(currIndex);
    else
      Future.delayed(const Duration(milliseconds: 1000), () { _updateLists(currIndex); });
      //Update the list with a delay if no options are found.

    return Container();
  }

  Widget _buildButtonRow(int currIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTextButton(currIndex, optionNr: 1),
        _buildTextButton(currIndex, optionNr: 2),
      ]
    );
  }

  Widget _buildTextButton(int currIndex, {int optionNr = 1}) {
    return Flexible(
      child: TextButton(
        onPressed: () => _updateLists(currIndex, optionNr),
        child: Text(story.data[currIndex]["option$optionNr"], style: defaultButtonStyle())
      )
    );
  }

  //If you want to delete everything, you must click this and re-run the program.
  //This is here just for testing
  Widget _buildDelete() {
    return GestureDetector(
        child: Icon(Icons.delete),
        onTap: () => setState(() { Hive.box('progress').clear(); })
    );
  }

  void _initBlockList() {
    var box = Hive.box('progress');
    var curr = box.getAt(0) as Id;

    setState(() {
      if(curr.id == 0) blockList.add(story.data[0]);  //If the ID is 0, it means it's the first time the game starts
      else {
        for(int i = 0; i < curr.block.length; i++)
          blockList.add(curr.block[i]);
      }
    });
  }

  void _updateLists(int currIndex, [int optionNr = 1]) {
    int nextIndex = findNextIndex(blockList, optionNr);
    setState(() { blockList.add(story.data[nextIndex]); });
    Hive.box('progress').putAt(0, Id(currIndex, blockList));
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
}
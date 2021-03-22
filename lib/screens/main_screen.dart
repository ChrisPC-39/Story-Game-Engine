import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:story_game/globals.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List currChoice = [];

  @override
  Widget build(BuildContext context) {
    if(currChoice.length == 0) _initGame();

    return Column(
      children: [
        _buildListView(),
        _buildChoices()
      ]
    );
  }

  void _initGame() {
    setState(() { currChoice.add(story.data[0]); });
  }

  Widget _buildListView() {
    return Flexible(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: currChoice.length,
        itemBuilder: (context, index) {
          return _buildTextContainer(index);
        }
      )
    );
  }

  Widget _buildTextContainer(int index) {
    return Container(
      child: Center(child: Text(currChoice[index]["data"], style: defaultStyle())),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(10))
      )
    );
  }

  Widget _buildChoices() {
    int nextIndex = findNextIndex(currChoice);
    int currIndex = findCurrIndex(currChoice);

    if (story.data[currIndex]["option1"] != "none") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TextButton(
              onPressed: () { setState(() { currChoice.add(story.data[nextIndex]); }); },
              child: Text(story.data[currIndex]["option1"], style: defaultButtonStyle())
            )
          ),

          Flexible(
            child: TextButton(
              onPressed: () {},
              child: Text(story.data[currIndex]["option2"], style: defaultButtonStyle())
            )
          )
        ]
      );
    } else {
      //Add the next block after a delay if the current block has no options
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() { currChoice.add(story.data[nextIndex]); });
      });

      return Container();
    }
  }
}
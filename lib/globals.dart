Story story = Story();

class Story {
  //data is a list that contains all the values in the .json file.
  //Each index contains a "block".
  //Its basically used like a hash map to find the current and next ID for each block
  List data = [];
}

//This looks at the current story block and returns the next ID is in the whole list
int findNextIndex(List currChoice, int optionNr) {
  return story.data[currChoice.elementAt(0)["id"]]["next$optionNr"];
}

//This looks at the current story block and returns the current ID
int findCurrIndex(List currChoice) {
  return story.data[currChoice.elementAt(0)["id"]]["id"];
}

bool hasStarted(List blockList) {
  return blockList.length == 0 ? false : true;
}
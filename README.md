# Story-Game-Engine

Open source, made in Flutter, for Android/iOS (tested only on Android)

## About

This branch contains basic graphics. Besides a small hiccup (detailed at the end of the file), it should work with the given template.

## How to write a story

Navigate to the assets/story.json
The template to write a story with 2 choices is written there. All fields can be customized, but they CAN'T be deleted. More can be added, but the code doesn't support new fields by default. (You won't get any errors, but they won't show up either).

Let's see an example:

{

  "story": [ -------------------> Name of the list that contains all blocks. (Basically the whole story)
  
    { --------------------------> start of block
      "id": 0,  ----------------> Id of an individual block. Blocks CAN'T have the same IDs!
      
      "data": "Welcome!", ------> This is the content of the block. Anything can go here (besides emojis and probably some symbols. Be careful!)
      
      "option1": "Option 1", ---> The "option1" and "option2" fields contain the text of a button
      
      "option2": "Option 2", ---> The options can be set to "none", which will cause the next block to show after a 1 second delay (see main_screen.dart line 59)
      
      "next1": 1, --------------> "next1" and "next2" point to the IDs of the blocks you want the choices to go to. These IDs MUST exist in the .json file!
      
      "next2": 1
    } --------------------------> end of block
  ]
  
}

IMPORTANT: MAKE SURE NO BLOCKS POINT TO ID: 0! Keep ID 0 as an introduction. If you have another block point to 0, all the progress will be lost. *NEVER* return to this ID.

## Change the .json file

If you want to change the .json file (e.g. put it in another folder), check main.dart line 52 -> change the path
If you want to change the title "story" to something else, check main.dart line 54 -> change the title from the brackets to ["yourTitle"]

## Small hiccup

Reading the Json file takes some time, which causes the app to show an error screen for a couple of seconds (if you are in debug mode). I don't know how to fix that yet.
If you are in release mode, this problem will not show up (you will only see a blank screen for a few seconds).

## TODO:

Scroll down when an item is added to the list (currently the user is forced to scroll to see new blocks).

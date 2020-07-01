
import 'package:flutter/material.dart';
import 'package:noticetracker/stats/statsDetails/StatsDetailsScreen.dart';

import 'Word.dart';

class WordCard{


  static Widget wordTemplate(Word word, BuildContext context){
    return _generateWidgetCard(word, context);
  }

  static Widget _generateWidgetCard(Word word, BuildContext context) {

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text("Sentence : ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25),),
                    Text("${word.sentence}",
                    style: TextStyle(
                        fontSize: 20,
                    ),)
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Text("Occurence : ", style: TextStyle(fontWeight:
                   FontWeight.bold,
                  fontSize: 25),),
                   Text("${word.occurrence}",
                       style: TextStyle(
                         fontSize: 20,))],
                ),
              )
            ],
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.open_in_new),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StatsDetailsScreen(word: word)
                    ));
              },
            ),
          )
        ],

      ),
    );
  }



}
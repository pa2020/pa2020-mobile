
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
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.blue)
      ),
      child: GestureDetector(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Sentence : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25),),
                        Text("${word.sentence}",
                          textAlign: TextAlign.left,
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
                        Text("Occurence : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25),),
                        Text("${word.occurrence}",
                            style: TextStyle(
                              fontSize: 20,))],
                    ),
                  )
                ],
              )
            ],

          ),
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StatsDetailsScreen(word: word)
              ));
        },
      ),
    );
  }



}
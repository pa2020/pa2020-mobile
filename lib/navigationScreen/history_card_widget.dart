import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/enumerate/EmotionEnum.dart';
import 'package:noticetracker/request/AnalyzeRequest.dart';
import 'package:noticetracker/State.dart';
import 'package:noticetracker/request/Request.dart';


class HistoryCard {



  Widget requestTemplate(Request req) {
    AssetImage img = formatImage(req.analyzedRequest);

    String date = formatDate(req.createTime);

    return Container(
      decoration : BoxDecoration(
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image(
                image: img,
                height: 35,
                width: 70,
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      req.sentence,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    Text(
                      '$date',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    Text(
                      req.state,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    }

    String formatDate(DateTime date){
      return date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString()
          +" at "+date.hour.toString()+":"+date.minute.toString();
    }

    AssetImage formatImage(AnalyzedRequest req){
      try {
        switch (req.getSentiment()) {
          case EmotionEnum.positive:
            return AssetImage('assets/sentiment_meter_positive.png');
          case EmotionEnum.neutral:
            return AssetImage('assets/sentiment_meter_neutral.png');
          case EmotionEnum.negative:
            return AssetImage('assets/sentiment_meter_negative.png');
          default:
            return AssetImage('assets/sentiment_meter_not_processed.png');
        }
      }
      on NoSuchMethodError catch(e){
        return AssetImage('assets/sentiment_meter.png');
      }
    }

    String formatStatus(States states){
      switch(states.toString()){
        case "States.INIT" :
          return "Starting";
        case "States.RUNNING" :
          return "Running";
        case "States.FINISH" :
          return "Finsihed";
        default :
          return "bad formatz";
      }
    }

}
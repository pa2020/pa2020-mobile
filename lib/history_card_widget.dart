import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/Request.dart';
import 'package:noticetracker/State.dart';


class HistoryCard {



  Widget requestTemplate(Request req) {
    AssetImage img = formatImage(req);

    String date = formatDate(req.createdAt);

    String status = formatStatus(req.state);
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
                      status,
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

    AssetImage formatImage(Request req){
      if (req.state == States.DONE) {
        if (req.negative) {
          return AssetImage('assets/sentiment_meter_negative.png');
        } else if (req.positivy) {
          return AssetImage('assets/sentiment_meter_positive.png');
        } else if (req.neutral) {
          return AssetImage('assets/sentiment_meter_neutral.png');
        } else {
          throw new Error();
        }
      }else {
        return AssetImage('assets/sentiment_meter_not_processed.png');
      }
    }

    String formatStatus(States states){
      switch(states.toString()){
        case "States.DONE" :
          return "done";
        case "States.WAITING" :
          return "waiting";
        case "States.PROCESSING" :
          return "processing";
      }
    }

  HistoryCard();
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/State.dart';
import 'package:noticetracker/enumerate/EmotionEnum.dart';
import 'package:noticetracker/request/AnalyzeRequest.dart';
import 'package:noticetracker/request/Request.dart';

class HistoryCard {

  static Widget requestTemplate(Request req) {
    return _generateWidgetCard(req);
  }

  static  String formatDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString() +
        " at " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }

  static AssetImage formatImage(AnalyzedRequest req) {
    try {
      switch (req.getSentiment()) {
        case SentimentEnum.positive:
          return AssetImage('assets/sentiment_meter_positive.png');
        case SentimentEnum.neutral:
          return AssetImage('assets/sentiment_meter_neutral.png');
        case SentimentEnum.negative:
          return AssetImage('assets/sentiment_meter_negative.png');
        default:
          return AssetImage('assets/sentiment_meter_not_processed.png');
      }
    } on NoSuchMethodError catch (e) {
      print(e);
      return AssetImage('assets/sentiment_meter.png');
    }
  }

  static String formatStatus(States states) {
    switch (states.toString()) {
      case "States.INIT":
        return "Starting";
      case "States.RUNNING":
        return "Running";
      case "States.FINISH":
        return "Finsihed";
      default:
        return "bad formatz";
    }
  }

  static _generateWidgetCard(Request req) {
    AssetImage img = formatImage(req.analyzedRequest);

    String date = formatDate(req.createTime);
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Image(
                    image: img,
                    height: 35,
                    width: 70,
                  ),
                  Text(
                    req.analyzedRequest.getSentimentSentence(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Sentence : ",
                          textAlign: TextAlign.justify,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Flexible(
                          child: Text(
                            req.sentence,
                            textAlign: TextAlign.justify,
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Created at : ",
                          textAlign: TextAlign.justify,
                          style:
                          TextStyle(fontSize: 15),
                        ),
                        Flexible(
                          child: Text(
                            '$date',
                            textAlign: TextAlign.justify,
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Status : ",
                          textAlign: TextAlign.justify,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Flexible(
                          child: Text(
                            req.state,
                            textAlign: TextAlign.justify,
                            style:
                            TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
                          ),
                        ),
                      ],
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
}

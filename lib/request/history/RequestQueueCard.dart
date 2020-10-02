import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/request/Request.dart';

class RequestQueueCard {
  static Widget requestTemplate(int position, Request req) {
    return _generateWidgetCard(position, req);
  }

  static String formatDate(DateTime date) {
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

  static _generateWidgetCard(int position, Request req) {
    AssetImage img = AssetImage('assets/sentiment_meter_not_processed.png');
    String queuePos = "Position in queue : ";
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
                    queuePos,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    position.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Flexible(
                          child: Text(
                            req.sentence,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Created at : ",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15),
                        ),
                        Flexible(
                          child: Text(
                            '$date',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
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

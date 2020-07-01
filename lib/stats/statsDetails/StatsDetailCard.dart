

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/stats/statsDetails/StatsDetail.dart';

class StatsDetailCard{

  static final AssetImage posImage = AssetImage('assets/sentiment_meter_positive.png');
  static final AssetImage neutImage = AssetImage('assets/sentiment_meter_neutral.png');
  static final AssetImage negImage = AssetImage('assets/sentiment_meter_negative.png');


  static Widget wordTemplate(StatsDetail stats){
    return _generateWidgetCard(stats);
  }

  static Widget _generateWidgetCard(StatsDetail stats) {
    String date = formatDate(stats.createdTime);

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text("Number of message analyzed : ${stats.analyzeQuantity} ",
                  style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image(
                        image: posImage,
                        height: 35,
                        width: 70,
                      ),
                      Text(" : ${stats.positiveComment.toStringAsFixed(2)}%",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: neutImage,
                        height: 35,
                        width: 70,
                      ),
                      Text(" : ${stats.neutralComment.toStringAsFixed(2)}%",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                 Row(
                  children: <Widget>[
                    Image(
                      image: negImage,
                      height: 35,
                      width: 70,
                    ),
                    Text(" : ${stats.negativeComment.toStringAsFixed(2)}%",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child :
              Column(
                children: <Widget>[
                  Text("Creation time : ",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  Text("$date",
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,)
                ]
              ),
          ),
        ],
      ),
    );
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


}
import 'package:flutter/material.dart';
import 'package:noticetracker/navigationScreen/history_card_widget.dart';
import 'package:noticetracker/request/RequestService.dart';
import 'package:noticetracker/request/Request.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  HistoryCard historyCard = new HistoryCard();

  List<Request> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: FutureBuilder(
      future: RequestService.getRequest(),
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if(asyncSnapshot.data==null){
          return Container(
            child: Center(child: Text("Loading..."),),
          );
        }
        else {
          return new ListView.builder(
              itemCount: asyncSnapshot.data.length,
              itemBuilder: (BuildContext context, int index) => historyCard.requestTemplate(asyncSnapshot.data[index]));
        }
      }
    ),
    );
  }
}

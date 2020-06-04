import 'package:flutter/material.dart';
import 'package:noticetracker/Request.dart';
import 'package:noticetracker/State.dart';
import 'package:noticetracker/navigationScreen/history_card_widget.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  HistoryCard historyCard = new HistoryCard();

  final list = [
    new Request(States.WAITING, new DateTime.now(), "test1", true, false, false),
    new Request(States.DONE, new DateTime.now(), "test2", false, true, false),
    new Request(States.PROCESSING, new DateTime.now(), "test3", true, false, false),
    new Request(States.DONE, new DateTime.now(), "test4", true, false, false),
    new Request(States.DONE, new DateTime.now(), "test5", false, false, true),
    new Request(States.WAITING, new DateTime.now(), "test6", false, true, false),
    new Request(States.WAITING, new DateTime.now(), "test7", false, false, true),
    new Request(States.DONE, new DateTime.now(), "test2", false, true, false),
    new Request(States.PROCESSING, new DateTime.now(), "test3", true, false, false),
    new Request(States.DONE, new DateTime.now(), "test4", true, false, false),
    new Request(States.DONE, new DateTime.now(), "test5", false, false, true),
    new Request(States.WAITING, new DateTime.now(), "test6", false, true, false),
    new Request(States.WAITING, new DateTime.now(), "test7", false, false, true),
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) => historyCard.requestTemplate(list[index]));
  }
}

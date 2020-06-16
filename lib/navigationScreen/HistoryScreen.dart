import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/request/AnalyzeRequest.dart';
import 'package:noticetracker/State.dart';
import 'package:noticetracker/navigationScreen/history_card_widget.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  HistoryCard historyCard = new HistoryCard();

  final list = [
    new AnalyzedRequest(EnumToString.parse(States.INIT), new DateTime.now(), "test1", true, false, false),
    new AnalyzedRequest(EnumToString.parse(States.FINISH), new DateTime.now(), "test2", false, true, false),
    new AnalyzedRequest(EnumToString.parse(States.RUNNING), new DateTime.now(), "test3", true, false, false),
    new AnalyzedRequest(EnumToString.parse(States.FINISH), new DateTime.now(), "test4", true, false, false),
    new AnalyzedRequest(EnumToString.parse(States.FINISH), new DateTime.now(), "test5", false, false, true),
    new AnalyzedRequest(EnumToString.parse(States.INIT), new DateTime.now(), "test6", false, true, false),
    new AnalyzedRequest(EnumToString.parse(States.INIT), new DateTime.now(), "test7", false, false, true),
    new AnalyzedRequest(EnumToString.parse(States.FINISH), new DateTime.now(), "test2", false, true, false),
    new AnalyzedRequest(EnumToString.parse(States.RUNNING), new DateTime.now(), "test3", true, false, false),
    new AnalyzedRequest(EnumToString.parse(States.FINISH), new DateTime.now(), "test4", true, false, false),
    new AnalyzedRequest(EnumToString.parse(States.FINISH), new DateTime.now(), "test5", false, false, true),
    new AnalyzedRequest(EnumToString.parse(States.INIT), new DateTime.now(), "test6", false, true, false),
    new AnalyzedRequest(EnumToString.parse(States.INIT), new DateTime.now(), "test7", false, false, true),
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) => historyCard.requestTemplate(list[index]));
  }
}

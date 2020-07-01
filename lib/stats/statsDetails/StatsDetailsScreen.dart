
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noticetracker/stats/StatsService.dart';
import 'package:noticetracker/stats/word/Word.dart';
import 'package:noticetracker/stats/statsDetails/StatsDetail.dart';

import 'StatsDetailCard.dart';

class StatsDetailsScreen extends StatefulWidget {

  final Word word;

  StatsDetailsScreen({Key key, @required this.word}) : super(key: key);

  @override
  _StatsDetailsScreenState createState()=> _StatsDetailsScreenState();

}

class _StatsDetailsScreenState extends State<StatsDetailsScreen> {

  Future<List<StatsDetail>> statsList;

  @override
  Widget build(BuildContext context) {
    statsList = StatsService.getStatisticsForWord(widget.word.sentence);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Stats of : ${widget.word.sentence}",
                style: TextStyle(fontSize: 25),
              ),
            ],
          )
      ),
      body: FutureBuilder(
        future: statsList,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if(asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData){
            return Center(child: Text("Word stats details is empty"));
          }
          else if(asyncSnapshot.connectionState!=ConnectionState.done){
            return _generateLoadingContainer();
          }
          else if(asyncSnapshot.hasError){
            return Text("Error : ${asyncSnapshot.hasError}");
          }else {
            return _generateListView(asyncSnapshot);
          }
        },
      ),
    );
  }

  Widget _generateLoadingContainer(){
    return Container(
      child: Center(child: SpinKitDualRing(
        color: Colors.blue,
      ),),
    );
  }


  Widget _generateListView(AsyncSnapshot asyncSnapshot){
    return  ListView.builder(
        itemCount: asyncSnapshot.data.length,
        itemBuilder: (BuildContext context, int index) =>
            StatsDetailCard.wordTemplate(asyncSnapshot.data[index]));
  }
}
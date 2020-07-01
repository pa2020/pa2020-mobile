
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noticetracker/sharedPref/SharedPreferenceService.dart';
import 'package:noticetracker/stats/StatsService.dart';
import 'package:noticetracker/stats/word/WordCard.dart';

import 'word/Word.dart';

class StatsScreen extends StatefulWidget {

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {

  Future<List<Word>> _wordList;

  Future<bool> _admin;

  @override
  void initState() {
    super.initState();
    _admin=SharedPreferenceService.isAdmin();
    _getListOfWords();

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _admin,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if((asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData)
            || asyncSnapshot.connectionState==ConnectionState.none){
          return Center(child: Text("No stats to display"));
        }
        else if(asyncSnapshot.connectionState!=ConnectionState.done){
          return Scaffold(
              body: Container(
                child: Center(child: SpinKitDualRing(
                  color: Colors.blue,
                ),),
              )
          );
        }
        else if(asyncSnapshot.hasError){
          return Text("Error : ${asyncSnapshot.hasError}");
        }else {
          return Scaffold(
            body: asyncSnapshot.data?_generateAdminScaffold():_generateNotAdmin(),
          );
        }
      },
    );
  }

  _generateStatsList(AsyncSnapshot asyncSnapshot) {
    return  ListView.builder(
        itemCount: asyncSnapshot.data.length,
        itemBuilder: (BuildContext context, int index) =>
            WordCard.wordTemplate(asyncSnapshot.data[index], context));
  }

  Widget _generateAdminScaffold(){
    return FutureBuilder(
      future: _wordList,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if((asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData)
            || asyncSnapshot.connectionState==ConnectionState.none){
          return Center(child: Text("No stats to display"));
        }
        else if(asyncSnapshot.connectionState!=ConnectionState.done){
          return Scaffold(
              body: Container(
                child: Center(child: SpinKitDualRing(
                  color: Colors.blue,
                ),),
              )
          );
        }
        else if(asyncSnapshot.hasError){
          return Text("Error : ${asyncSnapshot.hasError}");
        }else {
          return Scaffold(
            body: _generateStatsList(asyncSnapshot),
          );
        }
      },
    );
  }

  _generateNotAdmin() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Icon(Icons.warning,
              color: Colors.blue,
              size: 50,),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("You are not an admin, you don't have the privileges "
                  +"to access this page.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getListOfWords() async {
    bool admin=await _admin;
    if(admin)
      try {
        _wordList = StatsService.getListOfWords();
      }on Exception catch(e){
        print(e);
      }
  }

}
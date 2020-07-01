import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noticetracker/navigationScreen/history_card_widget.dart';
import 'package:noticetracker/request/Request.dart';
import 'package:noticetracker/request/RequestService.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  StreamController<List<Request>> _streamController = StreamController.broadcast();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    startListening();
    _timer=Timer.periodic(Duration(seconds: 5), (timer) => startListening());
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if(asyncSnapshot.hasError)
              return Center(
                child: Text("Error while fetching your request history!"),
              );
            if(asyncSnapshot.connectionState==ConnectionState.waiting)
              return _generateLoadingContainer();
            else if(asyncSnapshot.hasData){
              List<Request> list = asyncSnapshot.data as List;
              if(list.isEmpty)
                return Center(
                  child: Text("You request history is empty",
                      textAlign: TextAlign.center),
                );
              else
                return _generateListView(asyncSnapshot);
            }else{
              return Center(
                child: Text("You request history is empty",
                    textAlign: TextAlign.center),
              );
            }
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

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
            HistoryCard.requestTemplate(asyncSnapshot.data[index]));
  }


  startListening() async {
    _streamController.add(await RequestService.getRequest());
  }


}

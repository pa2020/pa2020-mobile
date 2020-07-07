
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/blacklist/BlackList.dart';
import 'package:noticetracker/blacklist/BlackListService.dart';
import 'package:noticetracker/blacklist/BlackListWordCard.dart';
import 'package:noticetracker/util/AlertDialogDesign.dart';

import '../util/Spinner.dart';

class BlackListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BlackListScreenState();
  }
}

class _BlackListScreenState extends State<BlackListScreen> {

  StreamController<List<BlackListWord>> _streamController = StreamController.broadcast();
  Timer _timer;
  TextEditingController _sentence=TextEditingController();

  void startListening() async{
    _streamController.add(await BlackListService.getList());
  }

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
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if(asyncSnapshot.hasError)
              return Center(
                child: Text("No date to display here, try activating your services or give the app the permissions",
                maxLines: 2,)
              );
            if(asyncSnapshot.connectionState==ConnectionState.waiting)
              return Spinner.startSpinner(Colors.blue);
            else if(asyncSnapshot.hasData){
              List<BlackListWord> list = asyncSnapshot.data as List;
              if(list.isEmpty)
                return Center(
                  child: Text("You black list word history is empty.",
                      textAlign: TextAlign.center),
                );

            }
            return _generateListView(asyncSnapshot.data, context);
          }
      ),
    );
  }

  Widget _generateListView(List<BlackListWord> blackListWords, BuildContext context){
    List<Widget> list = [_generateTextFormField()];
    list.addAll(blackListWords.map((word)=>BlackListWordCard.blackListWordTemplate(word,context)).toList());
    return ListView(children: list);
  }

  Widget _generateTextFormField() {
    return Container(
      padding: EdgeInsets.all(10),
      child:TextFormField(
        controller: _sentence,
        decoration:
        InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.add, color: Colors.green),
            onPressed: () async {
              try{
                Future sendWordFuture=BlackListService.sendBlackListWord(_sentence.text);
                showDialog(context: context,
                    builder: (BuildContext context){
                      return AlertDialogDesign.futureAlertDialog(context, "Sending a new word to the black list", sendWordFuture);
                    }
                );
              }on Exception catch(e){
                showDialog(context: context,
                    builder: (BuildContext context){
                      return AlertDialogDesign.badAlertDialog(context, e.toString(), "Error while sending the new word");
                    }
                );
              }
            },
          ),
          hintText: "Type a new word to ban",
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue)),
        ),
      ),
    );
  }

}
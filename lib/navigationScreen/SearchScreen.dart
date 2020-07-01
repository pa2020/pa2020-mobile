import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noticetracker/enumerate/EmotionEnum.dart';
import 'package:noticetracker/request/RequestResponse.dart';
import 'package:noticetracker/request/RequestService.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _requestSentence = "";

  Future<RequestResponse> _getResponse;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Try to type any word",
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue))),
              onChanged: (String value) {
                setState(() {
                  _requestSentence = value;
                });
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                onPressed: () {
                  setState(() {
                    _getResponse = RequestService.sendRequest(_requestSentence);
                  });
                },
                color: Color(0xFF21f3e7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            _generateFutureBuilder()
          ],
        ),
      )),
    );
  }

  Widget _generateFutureBuilder(){
    return FutureBuilder(
      future: _getResponse,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if((asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData)
            || asyncSnapshot.connectionState==ConnectionState.none){
          return Image.asset('assets/sentiment_meter_not_processed.png',
              fit: BoxFit.fitWidth);
        }
        else if(asyncSnapshot.connectionState!=ConnectionState.done){
          return Center(
            child: SpinKitDualRing(
              color: Colors.blue,
            ),
          );
        }
        else if(asyncSnapshot.hasError){
          return Text("Error : ${asyncSnapshot.hasError}");
        }else {
          print(asyncSnapshot);
          return _showResponse(asyncSnapshot);
        }
      },
    );
  }

  Widget _showResponse(AsyncSnapshot asyncSnapshot) {
    RequestResponse requestResponse = asyncSnapshot.data;
    switch (requestResponse.getSentiment()) {
      case EmotionEnum.positive:
        return Column(
          children: <Widget>[
            Text("Positive at ${requestResponse.positive.toStringAsFixed(2)}%",
              textAlign: TextAlign.center,),
            Image.asset('assets/sentiment_meter_positive.png',
                fit: BoxFit.fitWidth),
          ],
        );

      case EmotionEnum.neutral:
        return Column(
          children: <Widget>[
            Text("Neutral at ${requestResponse.neutral.toStringAsFixed(2)}%",
              textAlign: TextAlign.center,),
            Image.asset('assets/sentiment_meter_neutral.png',
                fit: BoxFit.fitWidth),
          ],
        );

      case EmotionEnum.negative:
        return Column(
          children: <Widget>[
            Text("Negative at ${requestResponse.negative.toStringAsFixed(2)}%",
            textAlign: TextAlign.center,),
            Image.asset('assets/sentiment_meter_negative.png',
                fit: BoxFit.fitWidth),
          ],
        );

      case EmotionEnum.not_processed:
        return Column(
          children: <Widget>[
            Text("Not processed"),
            Image.asset('assets/sentiment_meter_not_processed.png',
                fit: BoxFit.fitWidth),
          ],
        );

      default:
        return SingleChildScrollView(
          child: Image.asset('assets/sentiment_meter_not_processed.png',
              fit: BoxFit.fitWidth),
        );
    }
  }
}

import 'dart:async';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/util/Spinner.dart';
import 'package:noticetracker/enumerate/DropDownMenuEnum.dart';
import 'package:noticetracker/request/history/HistoryCard.dart';
import 'package:noticetracker/request/Request.dart';
import 'package:noticetracker/request/RequestService.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  StreamController<List<Request>> _streamController = StreamController.broadcast();
  Timer _timer;

  String _searchSentence="";

  bool _isAscending=true;

  List<String> _dropDownItemString = [
    EnumToString.parse(DropDownMenuEnum.Date),
    EnumToString.parse(DropDownMenuEnum.Positivity),
    EnumToString.parse(DropDownMenuEnum.Neutrality),
    EnumToString.parse(DropDownMenuEnum.Negativity),
  ];
  
  List<DropdownMenuItem<String>> _dropDownMenuItem;

  String _selectDrownDownMenuItem;


  @override
  void initState() {
    super.initState();
    startListening();
    _timer=Timer.periodic(Duration(seconds: 5), (timer) => startListening());
    _dropDownMenuItem=_dropDownMenuItem = _buildDropDownMenu();
    _selectDrownDownMenuItem = _dropDownMenuItem[0].value;
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Scaffold(
          body :StreamBuilder(
              stream: _streamController.stream,
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                if(asyncSnapshot.hasError)
                  return Center(
                    child: Text("Error while trying to fetch request!"),
                  );
                if(asyncSnapshot.connectionState==ConnectionState.waiting)
                  return Spinner.startSpinner(Colors.blue);
                else{
                  List<Request> list = asyncSnapshot.data as List;
                  if(list.isEmpty)
                    return Center(
                      child: Text("You request history is empty",
                          textAlign: TextAlign.center),
                    );
                  else
                    return _generateListView(asyncSnapshot.data);
                }
              }
          ),
      ),
    );
  }

  Widget _generateListView(List<Request> requests){
    List<Widget> list = [
      _generateSearchBar(),
      _generateDropDownWidget()
    ];

    switch(_selectDrownDownMenuItem){
      case "Positivity" :
        requests =RequestService.sortAndFilterListByPositivity(requests);
        break;
      case "Neutrality" :
        requests =RequestService.sortAndFilterListByNeutrality(requests);
        break;
      case "Negativity" :
        requests =RequestService.sortAndFilterListByNegativity(requests);
        break;

      case "Date" :
        requests =RequestService.sortAndFilterListByDate(requests);
        break;
    }
    if(!_isAscending)
      requests=requests.reversed.toList();
      requests=RequestService.listContains(_searchSentence, requests);
    list.addAll(requests.map((word)=>HistoryCard.requestTemplate(word)).toList());
    return ListView(children: list);
  }


  startListening() async {
    try {
      _streamController.add(await RequestService.getRequest());
    }on SocketException catch(e){
      print(e);
    }
  }

  List<DropdownMenuItem<String>> _buildDropDownMenu() {
    List<DropdownMenuItem<String>> list = [];
    for(int i =0; i<_dropDownItemString.length;i++){
      list.add(DropdownMenuItem(value: _dropDownItemString[i],
        child: Text("${_dropDownItemString[i]}",
            style: TextStyle(
                fontSize: 17
            ))));
    }
    return list;
  }

  Widget _generateDropDownWidget(){
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 5),
              child: Text("Sort by :",
                style: TextStyle(
                    fontSize: 17
                ),)),
          DropdownButton(
            value: _selectDrownDownMenuItem,
            items: _dropDownMenuItem,
            onChanged: (item){
              setState(() {
                _selectDrownDownMenuItem=item;
              });
            },
          ),
          IconButton(
            icon: Icon(_isAscending?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,
              size: 25,),
            onPressed: (){
              setState(() {
                _isAscending=!_isAscending;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _generateSearchBar(){
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search a word",
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue))),
      onChanged: (String value) {
        setState(() {
          _searchSentence = value;
        });
      },
    );
  }

}

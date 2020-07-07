
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticetracker/blacklist/BlackListScreen.dart';
import 'package:noticetracker/stats/StatsScreen.dart';

class AdministrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdministrationScreenState();
  }

}

class _AdministrationScreenState extends State<AdministrationScreen>{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF1565C0),
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 20),
              child: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.show_chart,
                        color: Colors.white),
                    text: "Statistics",
                    ),
                  Tab(
                    icon: Icon(Icons.list,
                        color: Colors.white),
                    text: "Black list",
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
              children: <Widget>[
                StatsScreen(),
                BlackListScreen()
              ]
          ),
        ),
      ),
    );
  }

}
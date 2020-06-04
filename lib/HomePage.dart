import 'package:flutter/material.dart';
import 'package:noticetracker/navigationScreen/HistoryScreen.dart';
import 'package:noticetracker/navigationScreen/ProfileScreen.dart';
import 'package:noticetracker/navigationScreen/SearchScreen.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIdx = 0;

  final tabs = [
    new HistoryScreen().createElement().build(),
    new SearchScreen().createElement().build(),
    new ProfileScreen().createElement().build()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset  : false,
        appBar: AppBar(
          title: Text("Notice Tracker"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: tabs[_currentIdx],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIdx,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text("Search History"),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Home"),
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                backgroundColor: Colors.blue
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIdx = index;
            });
          },
        )
    );
  }
}
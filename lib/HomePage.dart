import 'package:flutter/material.dart';
import 'package:noticetracker/navigationScreen/HistoryScreen.dart';
import 'package:noticetracker/navigationScreen/ProfileScreen.dart';
import 'package:noticetracker/navigationScreen/SearchScreen.dart';
import 'package:noticetracker/stats/StatsScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIdx = 0;


  final tabs = [
    new HistoryScreen(),
    new SearchScreen(),
    new StatsScreen(),
    new ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Notice Tracker"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: tabs[_currentIdx],
        bottomNavigationBar: _generateAdminBottomNavBar()
    );
  }

  _generateAdminBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIdx,
      backgroundColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text("Search History"),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text("Statistics"),
            backgroundColor: Colors.blue),
      ],
      onTap: (index) {
        setState(() {
          _currentIdx = index;
        });
      },
    );
  }

}

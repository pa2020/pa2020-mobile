import 'package:flutter/material.dart';
import 'package:noticetracker/navigationScreen/AdministrationScreen.dart';
import 'package:noticetracker/navigationScreen/HistoryScreen.dart';
import 'package:noticetracker/navigationScreen/ProfileScreen.dart';
import 'package:noticetracker/navigationScreen/SearchScreen.dart';
import 'package:noticetracker/sharedPref/SharedPreferenceService.dart';

import 'util/Spinner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIdx = 0;

  Future<bool> _admin;

  var tabs = [
    new HistoryScreen(),
    new SearchScreen(),
    new ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _admin=SharedPreferenceService.isAdmin();
    setTabs();
  }

  @override
  void dispose() {
    SharedPreferenceService.removeRequests();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _admin,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if((asyncSnapshot.connectionState==ConnectionState.done && !asyncSnapshot.hasData)
            || asyncSnapshot.connectionState==ConnectionState.none){
          return Center(child: Text("Nothing to display"));
        }
        else if(asyncSnapshot.connectionState!=ConnectionState.done){
          return Spinner.startSpinner(Colors.blue);
        }
        else if(asyncSnapshot.hasError){
          return Text("Error : ${asyncSnapshot.hasError}");
        }else {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: tabs[_currentIdx],
              bottomNavigationBar: asyncSnapshot.data?_generateAdminBottomNavBar():_generateUserBottomNavBar()
          );
        }
      },
    );
  }

  Widget _generateAdminBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIdx,
      backgroundColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.history,
              color: Colors.white),
          title: Text("Request History",
              style: TextStyle(
                  color: Colors.white
              )),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: Colors.white),
            title: Text("Search",
                style: TextStyle(
                    color: Colors.white
                )),
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings,
                color: Colors.white),
            title: Text("Administration ",
                style: TextStyle(
                    color: Colors.white
                )),
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: Colors.white),
            title: Text("Profile",
            style: TextStyle(
              color: Colors.white
            ),),
            backgroundColor: Colors.blue),
      ],
      onTap: (index) {
        setState(() {
          _currentIdx = index;
        });
      },
    );
  }

  Widget  _generateUserBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIdx,
      backgroundColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.history,
              color: Colors.white),
          title: Text("Request History",
              style: TextStyle(
                  color: Colors.white
              )),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: Colors.white),
            title: Text("Search",
                style: TextStyle(
                    color: Colors.white
                )),
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,
              color: Colors.white,),
            title: Text("Profile",
                style: TextStyle(
                    color: Colors.white
                )),
            backgroundColor: Colors.blue),
      ],
      onTap: (index) {
        setState(() {
          _currentIdx = index;
        });
      },
    );
  }

  Future<void> setTabs() async {
    bool admin = await _admin;
    if(admin)
      tabs.insert(tabs.length-1,new AdministrationScreen());
  }

}

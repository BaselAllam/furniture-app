import 'package:cls/screens/bottomNavBar/account.dart';
import 'package:cls/screens/bottomNavBar/homepage.dart';
import 'package:cls/screens/bottomNavBar/search.dart';
import 'package:flutter/material.dart';



class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

List screens = [
  HomePage(), Search(), Account()
];


int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account')
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.black, size: 20.0),
        selectedLabelStyle: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal),
        selectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 15.0),
        unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 10.0, fontWeight: FontWeight.normal),
        unselectedItemColor: Colors.grey,
        currentIndex: current,
        onTap: (index) {
          setState(() {
            current = index;
          });
        },
      ),
      body: screens[current],
    );
  }
}
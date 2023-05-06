import 'package:flutter/material.dart';
import 'package:travel_app/screen/Booking_Screen/booking_screen.dart';
import 'package:travel_app/screen/Home/home_screen.dart';
import 'package:travel_app/screen/Profile/profile_screen.dart';

import 'package:travel_app/screen/Saved_Screen/saved_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SavedScreen(),
    BookingScreen(),
    Profile()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: "Ticket",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          )
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
      _selectedIndex = index;
    });
        },
      ),
    );
  }
}

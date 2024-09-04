import 'package:flutter/material.dart';
import 'package:securityapp/Screens/Home_Screen.dart';
import 'package:securityapp/Screens/Notification_Screen.dart';
import 'package:securityapp/Screens/Setting_Screen.dart';
import 'package:securityapp/Setting/Setting.dart';

class Bottom_Screen extends StatefulWidget {
  @override
  State<Bottom_Screen> createState() => _Bottom_ScreenState();
}

class _Bottom_ScreenState extends State<Bottom_Screen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home_Screen(),
    Notification_Screen(),
    Settings_Screen()
  ];

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Color(colorval),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_important_rounded),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_3_outlined),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}

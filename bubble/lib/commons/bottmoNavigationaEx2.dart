import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class bottmoNavigationaEx2 extends StatefulWidget {
  const bottmoNavigationaEx2(this._selectedTab, {super.key});
  final int _selectedTab;
  @override
  State<bottmoNavigationaEx2> createState() => _bottmoNavigationaEx2State();
}

class _bottmoNavigationaEx2State extends State<bottmoNavigationaEx2> {
  int _selectedTab = 0;

  _onItemTap(int index) {
    setState(() {
      _selectedTab = index;
    });
    print('/pageroute index = ' + index.toString());
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/chat');
        break;
      case 2:
        Navigator.pushNamed(context, '/test1');
        break;
      case 3:
        Navigator.pushNamed(context, '/test2');
        break;
      case 4:
        Navigator.pushNamed(context, '/settings');
        break;
      case 5:
        Navigator.pushNamed(context, '/testnodejs');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget._selectedTab;
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.teal),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent),
              label: 'chat',
              backgroundColor: Colors.cyan),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'test',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'test2',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'test3',
            backgroundColor: Colors.lightBlue,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedTab,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTap,
        elevation: 5);
  }
}

import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  int _selectedIndex = 0;
  final List<String> title = [
    'Tables',
    'Settings',
  ];

  List<Widget> pages = [
    const Center(
      child: Text(
        'Tables',
        style: TextStyle(fontSize: 35),
      ),
    ),
    const Center(
      child: Text(
        'Settings',
        style: TextStyle(fontSize: 35),
      ),
    )
  ];

  int get selectedIndex => _selectedIndex;

  void navbarOnTap(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

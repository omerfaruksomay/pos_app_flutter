import 'package:flutter/material.dart';
import 'package:pos_app/view/settings_page.dart';
import 'package:pos_app/view/table_page.dart';
import 'package:pos_app/view_model/auth/auth_view_model.dart';
import 'package:pos_app/view_model/table_page_view_model.dart';
import 'package:provider/provider.dart';

class MainViewModel with ChangeNotifier {
  int _selectedIndex = 0;
  final List<String> title = [
    'Tables',
    'Settings',
  ];


  List<Widget> pages = [
    ChangeNotifierProvider(
      create: (context) => TablePageViewModel(),
      child: TablePage(),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: SettingsPage(),
    )
  ];

  int get selectedIndex => _selectedIndex;

  void navbarOnTap(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

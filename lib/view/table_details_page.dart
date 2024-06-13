import 'package:flutter/material.dart';

import 'package:pos_app/model/table.dart';
import 'package:pos_app/view/sales_page.dart';
import 'package:pos_app/view_model/table_page_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/auth/auth_view_model.dart';
import 'menus_page.dart';

class TabledetailsPage extends StatelessWidget {
  final Tables table;

  const TabledetailsPage({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    TablePageViewModel viewModel = Provider.of(context);
    viewModel.pages = [
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => TablePageViewModel()),
        ],
        child: MenusPage(
          table: table,
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => TablePageViewModel(),
        child: SalesPage(
          table: table,
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 110, 150),
        centerTitle: true,
        title: Text(
          "Table: ${table.name}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: viewModel.pages[viewModel.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(46, 99, 110, 1),
        unselectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        showUnselectedLabels: false,
        backgroundColor: const Color.fromRGBO(46, 99, 110, 150),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Sale'),
        ],
        currentIndex: viewModel.selectedIndex,
        onTap: viewModel.navbarOnTap,
      ),
    );
  }
}

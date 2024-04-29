import 'package:flutter/material.dart';
import 'package:pos_app/view_model/main_layout_view_model.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(46, 99, 110, 100),
          centerTitle: true,
          title: Text(
            viewModel.title[viewModel.selectedIndex],
            style: TextStyle(fontWeight: FontWeight.bold),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.table_bar), label: 'Tables'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: viewModel.selectedIndex,
          onTap: viewModel.navbarOnTap,
        ),
      ),
    );
  }
}

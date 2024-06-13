import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos_app/model/category.dart';
import 'package:pos_app/model/menu.dart';
import 'package:pos_app/model/table.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/view/menus_page.dart';
import 'package:pos_app/view/sales_page.dart';
import 'package:provider/provider.dart';

import 'auth/auth_view_model.dart';

class TablePageViewModel with ChangeNotifier {
  final String _tablesApiKey = "http://10.0.2.2:8000/api/tables";
  final String _catApiKey = "http://10.0.2.2:8000/api/categories";
  final String _menuApiKey = "http://10.0.2.2:8000/api/menus/";
  final String _orderApiKey = "http://10.0.2.2:8000/api/orderFood";

  int _selectedIndex = 0;

  final List<String> title = [
    'menu',
    'sale',
  ];

  List<Widget> pages = [];

  int get selectedIndex => _selectedIndex;

  void navbarOnTap(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final List<Tables> _tables = [];
  final List<Categories> _categories = [];
  final List<Menu> _menus = [];

  List<Menu> get menus => _menus;

  List<Categories> get categories => _categories;

  List<Tables> get tables => _tables;

  TablePageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getTables();
      _getCategory();
    });
  }

  void _getTables() async {
    Uri uri = Uri.parse(_tablesApiKey);
    http.Response response = await http.get(uri);
    Map<String, dynamic> apiResponse = jsonDecode(response.body);
    List<dynamic> allTables = apiResponse['tables'];

    _tables.clear(); // Clear the list before adding new items
    for (Map<String, dynamic> tables in allTables) {
      Tables table = Tables.fromJson(tables);
      _tables.add(table);
    }
    notifyListeners();
  }

  void _getCategory() async {
    Uri uri = Uri.parse(_catApiKey);
    http.Response response = await http.get(uri);
    Map<String, dynamic> apiResponse = jsonDecode(response.body);
    List<dynamic> allCategories = apiResponse['categories'];

    _categories.clear();
    for (Map<String, dynamic> categories in allCategories) {
      Categories category = Categories.fromJson(categories);
      _categories.add(category);
    }
    notifyListeners();
  }

  void getMenus(int catId) async {
    Uri uri = Uri.parse(_menuApiKey + '$catId');
    http.Response response = await http.get(uri);
    Map<String, dynamic> apiResponse = jsonDecode(response.body);
    List<dynamic> allMenusbyCat = apiResponse['menus'];

    _menus.clear();

    for (Map<String, dynamic> menus in allMenusbyCat) {
      Menu menu = Menu.fromJson(menus);
      _menus.add(menu);
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> orderFood({
    required String token,
    required int menuId,
    required int tableId,
    required String tableName,
    required int quantity,
  }) async {
    print(token);

    final url = Uri.parse(_orderApiKey);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'menu_id': menuId,
      'table_id': tableId,
      'table_name': tableName,
      'quantity': quantity,
    });

    print('Sending POST request to $url');
    print('Headers: $headers');
    print('Body: $body');

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to place order: ${response.body}');
    }
  }
}

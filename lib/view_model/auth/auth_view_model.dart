import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/view/auth/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../view/main_layout.dart';
import '../main_layout_view_model.dart';

class AuthViewModel with ChangeNotifier {
  String _token = '';
  String _userId = '';

  String get token => _token;
  String get userId => _userId;

  final loginUrl = Uri.parse('http://10.0.2.2:8000/api/login');
  final logoutUrl = Uri.parse('http://10.0.2.2:8000/api/logout');

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      var data = {
        'email': email,
        'password': password,
      };
      var response = await http.post(
        loginUrl,
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        _token = responseData['token'] ?? '';
        _userId = responseData['user']['id'].toString();
        print('Token: $_token');
        print('User ID: $_userId');
        notifyListeners();

        // Token'ı SharedPreferences'a kaydedin
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token);
        await prefs.setString('user_id', _userId);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => MainViewModel(),
              child: const MainLayout(),
            ),
          ),
              (route) => false,
        );
        print(responseData);
      } else {
        print('Login failed with status code: ${response.statusCode}');
        print(responseData);
      }
    } catch (error) {
      print('Login error: $error');
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      var response = await http.post(
        logoutUrl,
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
        },
      );

      // Token ve userId değerlerini sıfırlama
      _token = '';
      _userId = '';
      notifyListeners();

      // SharedPreferences'dan token ve user_id'yi kaldırın
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user_id');

      // Kullanıcıyı giriş sayfasına yönlendirme
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        ),
            (route) => false,
      );
    } catch (error) {
      print('Logout error: $error');
    }
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    _userId = prefs.getString('user_id') ?? '';
    notifyListeners();
  }
}

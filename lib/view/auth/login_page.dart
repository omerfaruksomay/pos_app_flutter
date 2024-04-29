import 'package:flutter/material.dart';
import 'package:pos_app/view/custom_widgets/custom_button.dart';
import 'package:pos_app/view/custom_widgets/custom_text_fields.dart';
import 'package:pos_app/view/main_layout.dart';
import 'package:pos_app/view_model/main_layout_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 110, 100),
        centerTitle: true,
        title: const Text(
          'Pos App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_restaurant_sharp,
                size: 120,
                color: Color.fromRGBO(46, 99, 110, 1),
              ),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Text('Login to Continue'),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: CustomTextField(
                  isObscure: true,
                  controller: _passwordController,
                  label: 'Pasword',
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 16),
              CustomButton(
                label: 'Login',
                labelColor: Colors.white,
                buttonColor: const Color.fromRGBO(46, 99, 110, 1),
                minWidth: 380,
                minHeight: 50,
                onPressed: () {
                  print(_emailController.text);
                  print(_passwordController.text);
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
                },
              ),
              SizedBox(height: 16),
              CustomButton(
                label: 'Back',
                labelColor: const Color.fromRGBO(46, 99, 110, 1),
                buttonColor: Colors.grey.shade300,
                minWidth: 380,
                minHeight: 50,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

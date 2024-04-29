import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/view/auth/login_page.dart';
import 'package:pos_app/view/custom_widgets/custom_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_restaurant_sharp,
              size: 120,
              color: Color.fromRGBO(46, 99, 110, 1),
            ),
            const Text(
              'Welcome to POS App',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 60),
            CustomButton(
              label: 'Login',
              labelColor: Colors.white,
              buttonColor: const Color.fromRGBO(46, 99, 110, 1),
              minWidth: 300,
              minHeight: 40,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

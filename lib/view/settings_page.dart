import 'package:flutter/material.dart';
import 'package:pos_app/view/custom_widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../view_model/auth/auth_view_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: _buildLogoutButton(context),
    );
  }

  CustomButton _buildLogoutButton(BuildContext context) {
    AuthViewModel viewModel = Provider.of(
      context,
      listen: false,
    );
    return CustomButton(
        label: 'Logout',
        labelColor: Colors.white,
        buttonColor: Color.fromRGBO(46, 99, 110, 1),
        minWidth: 350,
        minHeight: 40,
        onPressed: () => viewModel.logout(context),
    );
  }
}

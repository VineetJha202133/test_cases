import 'package:flutter/material.dart';
import 'package:flutter_geeksynergy_task/modules/home%20module/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  late String name, password;

  void login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedName = prefs.getString('name');
      String? storedPassword = prefs.getString('password');

      if (name == storedName && password == storedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Credentials')),
        );
      }
    }
  }
}

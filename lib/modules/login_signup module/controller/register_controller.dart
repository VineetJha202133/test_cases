import 'package:flutter/material.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController with ChangeNotifier{

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  
  late String name, password, email, phone, profession;

  void signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('password', password);
      await prefs.setString('email', email);
      await prefs.setString('phone', phone);
      await prefs.setString('profession', profession);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_geeksynergy_task/modules/home%20module/screens/new.dart';
import 'package:flutter_geeksynergy_task/modules/login_signup%20module/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Program',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MultipleTabs(),
    );
  }
}


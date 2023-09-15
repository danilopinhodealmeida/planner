import 'package:flutter/material.dart';
import 'package:planner/home.dart';
import 'package:planner/login_screen.dart';
//import 'package:sqflite/sqflite.dart'; // Importe o sqflite

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  void _login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentScreen =
        _isLoggedIn ? HomeScreen(onLogout: _logout) : LoginScreen(onLogin: _login);

    return MaterialApp(
      title: 'Meu App',
      home: currentScreen,
    );
  }
}

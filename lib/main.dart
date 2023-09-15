import 'package:flutter/material.dart';
import 'home.dart';
import 'login_screen.dart';

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

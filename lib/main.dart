import 'package:flutter/material.dart';
import 'package:planner/home.dart';
import 'package:planner/login_screen.dart';
import 'app_theme.dart';

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
        _isLoggedIn ? HomeScreen() : LoginScreen(onLogin: _login);

    return MaterialApp(
      title: 'Meu App',
      theme: appTheme,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Meu App'),
            actions: [
              if (_isLoggedIn)
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: _logout,
                ),
            ],
          ),
        ),
        body: currentScreen,
      ),
    );
  }
}

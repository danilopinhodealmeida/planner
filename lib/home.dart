import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onLogout;

  HomeScreen({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner Digital'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: onLogout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao Planner Digital!',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            // Adicione aqui o conteúdo do seu planner digital
          ],
        ),
      ),
    );
  }
}

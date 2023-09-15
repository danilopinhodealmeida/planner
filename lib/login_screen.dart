import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _storage = FlutterSecureStorage();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final login = _loginController.text;
    final password = _passwordController.text;

    // Você pode adicionar a lógica de autenticação aqui.
    // Por enquanto, apenas exibiremos os valores digitados.
    print('Login: $login');
    print('Senha: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Image.asset(
            'assets/Authentication-bro.png',  // Substitua pelo caminho da sua imagem
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _loginController,
                        decoration: InputDecoration(
                          labelText: 'Login',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                        ),
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Entrar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

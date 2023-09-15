import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
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
      appBar: AppBar(
        title: Text('Tela de Login'),
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Image.asset(
            'assets/Authentication-bro.png',  // Substitua pelo caminho da sua imagem
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }
}

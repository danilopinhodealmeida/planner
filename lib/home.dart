import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onLogout;

  HomeScreen({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner da Thalita'),
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
            Expanded(
              child: Wrap(
                spacing: 8.0, // Espaçamento horizontal entre os itens
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: List.generate(
                  4, // Substitua com o número correto de tarefas
                  (index) {
                    return _buildTaskCard(context, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text('Tarefa $index'),
        subtitle: Text('Descrição da Tarefa $index'),
      ),
    );
  }

  void _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Tarefa'),
          content: Text('Digite os detalhes da nova tarefa:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

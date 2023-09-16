import 'package:flutter/material.dart';
import 'note.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onLogout;

  HomeScreen({required this.onLogout});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner Digital'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: _notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildTaskCard(context, _notes[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Abre a tela de adição de nota
          _goToAddNoteScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Note note) {
    return Card(
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.description),
        trailing: Checkbox(
          value: note.isDone,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                value ? note.markAsDone() : note.markAsUndone();
              }
            });
          },
        ),
      ),
    );
  }

  void _goToAddNoteScreen(BuildContext context) async {
    final newNote = await Navigator.of(context).push<Note>(
      MaterialPageRoute(
        builder: (context) => AddNoteScreen(), // Crie a tela de adição de nota aqui
      ),
    );

    if (newNote != null) {
      setState(() {
        _notes.add(newNote);
      });
    }
  }
}

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  // Controladores para os campos de entrada
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPriority = false;
  DateTime _dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título:'),
            TextField(controller: _titleController),
            SizedBox(height: 16),
            Text('Descrição:'),
            TextField(controller: _descriptionController),
            SizedBox(height: 16),
            Text('Data de Vencimento:'),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _dueDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null && selectedDate != _dueDate) {
                  setState(() {
                    _dueDate = selectedDate;
                  });
                }
              },
              child: Text('Selecionar Data'),
            ),
            SizedBox(height: 16),
            Text('Prioridade:'),
            Checkbox(
              value: _isPriority,
              onChanged: (value) {
                setState(() {
                  _isPriority = value ?? false;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Crie a nota com os dados inseridos
                final newNote = Note.createNew(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dueDate: _dueDate,
                  isPriority: _isPriority,
                );
                // Retorne a nota para a tela anterior
                Navigator.of(context).pop(newNote);
              },
              child: Text('Adicionar Nota'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

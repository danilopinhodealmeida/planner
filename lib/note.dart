import 'package:flutter/material.dart';
import 'model.dart';
import 'database_repository.dart';

class AddTodoScreen extends StatefulWidget {
  ToDoModel? todo;
  AddTodoScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  bool important = false;
  final titleController = TextEditingController();
  final subtitleControler = TextEditingController();

  @override
  void initState() {
    addTodoData();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleControler.dispose();
    super.dispose();
  }

  void addTodoData() {
    if (widget.todo != null) {
      if (mounted)
        setState(() {
          titleController.text = widget.todo!.title;
          subtitleControler.text = widget.todo!.describtion;
          important = widget.todo!.isImportant;
        });
    }
  }

  void addTodo() async {
  ToDoModel todo = ToDoModel(
    title: titleController.text,
    describtion: subtitleControler.text,
    isImportant: important,
  );
  if (widget.todo == null) {
    await DatabaseRepository.instance.insert(todo: todo);
  } else {
    await DatabaseRepository.instance.update(todo);
  }
  // Após adicionar ou atualizar a tarefa, navegue de volta para a tela principal.
  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                  label: const Text('Título'),
                  hintText: 'Seu título'),
            ),
            const SizedBox(
              height: 36,
            ),
            TextFormField(
              controller: subtitleControler,
              decoration: const InputDecoration(
                label: const Text('Subtítulo'),
              ),
            ),
            SwitchListTile.adaptive(
              title: Text('É importante?'),
              value: important,
              onChanged: (value) => setState(
                () {
                  important = value;
                },
              ),
            ),
            MaterialButton(
              color: Colors.pink,
              height: 50,
              minWidth: double.infinity,
              onPressed: addTodo,
              child: Text(
                widget.todo == null ? 'Adicionar tarefa' : 'Atualizar tarefa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
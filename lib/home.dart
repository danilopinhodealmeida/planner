import 'package:flutter/material.dart';
import 'model.dart';
import 'database_repository.dart';
import 'note.dart';
import 'todo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initDb();
    getTodos();
    super.initState();
  }

void initDb() async {
  await DatabaseRepository.instance.initDatabase(); // Chame o método initDatabase
}

  List<ToDoModel> myTodos = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getTodos();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: gotoAddScreen,
        ),
        appBar: AppBar(
          title: const Text('Planner da Thalita'),
        ),
        body: myTodos.isEmpty
            ? const Center(child: const Text('Você não tem nada adicionado'))
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final todo = myTodos[index];
                  return TodoWidget(
                    todo: todo,
                    onDeletePressed: () {
                      delete(todo: todo, context: context);
                      getTodos();
                    },
                  );
                },
                itemCount: myTodos.length,
              ),
      ),
    );
  }

  void getTodos() async {
    await DatabaseRepository.instance.getAllTodos().then((value) {
      setState(() {
        myTodos = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  void gotoAddScreen() async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AddTodoScreen();
  }));

  // Após retornar da tela de adição/atualização, recarregue a lista de tarefas.
  if (result == true) {
    getTodos();
  }
}


  void delete({required ToDoModel todo, required BuildContext context}) async {
    DatabaseRepository.instance.delete(todo.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Deleted')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
import 'package:flutter/material.dart';

import 'provider/todos_provider.dart';
import 'shared/change_notifier_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      notifier: TodoNotifier(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('TodoApp build');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: Column(
          children: [
            const TodoInput(),
            Expanded(
              child: NotifierBuilder<TodoNotifier>(
                notifier: ChangeNotifierProvider.of<TodoNotifier>(context),
                builder: (context, notifier, child) {
                  return ListView.builder(
                    itemCount: notifier.todoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(notifier.todoList[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            notifier.remove(notifier.todoList[index]);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoInput extends StatefulWidget {
  const TodoInput({Key? key}) : super(key: key);

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = ChangeNotifierProvider.of<TodoNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Todo',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              notifier.add(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TodoNotifier extends ChangeNotifier {
  final List<String> _todoList = [];

  List<String> get todoList => _todoList;

  void add(String todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void remove(String todo) {
    _todoList.remove(todo);
    notifyListeners();
  }
}

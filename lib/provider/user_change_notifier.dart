import 'package:flutter/material.dart';

class UserChangeNotifier extends ChangeNotifier {
  String _name = 'John Doe';
  String get name => _name;

  void changeName(String name) {
    _name = name;
    notifyListeners();
  }
}

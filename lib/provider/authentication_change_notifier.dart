import 'package:flutter/foundation.dart';

import '../services/authentication_service.dart';

// final counterValue = ValueNotifier<int>(0);

class AuthenticationChangeNotifier extends ChangeNotifier {
  final _authService = AuthenticationService();

  bool _isAuthenticated = false; // private variable
  bool get isAuthenticated => _isAuthenticated; // public getter

  void login() async {
    final result = await _authService.login();

    if (result) {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  // logout
  void logout() {
    _authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }
}

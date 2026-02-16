import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = "";

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;

  bool logIn(String email, String password) {
    if (email.isNotEmpty &&
        email.contains("@") &&
        password.isNotEmpty &&
        password.length >= 6) {
      _isLoggedIn = true;

      notifyListeners();
      return true;
    }
    return false;
  }

  bool register(String name, String email, String password) {
    if (name.isEmpty || !email.contains("@") || password.length < 6) {
      return false;
    }
    _userName = name;
    notifyListeners();
    return true;
  }

  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

// Login Logic
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
// Register Logic
  bool register(String name, String email, String password) {
    if (name.isEmpty || !email.contains("@") || password.length < 6) {
      return false;
    }
    notifyListeners();
    return true;
  }
// LogOut
  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

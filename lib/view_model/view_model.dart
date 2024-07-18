
import 'package:flutter/material.dart';
import '../model/model.dart';

class UserViewModel extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();
    _users = await ApiService().fetchUsers();
    _isLoading = false;
    notifyListeners();
  }
}


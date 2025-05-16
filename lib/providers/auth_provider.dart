import 'package:caribpay/data/models/user.dart';
import 'package:caribpay/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  String? _token;
  bool _isSignedIn = false;
  bool _isLoading = false;

  UserModel? get user => _user;
  String? get token => _token;
  bool get isSignedIn => _isSignedIn;
  bool get isLoading => _isLoading;

  final _repo = AuthRepo();
  final logger = Logger();

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  Future login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final res = await _repo.login(email, password);
    if (res != null) {
      _user = res.user;
      _token = res.token;
      _isSignedIn = true;
      logger.i('User logged in: ${_user?.email}');
    } else {
      logger.e('Login failed');
    }

    _isLoading = false;
    notifyListeners();
  }
}

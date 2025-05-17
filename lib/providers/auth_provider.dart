import 'dart:convert';

import 'package:caribpay/data/models/user.dart';
import 'package:caribpay/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      await saveToSharedPreferences();
    } else {
      _isSignedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token ?? '');
    await prefs.setString('user', jsonEncode(_user?.toJson()));
  }

  Future loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    String? userJson = prefs.getString('user');
    if (_token != null && _token!.isNotEmpty && userJson != null) {
      _user = UserModel.fromJson(jsonDecode(userJson));
      _isSignedIn = true;
    } else {
      _isSignedIn = false;
    }
    notifyListeners();
  }
}

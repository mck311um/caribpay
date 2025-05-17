import 'dart:convert';

import 'package:caribpay/data/models/user.dart';
import 'package:caribpay/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

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

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  Future getUser() async {
    _isLoading = true;
    notifyListeners();

    _user = await _repo.getUser();

    _isLoading = false;
    notifyListeners();
  }

  Future login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final res = await _repo.login(email, password);
    if (res != null) {
      _user = await _repo.getUser();
      _token = res.token;
      _isSignedIn = true;
      await saveToSharedPreferences();
    } else {
      _isSignedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future updateProfile(UserModel user) async {
    _isLoading = true;
    notifyListeners();

    final res = await _repo.updateUser(user);
    if (res != null) {
      _user = res;
      await saveToSharedPreferences();

      toastification.show(
        type: ToastificationType.success,
        title: Text(
          'Profile Updated',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        description: Text(
          'Your profile has been updated successfully.',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        style: ToastificationStyle.flatColored,
        primaryColor: Colors.green,
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.bottomCenter,
      );
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
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    String? userJson = prefs.getString('user');

    if (_token != null && _token!.isNotEmpty && userJson != null) {
      _user = UserModel.fromJson(jsonDecode(userJson));
      _isSignedIn = true;
    } else {
      _isSignedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future logout() async {
    _isLoading = true;
    notifyListeners();

    _user = null;
    _token = null;
    _isSignedIn = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');

    _isLoading = false;
    notifyListeners();
  }
}

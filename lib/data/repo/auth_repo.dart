import 'package:caribpay/constants/utils.dart';
import 'package:caribpay/data/models/auth_data.dart';
import 'package:caribpay/data/models/user.dart';
import 'package:caribpay/services/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:toastification/toastification.dart';

mixin IAuthRepository {
  Future<AuthData?> login(String email, String password);
  Future<UserModel?> updateUser(UserModel user);
  Future<UserModel?> getUser();
}

class AuthRepo with IAuthRepository {
  final api = ApiService().client;
  var logger = Logger();

  @override
  Future<AuthData?> login(String email, String password) async {
    try {
      final res = await api.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      logger.i('Login response: ${res.data}');

      return AuthData.fromJson(res.data);
    } catch (e) {
      logger.e('Login error: $e');
      var message = '';
      if (e is DioException) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? 'Unknown error';
        } else if (data is String) {
          message = data;
        } else {
          message = e.message ?? 'Unknown Dio error';
        }
      } else {
        message = e.toString();
      }
      logger.e('Login error: $message');
      toastification.show(
        type: ToastificationType.error,
        title: Text(
          'Login Failed',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        description: Text(
          message.toString(),
          style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        style: ToastificationStyle.flatColored,
        primaryColor: Colors.red,
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.bottomCenter,
      );
      return null;
    }
  }

  @override
  Future<UserModel?> updateUser(UserModel user) async {
    try {
      final res = await api.patch('/user/update', data: user.toJson());

      return UserModel.fromJson(res.data);
    } catch (e) {
      logger.e('Updating User: $e');
      var message = '';
      if (e is DioException) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? 'Unknown error';
        } else if (data is String) {
          message = data;
        } else {
          message = e.message ?? 'Unknown Dio error';
        }
      } else {
        message = e.toString();
      }
      logger.e('Updating User: $message');
      toastification.show(
        type: ToastificationType.error,
        title: Text(
          'Updating User Failed',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        description: Text(
          message.toString(),
          style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        style: ToastificationStyle.flatColored,
        primaryColor: Colors.red,
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.bottomCenter,
      );
      return null;
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final res = await api.get('/user/');
      return UserModel.fromJson(res.data);
    } catch (e) {
      handleTransactionError(e, title: 'Get User Failed');
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:toastification/toastification.dart';

final Logger logger = Logger();

void handleTransactionError(
  dynamic error, {
  String title = 'Transaction Failed',
}) {
  logger.e('$title: $error');

  String message = 'Something went wrong';
  if (error is DioException) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      message = data['message'] ?? 'Unknown error';
    } else if (data is String) {
      message = data;
    } else {
      message = error.message ?? 'Unknown Dio error';
    }
  } else {
    message = error.toString();
  }

  logger.e('$title: $message');

  toastification.show(
    type: ToastificationType.error,
    title: Text(
      title,
      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
    ),
    description: Text(
      message,
      style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
    ),
    style: ToastificationStyle.flatColored,
    primaryColor: Colors.red,
    showProgressBar: false,
    autoCloseDuration: const Duration(seconds: 3),
    alignment: Alignment.bottomCenter,
  );
}

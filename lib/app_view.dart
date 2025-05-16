import 'package:caribpay/screens/auth/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(child: MaterialApp(home: LoginScreen()));
  }
}

import 'package:caribpay/constants/values.dart';
import 'package:caribpay/widgets/logo.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Logo()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: Column(children: [Text('Welcome Back')]),
      ),
    );
  }
}

import 'package:caribpay/constants/color_scheme.dart';
import 'package:caribpay/providers/theme_provider.dart';
import 'package:caribpay/screens/auth/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return ToastificationWrapper(
      child: MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: (ThemeData(colorScheme: lightColorScheme)),
        darkTheme: (ThemeData(colorScheme: darkColorScheme)),
        home: LoginScreen(),
      ),
    );
  }
}

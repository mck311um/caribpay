import 'package:caribpay/app_view.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/providers/admin_provider.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<AdminProvider>(create: (_) => AdminProvider()),
        ChangeNotifierProvider<AccountProvider>(
          create: (_) => AccountProvider(),
        ),
      ],
      child: AppView(),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:caribpay/constants/color_scheme.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/providers/admin_provider.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/providers/theme_provider.dart';
import 'package:caribpay/screens/auth/views/login_screen.dart';
import 'package:caribpay/screens/auth/views/update_profile.dart';
import 'package:caribpay/widgets/bottom_bar.dart';
import 'package:caribpay/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  bool isInitializing = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeApp();
    });
  }

  Future<void> initializeApp() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.loadFromSharedPreferences();

    if (authProvider.isSignedIn) {
      await authProvider.getUser();
    }

    await loadData();

    setState(() {
      isInitializing = false;
    });
  }

  Future<void> loadData() async {
    final adminProvider = context.read<AdminProvider>();
    final accountProvider = context.read<AccountProvider>();

    await adminProvider.fetchAdminData();
    await accountProvider.fetchAccounts();
    await accountProvider.getPeers();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final authProvider = context.watch<AuthProvider>();

    return ToastificationWrapper(
      child: MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: ThemeData(colorScheme: lightColorScheme),
        darkTheme: ThemeData(colorScheme: darkColorScheme),
        home:
            isInitializing || authProvider.isLoading
                ? const LoadingScreen()
                : authProvider.isSignedIn
                ? (authProvider.user?.countryId?.isEmpty ?? true
                    ? const UpdateProfile()
                    : const BottomBar())
                : const LoginScreen(),
      ),
    );
  }
}

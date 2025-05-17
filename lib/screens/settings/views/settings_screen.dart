import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: getAppBarTextStyle(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              height: fButtonHeight,
              width: double.infinity,

              child: GFButton(
                color: colorScheme.error,
                text: 'Sign Out',
                icon: Icon(PhosphorIconsBold.signOut),
                textStyle: getTextStyle(
                  context,
                  16,
                  FontWeight.bold,
                  colorScheme.onError,
                  TextDecoration.none,
                  FontStyle.normal,
                ),
                borderShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(fBorderRadius * 2),
                ),
                onPressed: () {
                  authProvider.logout();
                },
              ),
            ),
            const SizedBox(height: fSpacing),
          ],
        ),
      ),
    );
  }
}

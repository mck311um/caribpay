import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:flutter/material.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String sendMoney = '';
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fPadding,
        vertical: fPadding,
      ),
      child: Column(
        children: [
          Text(
            'Send Money',
            style: getTextStyle(
              context,
              24,
              FontWeight.w500,
              colorScheme.onSurface,
              TextDecoration.none,
              FontStyle.normal,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Transfer Money'),
            subtitle: const Text('Transfer money to another account'),
            onTap: () {
              setState(() {
                sendMoney = 'Transfer Money';
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add_alt_1),
            title: const Text('Send Money'),
            subtitle: const Text('Send money to a peer'),
            onTap: () {
              setState(() {
                sendMoney = 'Send Money';
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code_rounded),
            title: const Text('Scan QR Code'),
            subtitle: const Text('Scan a QR code to send money'),
            onTap: () {
              setState(() {
                sendMoney = 'Scan QR Code';
              });
            },
          ),
        ],
      ),
    );
  }
}

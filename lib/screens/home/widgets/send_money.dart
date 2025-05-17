import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/screens/home/views/send_money_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_2/persistent_tab_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String sendMoneyMethod = '';
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
              FontWeight.w600,
              colorScheme.onSurface,
              TextDecoration.none,
              FontStyle.normal,
            ),
          ),
          const SizedBox(height: fSmallSpacing),
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: const Text('Between My Accounts'),
            subtitle: const Text('Move money across your own accounts'),
            onTap: () {
              setState(() {
                sendMoneyMethod = 'Internal Transfer';
              });
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SendMoneyScreen(sendMoneyMethod: sendMoneyMethod),
                withNavBar: false,
              );
            },
          ),
          ListTile(
            leading: Icon(PhosphorIcons.paperPlaneTilt()),
            title: const Text('To Another User'),
            subtitle: const Text('Send to another CaribPay user'),
            onTap: () {
              setState(() {
                sendMoneyMethod = 'Peer Transfer';
              });
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SendMoneyScreen(sendMoneyMethod: sendMoneyMethod),
                withNavBar: false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code_rounded),
            title: const Text('Scan QR Code'),
            subtitle: const Text('Quick transfer via QR'),
            onTap: () {
              setState(() {
                sendMoneyMethod = 'QR Transfer';
              });
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SendMoneyScreen(sendMoneyMethod: sendMoneyMethod),
                withNavBar: false,
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:caribpay/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AllAccounts extends StatefulWidget {
  const AllAccounts({super.key});

  @override
  State<AllAccounts> createState() => _AllAccountsState();
}

class _AllAccountsState extends State<AllAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Accounts",
          style: getAppBarTextStyle(context).copyWith(fontSize: 24),
        ),
        centerTitle: false,
      ),
    );
  }
}

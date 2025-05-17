import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/screens/home/widgets/account_card.dart';
import 'package:caribpay/screens/home/widgets/add_account_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAccounts extends StatefulWidget {
  const AllAccounts({super.key});

  @override
  State<AllAccounts> createState() => _AllAccountsState();
}

class _AllAccountsState extends State<AllAccounts> {
  @override
  Widget build(BuildContext context) {
    final accountProvider = context.watch<AccountProvider>();
    final accounts = accountProvider.accounts;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Accounts",
          style: getAppBarTextStyle(context).copyWith(fontSize: 24),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return AccountCard(account: account);
                },
              ),
            ),
            const SizedBox(height: fSpacing),
            AddAccountButton(),
            const SizedBox(height: fLargeSpacing),
          ],
        ),
      ),
    );
  }
}

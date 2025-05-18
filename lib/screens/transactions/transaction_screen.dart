import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/screens/transactions/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final accountProvider = context.watch<AccountProvider>();
    final authProvider = context.watch<AuthProvider>();
    final transactions =
        accountProvider.transactions
            .where((trans) => trans.userId == authProvider.user?.id)
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions', style: getAppBarTextStyle(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: RefreshIndicator(
          onRefresh: () async {
            await accountProvider.fetchTransactions();
          },
          child: ListView.separated(
            itemCount: transactions.length,
            separatorBuilder:
                (context, index) => SizedBox(height: fSmallSpacing),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return TransactionCard(transaction: transaction);
            },
          ),
        ),
      ),
    );
  }
}

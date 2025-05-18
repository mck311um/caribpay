import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/screens/transactions/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  final Account account;
  const AccountScreen({super.key, required this.account});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  void loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final accountProvider = context.read<AccountProvider>();
      await accountProvider.fetchTransactionsByAccountNumber(
        widget.account.accountNumber,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accountProvider = context.watch<AccountProvider>();

    final account = widget.account;
    final currencySymbol =
        widget.account.currency != null
            ? widget.account.currency!.symbol
            : '\$';
    final balance = widget.account.balance;
    final formattedBalance = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    ).format(balance);

    final transactions =
        accountProvider.transactions
            .where((account) => account.accountId == widget.account.id)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Details",
          style: getAppBarTextStyle(context).copyWith(fontSize: 22),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(fBorderRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: getTextStyle(
                      context,
                      24,
                      FontWeight.bold,
                      Colors.white,
                      TextDecoration.none,
                      FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: fSmallSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account Number",
                        style: getTextStyle(
                          context,
                          14,
                          FontWeight.w500,
                          Colors.white,
                          TextDecoration.none,
                          FontStyle.normal,
                        ),
                      ),
                      Text(
                        account.accountNumber,
                        style: getTextStyle(
                          context,
                          16,
                          FontWeight.w500,
                          Colors.white,
                          TextDecoration.none,
                          FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: fSmallSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Balance",
                        style: getTextStyle(
                          context,
                          14,
                          FontWeight.w500,
                          Colors.white,
                          TextDecoration.none,
                          FontStyle.normal,
                        ),
                      ),
                      Text(
                        formattedBalance,
                        style: getTextStyle(
                          context,
                          24,
                          FontWeight.bold,
                          Colors.white,
                          TextDecoration.none,
                          FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Transactions",
                  style: getTextStyle(
                    context,
                    18,
                    FontWeight.w500,
                    colorScheme.onSurface,
                    TextDecoration.none,
                    FontStyle.normal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await accountProvider.fetchTransactions();
                },
                child:
                    transactions.isNotEmpty
                        ? ListView.separated(
                          separatorBuilder:
                              (context, index) =>
                                  const SizedBox(height: fSmallSpacing),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return TransactionCard(transaction: transaction);
                          },
                        )
                        : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              "No transactions available",
                              style: getTextStyle(
                                context,
                                16,
                                FontWeight.w500,
                                colorScheme.onSurface,
                                TextDecoration.none,
                                FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

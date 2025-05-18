import 'package:caribpay/constants/color_scheme.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/data/models/transaction.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  IconData _getIcon() {
    switch (transaction.transactionType) {
      case 'TRANSFER':
        return PhosphorIcons.paperPlaneTilt();
      case 'TRANSFER_INTERNAL':
        return Icons.swap_horiz;
      default:
        return Icons.swap_horiz;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (transaction.transactionType) {
      case 'TRANSFER':
        return CustomColors.coral;
      case 'TRANSFER_INTERNAL':
        return CustomColors.navy;
      default:
        return CustomColors.turquoise;
    }
  }

  Color _getAmountColor(BuildContext context) {
    switch (transaction.direction) {
      case "OUTGOING":
        return Colors.red;
      case "INCOMING":
        return Colors.green;
      default:
        return Theme.of(context).textTheme.bodyLarge!.color!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accountProvider = context.watch<AccountProvider>();

    final accounts = accountProvider.accounts;
    final Account? account =
        accounts.isNotEmpty
            ? accounts.firstWhere(
              (a) => a.id == transaction.accountId,
              orElse: () => Account.empty,
            )
            : null;

    final formattedAmount = NumberFormat.currency(
      symbol: account?.currency?.symbol ?? '\$',
      decimalDigits: 2,
    ).format(transaction.amount.abs());

    return Container(
      padding: const EdgeInsets.all(fPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    _getIcon(),
                    color: _getIconColor(context),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: fSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (transaction.reference?.trim().isEmpty ?? true)
                        ? 'Transaction'
                        : transaction.reference!,
                    style: getTextStyle(
                      context,
                      14,
                      FontWeight.w600,
                      colorScheme.onSurface,
                      TextDecoration.none,
                      FontStyle.normal,
                    ),
                  ),
                  Text(
                    account?.name ?? 'Account',
                    style: getTextStyle(
                      context,
                      12,
                      FontWeight.normal,
                      colorScheme.onSurface,
                      TextDecoration.none,
                      FontStyle.normal,
                    ),
                  ),
                  Text(
                    timeago.format(transaction.createdAt),
                    style: getTextStyle(
                      context,
                      12,
                      FontWeight.normal,
                      colorScheme.onSurface.withValues(alpha: 0.6),
                      TextDecoration.none,
                      FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            formattedAmount,
            style: getTextStyle(
              context,
              16,
              FontWeight.w600,
              _getAmountColor(context),
              TextDecoration.none,
              FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}

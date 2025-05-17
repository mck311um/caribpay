import 'package:caribpay/constants/color_scheme.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/data/models/account.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountCard extends StatefulWidget {
  final Account account;
  const AccountCard({super.key, required this.account});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final currencySymbol =
        widget.account.currency != null
            ? widget.account.currency!.symbol
            : '\$';
    final balance = widget.account.balance;
    final formattedBalance = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    ).format(balance);

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(fBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(fBorderRadius),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(fPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: LinearGradient(
                        colors: [
                          CustomColors.coral,
                          Color.lerp(CustomColors.coral, Colors.black, 0.1)!,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: fSmallSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.account.name,
                        style: getTextStyle(
                          context,
                          16,
                          FontWeight.w500,
                          colorScheme.onSurface,
                          TextDecoration.none,
                          FontStyle.normal,
                        ),
                      ),
                      Icon(
                        PhosphorIcons.arrowRight(),
                        size: 20,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            formattedBalance,
                            style: getTextStyle(
                              context,
                              28,
                              FontWeight.w600,
                              colorScheme.onSurface,
                              TextDecoration.none,
                              FontStyle.normal,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.account.currency?.name ?? 'XCD',
                            style: getTextStyle(
                              context,
                              16,
                              FontWeight.w600,
                              colorScheme.onSurface.withValues(alpha: 0.5),
                              TextDecoration.none,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Available balance',
                        style: getTextStyle(
                          context,
                          14,
                          FontWeight.w500,
                          colorScheme.onSurface.withValues(alpha: 0.5),
                          TextDecoration.none,
                          FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

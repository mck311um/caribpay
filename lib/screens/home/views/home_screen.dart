import 'package:caribpay/constants/color_scheme.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/screens/home/views/all_accounts.dart';
import 'package:caribpay/screens/home/widgets/account_card.dart';
import 'package:caribpay/screens/home/widgets/add_account_button.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:persistent_bottom_nav_bar_2/persistent_tab_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final accountProvider = context.watch<AccountProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    final accounts = accountProvider.accounts;
    final Account? primaryAccount =
        accounts.isNotEmpty
            ? accounts.firstWhere(
              (a) => a.isPrimary,
              orElse: () => null as Account,
            )
            : null;
    final otherAccounts = accounts.where((a) => !a.isPrimary).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: fPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: fLargeSpacing * 0.5),
                Text(
                  'Hi, ${authProvider.user?.firstName ?? ''}',
                  style: getTextStyle(
                    context,
                    24,
                    FontWeight.w500,
                    colorScheme.onSurface,
                    TextDecoration.none,
                    FontStyle.normal,
                  ),
                ),
                Text(
                  'Welcome back',
                  style: getTextStyle(
                    context,
                    18,
                    FontWeight.w500,
                    colorScheme.onSurface.withValues(alpha: fOpacity),
                    TextDecoration.none,
                    FontStyle.normal,
                  ),
                ),
                const SizedBox(height: fSpacing * 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Accounts',
                      style: getTextStyle(
                        context,
                        16,
                        FontWeight.w700,
                        colorScheme.onSurface,
                        TextDecoration.none,
                        FontStyle.normal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const AllAccounts(),
                          withNavBar: false,
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: getTextStyle(
                              context,
                              14,
                              FontWeight.normal,
                              colorScheme.onSurface.withValues(alpha: 0.6),
                              TextDecoration.none,
                              FontStyle.normal,
                            ),
                          ),
                          const SizedBox(width: fSmallSpacing),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: fSpacing),
                Column(
                  children: [
                    if (primaryAccount != null)
                      AccountCard(account: primaryAccount),
                    const SizedBox(height: fSpacing),
                    AddAccountButton(),
                  ],
                ),
                const SizedBox(height: fSpacing * 2),
                Text(
                  'Quick Actions',
                  style: getTextStyle(
                    context,
                    18,
                    FontWeight.w500,
                    colorScheme.onSurface,
                    TextDecoration.none,
                    FontStyle.normal,
                  ),
                ),
                const SizedBox(height: fSmallSpacing),
                SizedBox(
                  height: fButtonHeight,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox.expand(
                          child: GFButton(
                            onPressed: () {},
                            text: 'Send Money',
                            color: CustomColors.turquoise,
                            icon: Icon(
                              PhosphorIcons.arrowUpRight(),
                              color: Colors.white,
                              size: 24,
                            ),
                            borderShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                fBorderRadius,
                              ),
                            ),
                            textStyle: getTextStyle(
                              context,
                              16,
                              FontWeight.w500,
                              Colors.white,
                              TextDecoration.none,
                              FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: fSmallSpacing),
                      Expanded(
                        child: SizedBox.expand(
                          child: GFButton(
                            onPressed: () {},
                            text: 'Receive Money',
                            color: CustomColors.coral,
                            borderShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                fBorderRadius,
                              ),
                            ),
                            icon: Icon(
                              PhosphorIcons.arrowDownLeft(),
                              color: Colors.white,
                              size: 20,
                            ),
                            textStyle: getTextStyle(
                              context,
                              16,
                              FontWeight.w500,
                              Colors.white,
                              TextDecoration.none,
                              FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/screens/home/views/all_accounts.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_2/persistent_tab_view.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

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
                // Add your widgets here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

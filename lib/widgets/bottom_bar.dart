import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/screens/home/views/home_screen.dart';
import 'package:caribpay/screens/settings/views/settings_screen.dart';
import 'package:caribpay/screens/transactions/transaction_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_2/persistent_tab_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final double iconSize = 25;
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 2,
  );

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const TransactionScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(ColorScheme colorScheme) {
    final textStyle = getTextStyle(
      context,
      12,
      FontWeight.w600,
      colorScheme.primary,
      TextDecoration.none,
      FontStyle.normal,
    );

    return [
      PersistentBottomNavBarItem(
        title: 'Home',
        activeColorPrimary: colorScheme.primary,
        inactiveColorPrimary: Colors.grey,
        icon: Icon(FluentIcons.home_48_filled, size: iconSize),
        textStyle: textStyle,
      ),
      PersistentBottomNavBarItem(
        title: 'Transactions',
        activeColorPrimary: colorScheme.primary,
        inactiveColorPrimary: Colors.grey,
        icon: Icon(PhosphorIconsFill.chartBar, size: iconSize),
        textStyle: textStyle,
      ),
      PersistentBottomNavBarItem(
        title: 'Settings',
        activeColorPrimary: colorScheme.primary,
        inactiveColorPrimary: Colors.grey,
        icon: Icon(PhosphorIconsFill.gear, size: iconSize),
        textStyle: textStyle,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PersistentTabView(
      context,
      screens: _buildScreens(),
      controller: _controller,
      items: _navBarItems(colorScheme),
      backgroundColor: colorScheme.surface,
      onItemSelected: (value) {},
      navBarStyle: NavBarStyle.style6,
      navBarHeight: 60,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
    );
  }
}

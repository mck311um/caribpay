import 'package:caribpay/constants/text_styles.dart';
import 'package:flutter/material.dart';

class SettingsCardHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SettingsCardHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextStyle(
            context,
            18,
            FontWeight.w700,
            colorScheme.onSurface,
            TextDecoration.none,
            FontStyle.normal,
          ),
        ),
        Text(
          subtitle,
          style: getTextStyle(
            context,
            13,
            FontWeight.w500,
            colorScheme.onSurface,
            TextDecoration.none,
            FontStyle.normal,
          ),
        ),
      ],
    );
  }
}

import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class AddAccountButton extends StatelessWidget {
  const AddAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(fBorderRadius * 2),
        border: Border.all(
          width: 2,
          color: colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: GFButton(
        color: Colors.transparent,
        borderShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(fLargeBorderRadius),
        ),
        splashColor: colorScheme.primary.withValues(alpha: 0.1),
        highlightColor: colorScheme.primary.withValues(alpha: 0.1),
        focusColor: colorScheme.primary.withValues(alpha: 0.1),
        hoverColor: colorScheme.primary.withValues(alpha: 0.1),

        elevation: 0,
        icon: Icon(Icons.add, color: colorScheme.onSurface, size: 16),
        onPressed: () {},
        text: 'Add Account',
        textStyle: getTextStyle(
          context,
          14,
          FontWeight.w500,
          colorScheme.onSurface,
          TextDecoration.none,
          FontStyle.normal,
        ),
      ),
    );
  }
}

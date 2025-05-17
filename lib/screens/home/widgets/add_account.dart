import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _accountNameController = TextEditingController();

  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accountProvider = context.watch<AccountProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fPadding,
        vertical: fPadding,
      ),
      child: Column(
        children: [
          Text(
            'Add Account',
            style: getTextStyle(
              context,
              24,
              FontWeight.w500,
              colorScheme.onSurface,
              TextDecoration.none,
              FontStyle.normal,
            ),
          ),
          const SizedBox(height: fSpacing * 2),
          CustomTextField(
            controller: _accountNameController,
            hintText: 'Account Name',
            labelText: 'Account Name',
            onChanged: (value) {
              setState(() {
                isValid = value.isNotEmpty;
              });
            },
          ),
          const SizedBox(height: fSpacing),
          SizedBox(
            height: fButtonHeight,
            width: double.infinity,
            child: GFButton(
              onPressed:
                  isValid
                      ? () {
                        accountProvider.addAccount(_accountNameController.text);
                      }
                      : null,
              text: 'Add Account',
              color: colorScheme.primary,

              borderShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(fLargeBorderRadius),
              ),
              textStyle: getTextStyle(
                context,
                18,
                FontWeight.w500,
                Colors.white,
                TextDecoration.none,
                FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

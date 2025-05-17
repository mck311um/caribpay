import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/screens/home/widgets/add_account.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class AddAccountButton extends StatefulWidget {
  const AddAccountButton({super.key});

  @override
  State<AddAccountButton> createState() => _AddAccountButtonState();
}

class _AddAccountButtonState extends State<AddAccountButton> {
  final _accountNameController = TextEditingController();

  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _accountNameController.addListener(() {
      setState(() {
        isValid = _accountNameController.text.isNotEmpty;
      });
    });
  }

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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: AddAccount(),
              );
            },
          );
        },
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

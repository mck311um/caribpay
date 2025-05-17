// ignore_for_file: use_build_context_synchronously

import 'package:caribpay/constants/enums.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/widgets/custom_loading_indicator.dart';
import 'package:caribpay/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AddPeer extends StatefulWidget {
  const AddPeer({super.key});

  @override
  State<AddPeer> createState() => _AddPeerState();
}

class _AddPeerState extends State<AddPeer> {
  final _peerNameController = TextEditingController();
  final _peerPhoneController = TextEditingController();
  final _peerAccountController = TextEditingController();

  bool isValid = false;

  void _validateFields() {
    final account = _peerAccountController.text.trim();
    final name = _peerNameController.text.trim();
    final phone = _peerPhoneController.text.trim();

    final regex = RegExp(r'^ACC-\d{6}$');
    final isAccountValid = regex.hasMatch(account);

    setState(() {
      isValid = name.isNotEmpty && phone.isNotEmpty && isAccountValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accountProvider = context.watch<AccountProvider>();

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: fPadding,
        right: fPadding,
        bottom: MediaQuery.of(context).viewInsets.bottom + fPadding,
        top: fPadding,
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
            controller: _peerNameController,
            hintText: 'Cousin John',
            labelText: 'Peer Name',
            keyboardType: TextInputType.name,
            inputAction: TextInputAction.next,
            onChanged: (_) => _validateFields(),
          ),
          const SizedBox(height: fSpacing),
          CustomTextField(
            controller: _peerPhoneController,
            hintText: '+1 876 123 4567',
            labelText: 'Phone Number',
            keyboardType: TextInputType.phone,
            inputAction: TextInputAction.next,
            onChanged: (_) => _validateFields(),
          ),
          const SizedBox(height: fSpacing),
          CustomTextField(
            controller: _peerAccountController,
            hintText: 'ACC-123456789',
            labelText: 'Account Number',
            onChanged: (_) => _validateFields(),
          ),
          const SizedBox(height: fSpacing),
          accountProvider.isLoading
              ? SizedBox(height: fButtonHeight, child: CustomLoadingIndicator())
              : SizedBox(
                height: fButtonHeight,
                width: double.infinity,
                child: GFButton(
                  onPressed:
                      isValid
                          ? () async {
                            final name = _peerNameController.text.trim();
                            final phone = _peerPhoneController.text.trim();
                            final account = _peerAccountController.text.trim();
                            await accountProvider
                                .addPeer(name, phone, account)
                                .then((value) {
                                  if (value == QueryStatus.success) {
                                    toastification.show(
                                      type: ToastificationType.success,
                                      title: Text(
                                        'Added Peer',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      description: Text(
                                        'Peer added successfully',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      style: ToastificationStyle.flatColored,
                                      primaryColor: Colors.green,
                                      showProgressBar: false,
                                      autoCloseDuration: const Duration(
                                        seconds: 3,
                                      ),
                                      alignment: Alignment.bottomCenter,
                                    );
                                    Navigator.pop(context);
                                  }
                                });
                          }
                          : null,
                  text: 'Add Peer',
                  color: colorScheme.primary,
                  icon: Icon(PhosphorIconsBold.userPlus),
                  borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(fLargeBorderRadius),
                  ),
                  textStyle: getTextStyle(
                    context,
                    18,
                    FontWeight.w700,
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

// ignore_for_file: use_build_context_synchronously

import 'package:caribpay/constants/enums.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/data/models/peer.dart';
import 'package:caribpay/providers/account_provider.dart';
import 'package:caribpay/screens/home/widgets/add_peer.dart';
import 'package:caribpay/widgets/custom_dropdown.dart';
import 'package:caribpay/widgets/custom_loading_indicator.dart';
import 'package:caribpay/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SendMoneyScreen extends StatefulWidget {
  final String sendMoneyMethod;
  const SendMoneyScreen({super.key, required this.sendMoneyMethod});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _sendAccountController = TextEditingController();
  final _receiveAccountController = TextEditingController();
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();

  bool isValid = false;
  String sendAccount = '';
  String receiveAccount = '';

  void _validateFields() {
    final amount = double.tryParse(_amountController.text);
    final hasAmount = amount != null && amount > 0;
    final hasSendAccount = sendAccount.isNotEmpty;
    final hasReceiveAccount =
        widget.sendMoneyMethod == 'Internal Transfer'
            ? receiveAccount.isNotEmpty
            : true;

    setState(() {
      isValid = hasAmount && hasSendAccount && hasReceiveAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accountProvider = context.watch<AccountProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sendMoneyMethod,
          style: getAppBarTextStyle(context).copyWith(fontSize: 24),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: SingleChildScrollView(
          child:
              accountProvider.isLoading
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 60,
                          child: CustomLoadingIndicator(),
                        ),
                        const SizedBox(height: fSpacing),
                        Text(
                          'Processing your request',
                          style: getTextStyle(
                            context,
                            16,
                            FontWeight.w500,
                            colorScheme.onSurface,
                            TextDecoration.none,
                            FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: fSpacing * 2),
                      CustomDropdown<Account>(
                        height: 60,
                        controller: _sendAccountController,
                        labelText: 'Account From',
                        labelStyle: getTextStyle(
                          context,
                          16,
                          FontWeight.w500,
                          colorScheme.onSurface,
                          TextDecoration.none,
                          FontStyle.normal,
                        ),
                        labelPadding: const EdgeInsets.only(bottom: 0),
                        bottomSheetTitle: 'Select Account',
                        items:
                            accountProvider.accounts
                                .where((account) => account.balance > 0)
                                .toList(),
                        itemTextBuilder: (account) {
                          final formattedBalance = NumberFormat.currency(
                            symbol: account.currency?.symbol ?? '\$',
                            decimalDigits: 2,
                          ).format(account.balance);
                          return '${account.name} - $formattedBalance';
                        },
                        isRequired: true,
                        onSelected: (selectedItems) {
                          setState(() {
                            _validateFields();
                            if (selectedItems.isNotEmpty) {
                              final account = selectedItems[0];
                              final formattedBalance = NumberFormat.currency(
                                symbol: account.currency?.symbol ?? '\$',
                                decimalDigits: 2,
                              ).format(account.balance);
                              _sendAccountController.text =
                                  '${account.name} - $formattedBalance';
                              sendAccount = selectedItems[0].accountNumber;
                            } else {
                              _sendAccountController.clear();
                              sendAccount = '';
                            }
                          });
                        },
                      ),
                      const SizedBox(height: fSpacing),
                      if (widget.sendMoneyMethod == 'Internal Transfer') ...[
                        _buildInternalTransfer(
                          context,
                          colorScheme,
                          accountProvider,
                        ),
                      ] else if (widget.sendMoneyMethod == 'Peer Transfer') ...[
                        _buildPeerTransfer(
                          context,
                          colorScheme,
                          accountProvider,
                        ),
                      ],
                      const SizedBox(height: fSpacing),
                      CustomTextField(
                        controller: _amountController,
                        hintText: '0.00',
                        labelText: 'Amount',
                        keyboardType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        onChanged: (_) => _validateFields(),
                      ),
                      const SizedBox(height: fSpacing),
                      CustomTextField(
                        controller: _referenceController,
                        hintText: 'Reference',
                        labelText: 'Reference',
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: 5,
                        onChanged: (_) => _validateFields(),
                      ),
                      const SizedBox(height: fSpacing),
                      SizedBox(
                        height: fButtonHeight,
                        child: GFButton(
                          color: colorScheme.primary,
                          borderShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              fLargeBorderRadius,
                            ),
                          ),
                          icon: Icon(
                            PhosphorIconsBold.paperPlaneTilt,
                            size: 20,
                          ),
                          text: 'Send Money',
                          textStyle: getTextStyle(
                            context,
                            18,
                            FontWeight.w500,
                            Colors.white,
                            TextDecoration.none,
                            FontStyle.normal,
                          ),
                          onPressed:
                              isValid
                                  ? () {
                                    final amount = double.tryParse(
                                      _amountController.text,
                                    );
                                    final reference = _referenceController.text;

                                    Future<QueryStatus> transfer;

                                    if (widget.sendMoneyMethod ==
                                        'Internal Transfer') {
                                      transfer = accountProvider
                                          .internalTransfer(
                                            sendAccount,
                                            amount!,
                                            receiveAccount,
                                            0.0,
                                            reference,
                                          );
                                    } else if (widget.sendMoneyMethod ==
                                        'Peer Transfer') {
                                      transfer = accountProvider.peerTransfer(
                                        sendAccount,
                                        amount!,
                                        receiveAccount,
                                        5.0,
                                        reference,
                                      );
                                    } else {
                                      return;
                                    }

                                    transfer.then((value) {
                                      if (value == QueryStatus.success) {
                                        toastification.show(
                                          type: ToastificationType.success,
                                          title: Text(
                                            'Transaction Successful',
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          description: Text(
                                            'Transaction completed successfully',
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          style:
                                              ToastificationStyle.flatColored,
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
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  CustomDropdown<Account> _buildInternalTransfer(
    BuildContext context,
    ColorScheme colorScheme,
    AccountProvider accountProvider,
  ) {
    return CustomDropdown<Account>(
      height: 60,
      controller: _receiveAccountController,
      labelText: 'Account To',
      labelStyle: getTextStyle(
        context,
        16,
        FontWeight.w500,
        colorScheme.onSurface,
        TextDecoration.none,
        FontStyle.normal,
      ),
      labelPadding: const EdgeInsets.only(bottom: 0),
      bottomSheetTitle: 'Select Account',
      items:
          accountProvider.accounts
              .where((account) => account.accountNumber != sendAccount)
              .toList(),
      itemTextBuilder: (account) {
        final formattedBalance = NumberFormat.currency(
          symbol: account.currency?.symbol ?? '\$',
          decimalDigits: 2,
        ).format(account.balance);
        return '${account.name} - $formattedBalance';
      },
      isRequired: true,
      enabled: _sendAccountController.text.isNotEmpty,
      onSelected: (selectedItems) {
        setState(() {
          _validateFields();
          if (selectedItems.isNotEmpty) {
            final account = selectedItems[0];
            final formattedBalance = NumberFormat.currency(
              symbol: account.currency?.symbol ?? '\$',
              decimalDigits: 2,
            ).format(account.balance);
            _receiveAccountController.text =
                '${account.name} - $formattedBalance';
            receiveAccount = selectedItems[0].accountNumber;
          } else {
            _receiveAccountController.clear();
            receiveAccount = '';
          }
        });
      },
    );
  }

  Widget _buildPeerTransfer(
    BuildContext context,
    ColorScheme colorScheme,
    AccountProvider accountProvider,
  ) {
    return Column(
      children: [
        CustomDropdown<Peer>(
          height: 60,
          controller: _receiveAccountController,
          labelText: 'Account To',
          labelStyle: getTextStyle(
            context,
            16,
            FontWeight.w500,
            colorScheme.onSurface,
            TextDecoration.none,
            FontStyle.normal,
          ),
          labelPadding: const EdgeInsets.only(bottom: 0),
          bottomSheetTitle: 'Select Peer',
          items: accountProvider.peers,
          itemTextBuilder: (peer) => peer.name,
          isRequired: true,
          enabled: _sendAccountController.text.isNotEmpty,
          onSelected: (selectedItems) {
            setState(() {
              _validateFields();
              if (selectedItems.isNotEmpty) {
                final peer = selectedItems[0];
                _receiveAccountController.text = peer.name;
                receiveAccount = selectedItems[0].accountNumber;
              } else {
                _receiveAccountController.clear();
                receiveAccount = '';
              }
            });
          },
        ),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(fLargeBorderRadius),
            border: Border.all(color: colorScheme.outline, width: 1.5),
          ),
          child: GFButton(
            text: 'Add Peer',
            color: Colors.transparent,
            icon: Icon(
              PhosphorIconsBold.plus,
              size: 18,
              color: colorScheme.onSurface,
            ),
            borderShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(fLargeBorderRadius),
            ),
            elevation: 0,
            splashColor: Colors.transparent,
            textStyle: getTextStyle(
              context,
              14,
              FontWeight.w500,
              colorScheme.onSurface,
              TextDecoration.none,
              FontStyle.normal,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: double.infinity,
                    child: AddPeer(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:caribpay/constants/list_items.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/data/models/country.dart';
import 'package:caribpay/data/models/id.dart';
import 'package:caribpay/providers/admin_provider.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/widgets/custom_dropdown.dart';
import 'package:caribpay/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _dobController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _idTypeController = TextEditingController();
  final _idNumberController = TextEditingController();
  bool _isButtonEnabled = false;

  DateTime? dob;
  String countryId = '';
  String idType = '';

  void _openDatePicker(
    BuildContext context,
    TextEditingController controller,
    ColorScheme colorScheme,
  ) {
    DateTime today = DateTime.now();
    DateTime maxDate = DateTime(today.year - 18, today.month, today.day);
    DateTime minDate = DateTime(1900, 1, 1);
    BottomPicker.date(
      pickerTitle: Text(
        'Select Date of Birth',
        style: getTextStyle(
          context,
          20,
          FontWeight.normal,
          colorScheme.onSurface,
          TextDecoration.none,
          FontStyle.normal,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      displayCloseIcon: true,
      closeIconColor: colorScheme.onSurface,
      closeIconSize: 30,
      dismissable: false,
      initialDateTime: maxDate,
      maxDateTime: maxDate,
      minDateTime: minDate,
      displaySubmitButton: true,
      buttonStyle: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(fBorderRadius),
      ),
      buttonWidth: 200,
      backgroundColor: colorScheme.surfaceContainer,
      pickerTextStyle: getTextStyle(
        context,
        20,
        FontWeight.normal,
        colorScheme.onSurface,
        TextDecoration.none,
        FontStyle.normal,
      ),
      onChange: (p0) {
        _validateFields();
        setState(() {
          dob = p0;
        });
        DateTime parsedDate = DateTime.parse(p0.toString().substring(0, 10));
        String formattedDate = DateFormat('MMMM d, y').format(parsedDate);
        controller.text = formattedDate;
      },
      bottomPickerTheme: BottomPickerTheme.blue,
    ).show(context);
  }

  void _validateFields() {
    setState(() {
      _isButtonEnabled =
          dob != null &&
          _addressLine1Controller.text.trim().isNotEmpty &&
          _cityController.text.trim().isNotEmpty &&
          _countryController.text.trim().isNotEmpty &&
          _idTypeController.text.trim().isNotEmpty &&
          _idNumberController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminData = context.watch<AdminProvider>().adminData;
    final authProvider = context.watch<AuthProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile', style: getAppBarTextStyle(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: fPadding),
              CustomTextField(
                controller: _dobController,
                hintText: '(dd/mm/yyyy)',
                labelText: "Date of Birth",
                readOnly: true,
                onChanged: (_) => _validateFields(),
                onTap: () {
                  _openDatePicker(
                    context,
                    _dobController,
                    Theme.of(context).colorScheme,
                  );
                },
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _addressLine1Controller,
                onChanged: (_) => _validateFields(),
                hintText: 'Address',
                labelText: "Address Line 1",
                readOnly: false,
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _addressLine2Controller,
                onChanged: (_) => _validateFields(),
                hintText: 'Address',
                labelText: "Address Line 2",
                readOnly: false,
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _cityController,
                onChanged: (_) => _validateFields(),
                hintText: 'City/Village',
                labelText: "City/Village",
                readOnly: false,
              ),
              const SizedBox(height: fSmallSpacing),
              CustomDropdown<CountryModel>(
                height: 60,
                controller: _countryController,
                labelText: 'Country',
                labelStyle: getTextStyle(
                  context,
                  16,
                  FontWeight.w500,
                  colorScheme.onSurface,
                  TextDecoration.none,
                  FontStyle.normal,
                ),
                labelPadding: const EdgeInsets.only(bottom: 0),
                bottomSheetTitle: 'Select Country',
                items: adminData.countries ?? [],
                itemTextBuilder: (location) => location.name,
                isRequired: true,
                onSelected: (selectedItems) {
                  setState(() {
                    _validateFields();
                    if (selectedItems.isNotEmpty) {
                      _countryController.text = selectedItems[0].name;
                      countryId = selectedItems[0].id;
                    } else {
                      _countryController.clear();
                      countryId = '';
                    }
                  });
                },
              ),
              const SizedBox(height: fSmallSpacing),
              CustomDropdown<IDType>(
                height: 60,
                controller: _idTypeController,
                labelText: 'Id Type',
                labelStyle: getTextStyle(
                  context,
                  16,
                  FontWeight.w500,
                  colorScheme.onSurface,
                  TextDecoration.none,
                  FontStyle.normal,
                ),
                labelPadding: const EdgeInsets.only(bottom: 0),
                bottomSheetTitle: 'Select Id Type',
                items: idTypes,
                itemTextBuilder: (location) => location.label,
                isRequired: true,
                onSelected: (selectedItems) {
                  setState(() {
                    _validateFields();
                    if (selectedItems.isNotEmpty) {
                      _idTypeController.text = selectedItems[0].label;
                      idType = selectedItems[0].value;
                    } else {
                      _idTypeController.clear();
                      idType = '';
                    }
                  });
                },
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _idNumberController,
                hintText: 'ID Number',
                labelText: "ID Number",
                onChanged: (_) => _validateFields(),
                readOnly: false,
              ),
              const SizedBox(height: fSpacing),
              SizedBox(
                height: fButtonHeight,
                width: size.width,
                child: GFButton(
                  color: colorScheme.primary,
                  borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(fLargeBorderRadius),
                  ),
                  text: "Update Profile",
                  textStyle: getTextStyle(
                    context,
                    18,
                    FontWeight.w600,
                    colorScheme.onError,
                    TextDecoration.none,
                    FontStyle.normal,
                  ),
                  onPressed:
                      _isButtonEnabled
                          ? () {
                            authProvider.user = authProvider.user?.copyWith(
                              dateOfBirth: dob,
                              addressLine1: _addressLine1Controller.text.trim(),
                              addressLine2: _addressLine2Controller.text.trim(),
                              city: _cityController.text.trim(),
                              countryId: countryId,
                              idType: idType,
                              idNumber: _idNumberController.text.trim(),
                              nationality: _countryController.text.trim(),
                            );

                            authProvider.updateProfile(authProvider.user!);
                          }
                          : null,
                ),
              ),
              const SizedBox(height: fSmallSpacing),
            ],
          ),
        ),
      ),
    );
  }
}

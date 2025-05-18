// ignore_for_file: use_build_context_synchronously

import 'package:caribpay/constants/enums.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/transitions.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/screens/auth/views/login_screen.dart';
import 'package:caribpay/widgets/custom_loading_indicator.dart';
import 'package:caribpay/widgets/custom_text_field.dart';
import 'package:caribpay/widgets/logo.dart';
import 'package:caribpay/widgets/password_field.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValid = false;
  final maskFormatter = MaskTextInputFormatter(
    mask: '(###) ### - ####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  void validate() {
    final isValid =
        _firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty &&
        _emailController.text.contains('@') &&
        _phoneNumberController.text.trim().length >= 10 &&
        _passwordController.text.length >= 6;

    setState(() {
      this.isValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: const Logo()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: fSpacing),
              Text(
                'Create your account',
                style: getTextStyle(
                  context,
                  24,
                  FontWeight.w600,
                  colorScheme.onSurface,
                  TextDecoration.none,
                  FontStyle.normal,
                ),
              ),
              Text(
                'Sign up to get started',
                style: getTextStyle(
                  context,
                  16,
                  FontWeight.normal,
                  colorScheme.onSurface.withValues(alpha: 0.6),
                  TextDecoration.none,
                  FontStyle.normal,
                ),
              ),
              const SizedBox(height: fSpacing),
              CustomTextField(
                controller: _firstNameController,
                hintText: 'John',
                labelText: "First Name",
                onChanged: (_) => validate(),
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _lastNameController,
                hintText: 'Doe',
                labelText: "Last Name",
                onChanged: (_) => validate(),
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _emailController,
                hintText: 'your@email.com',
                labelText: "Email",
                iconPrefix: FluentIcons.mail_32_regular,
                onChanged: (_) => validate(),
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _phoneNumberController,
                hintText: '+1 234 567 8900',
                labelText: "Phone Number",
                iconPrefix: FluentIcons.phone_32_regular,
                onChanged: (_) => validate(),
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: fSmallSpacing),
              PasswordField(
                controller: _passwordController,
                iconPrefix: FluentIcons.lock_closed_32_regular,
                showForgotPassword: false,
                onChanged: (_) => validate(),
              ),
              const SizedBox(height: fSpacing * 2),
              authProvider.isLoading
                  ? SizedBox(
                    height: fButtonHeight,
                    child: CustomLoadingIndicator(),
                  )
                  : SizedBox(
                    height: fButtonHeight,
                    width: size.width,
                    child: GFButton(
                      color: colorScheme.primary,
                      borderShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(fLargeBorderRadius),
                      ),
                      icon: Icon(
                        PhosphorIcons.signIn(),
                        color: colorScheme.onPrimary,
                      ),
                      text: "Sign Up",
                      textStyle: getTextStyle(
                        context,
                        18,
                        FontWeight.w600,
                        colorScheme.onError,
                        TextDecoration.none,
                        FontStyle.normal,
                      ),
                      onPressed:
                          isValid
                              ? () {
                                final firstName = _firstNameController.text;
                                final lastName = _lastNameController.text;
                                final email = _emailController.text;
                                final phone = _phoneNumberController.text;
                                final password = _passwordController.text;
                                authProvider
                                    .register(
                                      firstName,
                                      lastName,
                                      email,
                                      phone,
                                      password,
                                    )
                                    .then(
                                      (status) => {
                                        if (status == QueryStatus.success)
                                          {
                                            toastification.show(
                                              type: ToastificationType.success,
                                              title: Text(
                                                'Registration Successful',
                                                style: getTextStyle(
                                                  context,
                                                  16,
                                                  FontWeight.w600,
                                                  colorScheme.onSurface,
                                                  TextDecoration.none,
                                                  FontStyle.normal,
                                                ),
                                              ),
                                              description: Text(
                                                'You can now log in to your account.',
                                                style: getTextStyle(
                                                  context,
                                                  14,
                                                  FontWeight.w400,
                                                  colorScheme.onSurface
                                                      .withValues(alpha: 0.6),
                                                  TextDecoration.none,
                                                  FontStyle.normal,
                                                ),
                                              ),
                                              style:
                                                  ToastificationStyle
                                                      .flatColored,
                                              primaryColor: colorScheme.primary,
                                              showProgressBar: false,
                                              autoCloseDuration: const Duration(
                                                seconds: 3,
                                              ),
                                              alignment: Alignment.bottomCenter,
                                            ),
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              rightToLeft(
                                                context,
                                                const LoginScreen(),
                                              ),
                                              (route) => false,
                                            ),
                                          },
                                      },
                                    );
                              }
                              : null,
                    ),
                  ),
              const SizedBox(height: fSmallSpacing),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: getTextStyle(
                    context,
                    16,
                    FontWeight.w500,
                    colorScheme.onSurface.withValues(alpha: 0.6),
                    TextDecoration.none,
                    FontStyle.normal,
                  ),
                  children: [
                    TextSpan(
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                rightToLeft(context, const LoginScreen()),
                              );
                            },
                      text: 'Sign In',
                      style: getTextStyle(
                        context,
                        16,
                        FontWeight.w600,
                        colorScheme.primary,
                        TextDecoration.none,
                        FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

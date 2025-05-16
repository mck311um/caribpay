import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/transitions.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/screens/auth/views/login_screen.dart';
import 'package:caribpay/widgets/custom_text_field.dart';
import 'package:caribpay/widgets/logo.dart';
import 'package:caribpay/widgets/password_field.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

  final maskFormatter = MaskTextInputFormatter(
    mask: '(###) ### - ####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

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
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _firstNameController,
                hintText: 'Doe',
                labelText: "Last Name",
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _emailController,
                hintText: 'your@email.com',
                labelText: "Email",
                iconPrefix: FluentIcons.mail_32_regular,
              ),
              const SizedBox(height: fSmallSpacing),
              CustomTextField(
                controller: _phoneNumberController,
                hintText: '+1 234 567 8900',
                labelText: "Phone Number",
                iconPrefix: FluentIcons.phone_32_regular,
              ),
              const SizedBox(height: fSmallSpacing),
              PasswordField(
                controller: _passwordController,
                iconPrefix: FluentIcons.lock_closed_32_regular,
                showForgotPassword: false,
              ),
              const SizedBox(height: fSpacing * 2),
              SizedBox(
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
                  onPressed: () {},
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

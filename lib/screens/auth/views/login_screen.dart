import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/transitions.dart';
import 'package:caribpay/constants/values.dart';
import 'package:caribpay/providers/auth_provider.dart';
import 'package:caribpay/screens/auth/views/sign_up_screen.dart';
import 'package:caribpay/widgets/custom_loading_indicator.dart';
import 'package:caribpay/widgets/custom_text_field.dart';
import 'package:caribpay/widgets/logo.dart';
import 'package:caribpay/widgets/password_field.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to both controllers
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final emailValid = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);

    setState(() {
      _isButtonEnabled = emailValid && password.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Logo()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: fSpacing),
              Text(
                'Welcome Back',
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
                'Sign in to your account',
                style: getTextStyle(
                  context,
                  16,
                  FontWeight.normal,
                  colorScheme.onSurface.withValues(alpha: 0.6),
                  TextDecoration.none,
                  FontStyle.normal,
                ),
              ),
              const SizedBox(height: fSpacing * 1.25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'your@email.com',
                      labelText: "Email",
                      iconPrefix: FluentIcons.mail_32_regular,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: fSpacing),
                    PasswordField(
                      controller: _passwordController,
                      iconPrefix: FluentIcons.lock_closed_32_regular,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: fSpacing * 2),
              authProvider.isLoading
                  ? SizedBox(
                    height: fButtonHeight,
                    child: const CustomLoadingIndicator(),
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
                      text: "Sign In",
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
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text.trim();
                                  final password =
                                      _passwordController.text.trim();
                                  authProvider.login(email, password);
                                }
                              }
                              : null,
                    ),
                  ),
              const SizedBox(height: fSpacing),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
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
                                rightToLeft(context, const SignUpScreen()),
                              );
                            },
                      text: 'Sign Up',
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
              const SizedBox(height: fSpacing * 2),
            ],
          ),
        ),
      ),
    );
  }
}

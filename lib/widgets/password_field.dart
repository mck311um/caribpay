import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/text_field/gf_text_field_rounded.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final bool disabled;
  final bool isRequired;
  final TextInputType keyboardType;
  final IconData? iconPrefix;
  final bool showForgotPassword;
  final List<TextInputFormatter> formatters;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    this.labelStyle,
    this.labelPadding,
    this.disabled = false,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.iconPrefix,
    this.showForgotPassword = true,
    this.formatters = const [],
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password',
              style: getTextStyle(
                context,
                16,
                FontWeight.w500,
                colorScheme.onSurface.withValues(alpha: 0.8),
                TextDecoration.none,
                FontStyle.normal,
              ),
            ),
            if (widget.showForgotPassword)
              GestureDetector(
                child: Text(
                  'Forgot Password?',
                  style: getTextStyle(
                    context,
                    14,
                    FontWeight.w400,
                    colorScheme.primary,
                    TextDecoration.none,
                    FontStyle.normal,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        FormField<String>(
          validator: widget.validator,
          builder: (formFieldState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Opacity(
                        opacity: widget.disabled ? 0.6 : 1.0,
                        child: AbsorbPointer(
                          absorbing: widget.disabled,
                          child: GFTextFieldRounded(
                            iconPrefix:
                                widget.iconPrefix != null
                                    ? Icon(widget.iconPrefix)
                                    : null,
                            marginhorizontal: 0,
                            paddinghorizontal: 0,
                            keyboardType: widget.keyboardType,
                            editingbordercolor: colorScheme.primary,
                            idlebordercolor:
                                widget.disabled
                                    ? colorScheme.onSurface.withValues(
                                      alpha: 0.3,
                                    )
                                    : colorScheme.onSurface.withValues(
                                      alpha: 0.5,
                                    ),
                            borderwidth: 1.0,
                            cornerradius: fBorderRadius * 2,
                            hintText: 'Enter your password',
                            controller: widget.controller,
                            inputFormatters: widget.formatters,
                            obscureText: obscure,
                            style: getTextStyle(
                              context,
                              16,
                              FontWeight.w500,
                              widget.disabled
                                  ? colorScheme.onSurface.withValues(alpha: 0.5)
                                  : colorScheme.onSurface,
                              TextDecoration.none,
                              FontStyle.normal,
                            ),
                            onChanged: (_) {
                              formFieldState.didChange(widget.controller.text);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          onPressed: () => setState(() => obscure = !obscure),
                        ),
                      ),
                    ],
                  ),
                ),
                if (formFieldState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Text(
                      formFieldState.errorText!,
                      style: getTextStyle(
                        context,
                        12,
                        FontWeight.normal,
                        colorScheme.error,
                        TextDecoration.none,
                        FontStyle.normal,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

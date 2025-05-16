import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final bool disabled;
  final bool isRequired;
  final TextInputType keyboardType;
  final IconData? iconPrefix;
  final List<TextInputFormatter> formatters;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.labelStyle,
    this.labelPadding,
    this.disabled = false,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.iconPrefix,
    this.formatters = const [],
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText.isNotEmpty)
          Row(
            children: [
              Text(
                labelText,
                style:
                    labelStyle ??
                    getTextStyle(
                      context,
                      16,
                      FontWeight.w500,
                      colorScheme.onSurface.withValues(alpha: 0.8),
                      TextDecoration.none,
                      FontStyle.normal,
                    ),
              ),
            ],
          ),
        SizedBox(
          height: 60,
          child: Opacity(
            opacity: disabled ? 0.6 : 1.0,
            child: AbsorbPointer(
              absorbing: disabled,
              child: GFTextFieldRounded(
                iconPrefix: iconPrefix != null ? Icon(iconPrefix) : null,
                marginhorizontal: 0,
                paddinghorizontal: 0,
                keyboardType: keyboardType,
                editingbordercolor: colorScheme.primary,
                errorbordercolor: colorScheme.error,

                idlebordercolor:
                    disabled
                        ? colorScheme.onSurface.withValues(alpha: 0.3)
                        : colorScheme.onSurface.withValues(alpha: 0.5),
                borderwidth: 1.0,
                cornerradius: fBorderRadius * 2,
                hintText: hintText,
                controller: controller,
                inputFormatters: formatters,
                validator: validator,
                style: getTextStyle(
                  context,
                  16,
                  FontWeight.w500,
                  disabled
                      ? colorScheme.onSurface.withValues(alpha: 0.5)
                      : colorScheme.onSurface,
                  TextDecoration.none,
                  FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

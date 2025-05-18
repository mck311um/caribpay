import 'package:caribpay/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ToggleListTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? subLabel;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color iconColor;

  const ToggleListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.iconColor,
    this.subLabel,
  });

  @override
  State<ToggleListTile> createState() => _ToggleListTileState();
}

class _ToggleListTileState extends State<ToggleListTile> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      leading: Icon(widget.icon, color: widget.iconColor),
      title: Text(
        widget.label,
        style: getTextStyle(
          context,
          14,
          FontWeight.w500,
          colorScheme.onSurface,
          TextDecoration.none,
          FontStyle.normal,
        ),
      ),
      subtitle:
          widget.subLabel != null
              ? Text(
                widget.subLabel!,
                style: getTextStyle(
                  context,
                  12,
                  FontWeight.w400,
                  colorScheme.onSurface,
                  TextDecoration.none,
                  FontStyle.normal,
                ),
              )
              : null,
      trailing: Transform.scale(
        scale: 0.7,
        child: Switch(value: widget.value, onChanged: widget.onChanged),
      ),
    );
  }
}

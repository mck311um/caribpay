import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key});

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LoadingIndicator(
      indicatorType: Indicator.ballClipRotateMultiple,
      colors: [
        colorScheme.primary,
        colorScheme.secondary,
        colorScheme.tertiary,
      ],
      strokeWidth: 2,
      backgroundColor: Colors.transparent,
      pathBackgroundColor: colorScheme.surface,
    );
  }
}

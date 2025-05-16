import 'package:caribpay/constants/color_scheme.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:caribpay/constants/values.dart';
import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -4,
      end: -8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: CustomColors.turquoise,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: CustomColors.coral,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Positioned(
                  top: _floatAnimation.value,
                  right: -4,
                  child: child!,
                );
              },
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: CustomColors.sunrise,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: fSmallSpacing),
        RichText(
          text: TextSpan(
            style: getTextStyle(
              context,
              28,
              FontWeight.bold,
              colorScheme.onSurface,
              TextDecoration.none,
              FontStyle.normal,
            ),
            children: [
              TextSpan(
                text: 'Carib',
                style: TextStyle(color: CustomColors.turquoise),
              ),
              TextSpan(
                text: 'Pay',
                style: TextStyle(color: CustomColors.coral),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

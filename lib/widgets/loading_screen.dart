import 'package:flutter/material.dart';
import 'package:caribpay/widgets/custom_loading_indicator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CustomLoadingIndicator(),
          ),
        ),
      ),
    );
  }
}

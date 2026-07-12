import 'package:flutter/material.dart';

class FTAgreementText extends StatelessWidget {
  const FTAgreementText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }
}

import 'package:flutter/material.dart';

class AgreementText extends StatelessWidget {
  const AgreementText({super.key, required this.text});
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

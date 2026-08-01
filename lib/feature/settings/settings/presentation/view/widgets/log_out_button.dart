import 'package:flutter/material.dart';

class CustomLogOutButton extends StatelessWidget {
  const CustomLogOutButton({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    required this.text,
    this.onPressed,
  });
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String text;
  final void Function()? onPressed;

  const CustomLogOutButton.cancel(
    BuildContext context, {
    super.key,
    this.onPressed,
  }) : foregroundColor = Colors.white,
       backgroundColor = Colors.grey,
       text = 'context.l10n.cancel';
  const CustomLogOutButton.ok(BuildContext context, {super.key, this.onPressed})
    : foregroundColor = Colors.white,
      backgroundColor = Colors.blueAccent,
      text = 'context.l10n.ok';
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

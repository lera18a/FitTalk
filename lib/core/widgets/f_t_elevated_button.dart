import 'package:flutter/material.dart';

class FTElevatedButton extends StatelessWidget {
  const FTElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });
  final String text;
  final void Function()? onPressed;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => onPressed,
          icon: icon,
          // Icon(CupertinoIcons.mail, color: Colors.black),
          label: Text(
            text,
            // context.l10n.'continueWithEmail',
            style: const TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 13),
          ),
        ),
      ],
    );
  }
}

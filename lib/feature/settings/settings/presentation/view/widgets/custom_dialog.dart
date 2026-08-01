import 'package:fit_talk/feature/settings/settings/presentation/view/widgets/log_out_button.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('log Out?'),
      // content: Text('data')
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomLogOutButton.cancel(
                context,
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomLogOutButton.ok(
                context,
                onPressed: () => Navigator.pop(context, true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

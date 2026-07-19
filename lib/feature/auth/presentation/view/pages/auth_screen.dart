import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/core/widgets/f_t_agreement_text.dart';
import 'package:fit_talk/core/widgets/f_t_elevated_button.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OauthScreen extends StatelessWidget {
  const OauthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: .spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: .stretch,
          children: [
            Align(
              alignment: .center,
              child: Icon(Icons.ac_unit_rounded, size: 140),
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: .spaceAround,
                children: [SizedBox(height: 30)],
              ),
            ),
            FTElevatedButton(
              icon: Icon(CupertinoIcons.mail, color: Colors.black),
              text: 'Continue with email',
              onPressed: () {
                context.router.push(SendOtpRoute());
              },
            ),
            const SizedBox(height: 15),
            FTAgreementText(text: 'userAgreementSignIn'),
          ],
        ),
      ),
    );
  }
}

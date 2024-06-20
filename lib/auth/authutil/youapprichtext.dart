import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youapp/module/auth/auth_module.dart';
import 'package:youapp/util/app_router.dart';
import 'package:youapp/util/youapp_text_style.dart';

class AuthRichText extends StatelessWidget {
  const AuthRichText({
    super.key,
    required this.str1,
    required this.actionText,
    required this.route,
  });

  final String str1;
  final String actionText;
  final String route;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(text: str1, children: [
          TextSpan(
              text: actionText,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppRouter.changeRoute<AuthModule>(route);
                },
              style: authStyle),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';

class DynamicYouAppAuthButton extends StatelessWidget {
  const DynamicYouAppAuthButton({
    super.key,
    required this.isButtonEnabled,
    required this.str,
  });

  final bool isButtonEnabled;
  final String str;

  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(
          color: isButtonEnabled
              ? YouAppColor.whiteColor
              : YouAppColor.disableTextColor,
          fontSize: 16),
    );
  }
}

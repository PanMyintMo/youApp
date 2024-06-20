import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';

class YouAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool isEnabled;

  const YouAppButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: isEnabled
                ? [
                    YouAppColor.disableBtnColor,
                    YouAppColor.disableBtnOneColor,
                  ]
                : [
                    YouAppColor.disableBtnColor.withOpacity(0.2),
                    YouAppColor.disableBtnOneColor.withOpacity(0.3),
                  ],
            stops: const [0.2488, 0.7849],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: child),
      ),
    );
  }
}

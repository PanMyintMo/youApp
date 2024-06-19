import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(1.0, -0.03), // Adjust the alignment as needed
          radius: 1.22, // Adjust the radius to match the gradient spread
          colors: [
            Color(0xFF1F4247),
            Color(0xFF0D1D23),
            Color(0xFF09141A),
          ],
          stops: [
            0.0,
            0.5618,
            1.0
          ], // Adjust the stops to match the gradient transitions
        ),
      ),
      child: child,
    );
  }
}

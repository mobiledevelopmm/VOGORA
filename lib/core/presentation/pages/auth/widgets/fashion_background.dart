
import 'package:flutter/material.dart';

class FashionBackground extends StatelessWidget {
  final Widget child;
  final double overlayOpacity;

  const FashionBackground({
    super.key,
    required this.child,
    this.overlayOpacity = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/vogora_splash.png',
          fit: BoxFit.cover,
        ),
        ColoredBox(
          color: Color.fromRGBO(
            255,
            250,
            245,
            overlayOpacity,
          ),
        ),
        child,
      ],
    );
  }
}

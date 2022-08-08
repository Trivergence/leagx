import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    Key? key,
    required this.child,
    this.gradient = const LinearGradient(
      colors: [
        Color(0xFFFFC56E),
        Color(0xFFFFB36E),
        Color(0xFFFF8D6D),
        Color(0xFFF8485E),
      ],
    ),
    this.style,
  }) : super(key: key);

  final Widget child;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}

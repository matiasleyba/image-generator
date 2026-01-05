import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';

/// {@template animated_gradient_background}
/// Widget that displays an animated gradient background.
/// {@endtemplate}
class AnimatedGradientBackground extends StatelessWidget {
  /// {@macro animated_gradient_background}
  const AnimatedGradientBackground({
    super.key,
    required this.colors,
    required this.previousColors,
    required this.child,
  });

  /// The colors of the gradient.
  final List<Color>? colors;

  /// The previous colors of the gradient.
  final List<Color>? previousColors;

  /// The child of the container.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
      primaryColors: previousColors ?? <Color>[Colors.white, Colors.grey],
      secondaryColors: colors ?? <Color>[Colors.white, Colors.grey],
      duration: const Duration(milliseconds: 2000),
      repeat: false,
      child: child,
    );
  }
}

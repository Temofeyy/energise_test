import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class AnimatedCircularGlowing extends StatelessWidget {
  const AnimatedCircularGlowing({
    super.key,
    required this.child,
    this.animate = true,
  });

  final Widget child;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      animate: animate,
      glowCount: 1,
      glowColor: Colors.purple,
      child: child,
    );
  }
}

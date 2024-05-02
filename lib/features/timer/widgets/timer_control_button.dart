import 'package:energise_test/features/timer/widgets/animated_circular_glowing.dart';
import 'package:flutter/material.dart';

class TimerControlButton extends StatelessWidget {
  const TimerControlButton({
    super.key,
    this.enable = true,
    required this.isTimerStarted,
    required this.onStart,
    required this.onPause,
  });

  final bool enable;
  final bool isTimerStarted;
  final VoidCallback onStart;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularGlowing(
      animate: !isTimerStarted & enable,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        onPressed: enable
            ? isTimerStarted
                ? onPause
                : onStart
            : null,
        child: Icon(
          isTimerStarted ? Icons.pause : Icons.play_arrow,
          size: 40,
        ),
      ),
    );
  }
}

import 'package:energise_test/features/timer/widgets/animated_circular_glowing.dart';
import 'package:flutter/material.dart';

class TimerStatusButton extends StatelessWidget {
  const TimerStatusButton({
    super.key,
    required this.isTimerStarted,
    required this.onPickDuration,
    required this.remainingDuration,
  });

  final bool isTimerStarted;
  final VoidCallback onPickDuration;
  final Duration remainingDuration;

  String formattedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final min = twoDigits(duration.inMinutes.remainder(60));
    final sec = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularGlowing(
      animate: isTimerStarted,
      child: FilledButton(
        onPressed: isTimerStarted ? () {} : onPickDuration,
        style: FilledButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size.square(250),
          padding: const EdgeInsets.symmetric(vertical: 40),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              formattedDuration(remainingDuration),
              style: const TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isTimerStarted ? 0 : 1,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Icon(Icons.edit, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

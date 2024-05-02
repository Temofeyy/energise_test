import 'dart:async';

import 'package:energise_test/features/timer/widgets/timer_control_button.dart';
import 'package:energise_test/features/timer/widgets/timer_status_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerProvider extends ChangeNotifier {
  TimerProvider();

  static const _period = Duration(seconds: 1);

  Timer? _timer;

  var _duration = Duration.zero;
  Duration get duration => _duration;

  var _remainingDuration = Duration.zero;
  Duration get remainingDuration => _remainingDuration;

  bool get isTimerStarted => _timer?.isActive ?? false;
  bool get isDurationPicked => _duration != Duration.zero;

  void changeTimer(Duration duration) {
    if (isTimerStarted) return;
    _duration = duration;
    _remainingDuration = _duration;
    notifyListeners();
  }

  void startTimer() {
    if (isTimerStarted) return;
    _timer = Timer.periodic(_period, (_) {
      if (_remainingDuration == Duration.zero) {
        stopTimer();
        return;
      }
      _remainingDuration -= _period;
      notifyListeners();
    });
    notifyListeners();
  }

  void stopTimer() {
    if (!isTimerStarted) return;
    _timer!.cancel();
    _remainingDuration = _duration;
    notifyListeners();
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final _timer = TimerProvider();

  Future<void> _pickDuration() async {
    final duration = await showDurationPicker();
    if (duration != null) _timer.changeTimer(duration);
  }

  Future<Duration?> showDurationPicker() {
    var duration = Duration.zero;
    return showModalBottomSheet<Duration?>(
      context: context,
      backgroundColor: Colors.black,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CupertinoTimerPicker(
              initialTimerDuration: _timer.duration,
              onTimerDurationChanged: (d) => duration = d,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
              child: FilledButton(
                onPressed: () => Navigator.of(ctx).pop(duration),
                child: const Text("Set"),
              ),
            ), //TODO: loc
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerProvider>.value(
      value: _timer,
      child: Consumer<TimerProvider>(
        builder: (_, timer, __) {
          return Column(
            children: [
              const SizedBox(height: 80),
              TimerStatusButton(
                isTimerStarted: timer.isTimerStarted,
                onPickDuration: _pickDuration,
                remainingDuration: _timer.remainingDuration,
              ),
              const Spacer(),
              TimerControlButton(
                enable: timer.isDurationPicked,
                isTimerStarted: timer.isTimerStarted,
                onStart: timer.startTimer,
                onPause: timer.stopTimer,
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

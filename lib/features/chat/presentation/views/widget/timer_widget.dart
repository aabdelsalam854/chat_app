import 'dart:async';
import 'package:flutter/material.dart';

class TimeController extends ValueNotifier<bool> {
  TimeController({bool isPlaying = false}) : super(isPlaying);
  void startTimer() => value = true;
  void stopTimer() => value = false;
  void resumeTimer() {
    value = true;
  }

  void pauseTimer() => value = false;
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.controller});
  final TimeController controller;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration duration = const Duration();
  Duration remainingDuration = const Duration();
  late Timer timer = Timer(Duration.zero, () {});
  void reset() {
    setState(() {
      duration = const Duration();
      remainingDuration = const Duration();
    });
  }

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = remainingDuration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer.cancel();
      } else {
        remainingDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }
    remainingDuration = duration;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      addTime();
    });
  }

  void stopTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }
    timer.cancel();
  }

  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.value) {
        startTimer();
      } else {
        stopTimer();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Text(remainingDuration.inSeconds.toString()),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

///* This Timer Frozen the ResentButton (or other in your sick).
/// And check in Text which seconds tick
/// Use this for your UI button with logic
/// - For example(my case):
/// 1) sendOTP(frozen/timer ticked)
/// 2) readyToResendOtp(unFrozen/stop timer)*
class FrozenTimer extends StatefulWidget {
  const FrozenTimer({super.key, this.seconds = 60, required this.onFinished});

  final int seconds;
  final Function() onFinished;
  @override
  State<FrozenTimer> createState() => _FrozenTimerState();
}

class _FrozenTimerState extends State<FrozenTimer> {
  Timer? _timer;
  late int _currentSeconds;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.seconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentSeconds > 0) {
        setState(() => _currentSeconds--);
      }
      if (_currentSeconds == 0) {
        _timer?.cancel();
        widget.onFinished();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_currentSeconds.toString());
  }
}

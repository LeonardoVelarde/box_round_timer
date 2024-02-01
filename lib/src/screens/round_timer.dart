import 'dart:async';
import 'dart:developer';

import 'package:boxing_round_timer/src/utils/timer_formatter.dart';
import 'package:flutter/material.dart';

class RoundTimer extends StatefulWidget {
  final int roundSeconds;
  final int roundCount;
  final int restSeconds;
  final int preparationSeconds;
  final int soundIntervalSeconds;

  const RoundTimer(
      {super.key,
      required this.roundSeconds,
      required this.roundCount,
      required this.restSeconds,
      required this.preparationSeconds,
      required this.soundIntervalSeconds});

  @override
  State<RoundTimer> createState() => _RoundTimerState();
}

class _RoundTimerState extends State<RoundTimer> {
  int _roundCounter = 1;
  Timer? _timer;
  int _roundLengthInMillies = 0;

  void _increaseRoundCounter() {
    setState(() {
      _roundCounter++;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      debugPrint(
          'Round milies: ${TimerFormatter.formatFromMilliseconds(_roundLengthInMillies)}');
      setState(() {
        _roundLengthInMillies -= 20;
      });
      if (_roundLengthInMillies == 0) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resumeTimer() {
    _startTimer();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _roundLengthInMillies = widget.roundSeconds * 1000;
    });
  }

  @override
  void initState() {
    super.initState();
    _roundLengthInMillies = widget.roundSeconds * 1000;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Round $_roundCounter',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            const Spacer(),
            Text(
              TimerFormatter.formatFromMilliseconds(_roundLengthInMillies),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 80,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: _stopTimer, child: const Text('Pause')),
                ElevatedButton(
                    onPressed: _resumeTimer, child: const Text('Resume')),
                ElevatedButton(
                    onPressed: _resetTimer, child: const Text('Reset')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

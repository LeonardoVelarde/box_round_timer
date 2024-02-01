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
              'Round ${widget.roundCount}',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            const Spacer(),
            Text(
              TimerFormatter.format(widget.roundSeconds),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 90,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

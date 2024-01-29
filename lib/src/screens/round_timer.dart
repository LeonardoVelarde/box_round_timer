import 'package:flutter/material.dart';

class RoundTimer extends StatefulWidget {
  final int roundSeconds;

  const RoundTimer({super.key, required this.roundSeconds});

  @override
  State<RoundTimer> createState() => _RoundTimerState();
}

class _RoundTimerState extends State<RoundTimer> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.roundSeconds.toString(),
      style: const TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

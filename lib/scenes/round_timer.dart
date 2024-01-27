import 'package:flutter/material.dart';

class RoundTimer extends StatelessWidget {
  final int seconds;

  RoundTimer({required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Text(
      seconds.toString(),
      style: const TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/timer_formatter.dart';

class TimerInput extends StatefulWidget {
  final int valueInSeconds;
  final void Function(int) onValueChanged;
  final String label;
  final String increaseValueTooltip;
  final String decreaseValueTooltip;
  final IconData iconLabel;
  final int delta;

  const TimerInput({
    super.key,
    required this.valueInSeconds,
    required this.onValueChanged,
    required this.label,
    required this.increaseValueTooltip,
    required this.decreaseValueTooltip,
    required this.iconLabel,
    this.delta = 5,
  });

  @override
  State<TimerInput> createState() => _TimerInputState();
}

class _TimerInputState extends State<TimerInput> {
  int _roundLengthInSec = 0;

  void _changeRoundTimerValue(int seconds) {
    if (_roundLengthInSec + seconds < 0) return;
    setState(() {
      _roundLengthInSec += seconds;
    });
    widget.onValueChanged(_roundLengthInSec);
  }

  @override
  void initState() {
    super.initState();
    _roundLengthInSec = widget.valueInSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(),
        Column(
          children: [
            Text(TimerFormatter.formatFromSeconds(_roundLengthInSec),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 60, color: Colors.white)),
            Text(widget.label, style: const TextStyle(color: Colors.white)),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.add, color: Color.fromARGB(255, 25, 118, 210), size: 40),
          tooltip: widget.increaseValueTooltip,
          onPressed: () {
            _changeRoundTimerValue(widget.delta);
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove, color: Color.fromARGB(255, 213, 0, 0), size: 40),
          tooltip: widget.decreaseValueTooltip,
          onPressed: () {
            _changeRoundTimerValue(-widget.delta);
          },
        ),
        const Spacer(),
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(child: Icon(widget.iconLabel, color: const Color.fromARGB(255, 238, 238, 238), size: 35)),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

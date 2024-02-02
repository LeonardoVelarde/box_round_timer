import 'package:flutter/material.dart';

import '../utils/timer_formatter.dart';

class TimerInput extends StatefulWidget {
  final int valueInSeconds;
  final void Function(int) onValueChanged;
  final String label;
  final String increaseValueTooltip;
  final String decreaseValueTooltip;
  final IconData icon;
  final int delta;

  const TimerInput({
    super.key,
    required this.valueInSeconds,
    required this.onValueChanged,
    required this.label,
    required this.increaseValueTooltip,
    required this.decreaseValueTooltip,
    required this.icon,
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
                style: const TextStyle(fontSize: 60)),
            Text(widget.label),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: widget.increaseValueTooltip,
          onPressed: () {
            _changeRoundTimerValue(widget.delta);
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove),
          tooltip: widget.decreaseValueTooltip,
          onPressed: () {
            _changeRoundTimerValue(-widget.delta);
          },
        ),
        const Spacer(),
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(child: Icon(widget.icon)),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

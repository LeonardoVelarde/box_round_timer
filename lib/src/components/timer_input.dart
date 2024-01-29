import 'package:flutter/material.dart';

class TimerInput extends StatefulWidget {
  final int valueInSeconds;
  final void Function(int) onValueChanged;
  final String label;
  final String increaseValueTooltip;
  final String decreaseValueTooltip;
  final Icon icon;

  const TimerInput({
    required this.valueInSeconds,
    required this.onValueChanged,
    required this.label,
    required this.increaseValueTooltip,
    required this.decreaseValueTooltip,
    required this.icon,
  });

  @override
  State<TimerInput> createState() => _TimerInputState();
}

class _TimerInputState extends State<TimerInput> {
  int _roundLengthInSec = 0;

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
            Text(
                '${_getFormattedMinutesFromSeconds(_roundLengthInSec)}:${_getFormattedSecondsFromSeconds(_roundLengthInSec)}',
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
            _changeRoundTimerValue(10);
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove),
          tooltip: widget.decreaseValueTooltip,
          onPressed: () {
            _changeRoundTimerValue(-10);
          },
        ),
        const Spacer(),
        const Text.rich(
          TextSpan(
            children: [
              WidgetSpan(child: Icon(Icons.timer_outlined)),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }

  void _changeRoundTimerValue(int seconds) {
    if (_roundLengthInSec + seconds < 0) return;
    setState(() {
      _roundLengthInSec += seconds;
    });
    widget.onValueChanged(_roundLengthInSec);
  }

  String _getFormattedMinutesFromSeconds(int seconds) {
    if (seconds < 60) return '00';
    return (seconds / 60).floor().toString().padLeft(2, '0');
  }

  String _getFormattedSecondsFromSeconds(int seconds) {
    return (seconds % 60).toString().padLeft(2, '0');
  }
}

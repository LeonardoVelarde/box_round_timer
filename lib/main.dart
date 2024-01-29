import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'src/components/timer_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Round Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'msheee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _roundLengthInSec = 90;
  int _roundCounter = 3;
  int _restTimeinSec = 30;
  int _preparationTimeinSec = 0;
  int _soundIntervalTimeinSec = 10;

  void _changeRoundTimerValue(int value) {
    if (_roundLengthInSec + value <= 0) {
      return;
    }
    setState(() {
      _roundLengthInSec += value;
    });
  }

  void _changeRestTimerValue(int value) {
    if (_restTimeinSec + value <= 0) {
      return;
    }
    setState(() {
      _restTimeinSec += value;
    });
  }

  void _changeRoundCounter(int value) {
    if (_roundCounter + value <= 0) {
      return;
    }
    setState(() {
      _roundCounter += value;
    });
  }

  void _changePreparationTime(int value) {
    if (_preparationTimeinSec + value <= 0) {
      return;
    }
    setState(() {
      _preparationTimeinSec += value;
    });
  }

  void _changeSoundIntervalTime(int value) {
    if (_soundIntervalTimeinSec + value <= 0) {
      return;
    }
    setState(() {
      _soundIntervalTimeinSec += value;
    });
  }

  String _getFormattedMinutesFromSeconds(int seconds) {
    return '0${seconds ~/ 60}';
  }

  String _getFormattedSecondsFromSeconds(int seconds) {
    if (seconds % 60 < 10) {
      return '0${seconds % 60}';
    } else {
      return '${seconds % 60}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boxing Round Timer'),
        backgroundColor: const Color.fromARGB(255, 253, 250, 230),
      ),
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                          '${_getFormattedMinutesFromSeconds(_roundLengthInSec)}:${_getFormattedSecondsFromSeconds(_roundLengthInSec)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 60)),
                      const Text('Round Length'),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar tiempo por 10s',
                    onPressed: () {
                      _changeRoundTimerValue(10);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir tiempo por 10s',
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
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                          '${_getFormattedMinutesFromSeconds(_restTimeinSec)}:${_getFormattedSecondsFromSeconds(_restTimeinSec)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 60)),
                      const Text('Rest Time'),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar tiempo por 10s',
                    onPressed: () {
                      _changeRestTimerValue(10);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir tiempo por 10s',
                    onPressed: () {
                      _changeRestTimerValue(-10);
                    },
                  ),
                  const Spacer(),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.snooze)),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                          '${_getFormattedMinutesFromSeconds(_preparationTimeinSec)}:${_getFormattedSecondsFromSeconds(_preparationTimeinSec)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 60)),
                      const Text('Preparation Time'),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar tiempo por 10s',
                    onPressed: () {
                      _changePreparationTime(10);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir tiempo por 10s',
                    onPressed: () {
                      _changePreparationTime(-10);
                    },
                  ),
                  const Spacer(),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.tune)),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                          '${_getFormattedMinutesFromSeconds(_soundIntervalTimeinSec)}:${_getFormattedSecondsFromSeconds(_soundIntervalTimeinSec)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 60)),
                      const Text('Secondary bell inverval'),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar tiempo por 10s',
                    onPressed: () {
                      _changeSoundIntervalTime(10);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir tiempo por 10s',
                    onPressed: () {
                      _changeSoundIntervalTime(-10);
                    },
                  ),
                  const Spacer(),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.hearing)),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Spacer(
                    flex: 3,
                  ),
                  Column(
                    children: [
                      Text('$_roundCounter',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 60)),
                      const Text('Rounds'),
                    ],
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar una ronda',
                    onPressed: () {
                      _changeRoundCounter(1);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir una ronda',
                    onPressed: () {
                      _changeRoundCounter(-1);
                    },
                  ),
                  const Spacer(),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.doorbell_outlined)),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // go to timer page
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 12.0,
                        textStyle: const TextStyle(color: Colors.white)),
                    child: const Text(
                      'Start',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              const Spacer(),
              TimerInput(
                valueInSeconds: _roundLengthInSec,
                label: 'Round Length',
                increaseValueTooltip: 'Aumentar tiempo por 10s',
                decreaseValueTooltip: 'Reducir tiempo por 10s',
                icon: const Icon(Icons.timer_outlined),
                onValueChanged: (value) {
                  setState(() {
                    _roundLengthInSec = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

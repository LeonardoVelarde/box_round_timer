// ignore: unused_import
import 'dart:developer' as developer;

import 'package:boxing_round_timer/src/screens/round_timer.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _roundLengthInSec = 90;
  int _roundCounter = 3;
  int _restTimeinSec = 30;
  int _preparationTimeinSec = 0;
  int _soundIntervalTimeinSec = 10;

  void _changeRoundCounter(int value) {
    if (_roundCounter + value <= 0) {
      return;
    }
    setState(() {
      _roundCounter += value;
    });
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
              TimerInput(
                valueInSeconds: _roundLengthInSec,
                label: 'Round Length',
                increaseValueTooltip: 'Aumentar tiempo por 10s',
                decreaseValueTooltip: 'Reducir tiempo por 10s',
                icon: Icons.timer_outlined,
                onValueChanged: (value) {
                  setState(() {
                    _roundLengthInSec = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              TimerInput(
                valueInSeconds: _restTimeinSec,
                label: 'Rest time',
                increaseValueTooltip: 'Aumentar tiempo por 10s',
                decreaseValueTooltip: 'Reducir tiempo por 10s',
                icon: Icons.snooze,
                onValueChanged: (value) {
                  setState(() {
                    _restTimeinSec = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              TimerInput(
                valueInSeconds: _preparationTimeinSec,
                label: 'Preparation time',
                increaseValueTooltip: 'Aumentar tiempo por 10s',
                decreaseValueTooltip: 'Reducir tiempo por 10s',
                icon: Icons.tune,
                onValueChanged: (value) {
                  setState(() {
                    _preparationTimeinSec = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              TimerInput(
                valueInSeconds: _soundIntervalTimeinSec,
                label: 'Secondary Bell',
                increaseValueTooltip: 'Aumentar tiempo por 10s',
                decreaseValueTooltip: 'Reducir tiempo por 10s',
                icon: Icons.hearing,
                onValueChanged: (value) {
                  setState(() {
                    _soundIntervalTimeinSec = value;
                  });
                },
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            // builder: (context) => RoundTimer(roundSeconds: _roundLengthInSec, roundCounter: _roundCounter, restSeconds: _restTimeinSec, preparationSeconds: _preparationTimeinSec, soundIntervalSeconds: _soundIntervalTimeinSec),
                            builder: (context) =>
                                RoundTimer(roundSeconds: _roundLengthInSec),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text(
                        'Start',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

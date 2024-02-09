// ignore: unused_import
import 'dart:developer' as developer;

import 'package:boxing_round_timer/src/screens/round_timer.dart';
import 'package:boxing_round_timer/src/utils/box_timer_theme.dart';
import 'package:flutter/material.dart';
import 'src/widgets/timer_input.dart';

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
  int _preparationTimeinSec = 5;
  int _roundLengthInSec = 5;
  int _restTimeinSec = 5;
  int _soundIntervalTimeinSec = 10;
  int _roundCount = 3;

  void _changeRoundCounter(int value) {
    if (_roundCount + value <= 0) {
      return;
    }
    setState(() {
      _roundCount += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center( child: Text('Box Timer', style: TextStyle(color: TimerSettingsScreenTheme.textColor))),
        backgroundColor: TimerSettingsScreenTheme.backgroundColor,
      ),
      backgroundColor: TimerSettingsScreenTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              TimerInput(
                valueInSeconds: _roundLengthInSec,
                label: 'Round Length',
                increaseValueTooltip: 'Aumentar tiempo por 15s',
                decreaseValueTooltip: 'Reducir tiempo por 15s',
                iconLabel: Icons.timer_outlined,
                onValueChanged: (value) {
                  setState(() {
                    _roundLengthInSec = value;
                  });
                },
                delta: 15,
              ),
              const SizedBox(height: 10),
              TimerInput(
                valueInSeconds: _restTimeinSec,
                label: 'Rest time',
                increaseValueTooltip: 'Aumentar tiempo por 5s',
                decreaseValueTooltip: 'Reducir tiempo por 5s',
                iconLabel: Icons.snooze,
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
                increaseValueTooltip: 'Aumentar tiempo por 5s',
                decreaseValueTooltip: 'Reducir tiempo por 5s',
                iconLabel: Icons.thumb_up,
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
                increaseValueTooltip: 'Aumentar tiempo por 5s',
                decreaseValueTooltip: 'Reducir tiempo por 5s',
                iconLabel: Icons.hearing,
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
                      Text('$_roundCount',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 60, color: TimerSettingsScreenTheme.textColor)),
                      const Text('Rounds', style: TextStyle(color: TimerSettingsScreenTheme.textColor)),
                    ],
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Color.fromARGB(255, 25, 118, 210)),
                    tooltip: 'Aumentar una ronda',
                    onPressed: () {
                      _changeRoundCounter(1);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color.fromARGB(255, 213, 0, 0)),
                    tooltip: 'Reducir una ronda',
                    onPressed: () {
                      _changeRoundCounter(-1);
                    },
                  ),
                  const Spacer(),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.doorbell_outlined, color: Color.fromARGB(255, 238, 238, 238),)),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RoundTimer(
                              roundSeconds: _roundLengthInSec,
                              roundCount: _roundCount,
                              restSeconds: _restTimeinSec,
                              preparationSeconds: _preparationTimeinSec,
                              soundIntervalSeconds: _soundIntervalTimeinSec),
                        ),
                      );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        side: const BorderSide(
                          width: 2.0,
                          color: TimerSettingsScreenTheme.startButtonOutlineColor,
                        ),
                        elevation: 12.0,
                        textStyle: const TextStyle(
                            color: TimerSettingsScreenTheme.textColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text( 'START', style: TextStyle(fontSize: 25.0, color: TimerSettingsScreenTheme.textColor))
                    )),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

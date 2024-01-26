import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'msheee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    setState(() {
      _roundLengthInSec += value;
    });
  }

  void _changeRestTimerValue(int value) {
    setState(() {
      _restTimeinSec += value;
    });
  }

  void _addRoundCounter(int value) {
    setState(() {
      _roundCounter += value;
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
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
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
                        WidgetSpan(child: Icon(Icons.timer)),
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
                      Text('$_roundCounter',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 60)),
                      const Text('Rounds'),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar una ronda',
                    onPressed: () {
                      _addRoundCounter(1);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir una ronda',
                    onPressed: () {
                      _addRoundCounter(-1);
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
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Spacer(),
                  const Text('01:30',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 60)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar tiempo por 30s',
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir tiempo por 30s',
                    onPressed: () {},
                  ),
                  const Spacer(),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.timer)),
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
                  const Text('01:30',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 60)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Aumentar tiempo por 30s',
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Reducir tiempo por 30s',
                    onPressed: () {},
                  ),
                  const Spacer(),
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.timer)),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

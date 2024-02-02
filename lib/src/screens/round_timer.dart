// ignore: unused_import
import 'dart:developer';

import 'package:boxing_round_timer/src/utils/timer_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

class _RoundTimerState extends State<RoundTimer> with SingleTickerProviderStateMixin {

  static const int PREPARATION_STATE = 0;
  static const int ROUND_STATE = 1;
  static const int REST_STATE = 2;
  static const int FINISHED_STATE = 3;
  
  int _roundCounter = 1;
  int _roundLengthInMillies = 0;
  int _prepLengthInMillies = 0;
  int _restLengthInMillies = 0;
  // ignore: unused_field
  int _secondaryBellIntervalInMillies = 0; // TODO: Implement secondary bell sounds
  int _currentTimerMillies = 0;
  int _currentCounterState = PREPARATION_STATE;
  late final Ticker _ticker;

  void _startTimer() {
    _ticker.start();
  }

  void _stopTimer() {
    _ticker.stop();
  }

  void _preparationStateTick(Duration elapsed) {
      setState(() {
        _currentTimerMillies = _prepLengthInMillies - elapsed.inMilliseconds;
        if (_currentTimerMillies <= 0) {
          _ticker.stop();
          _currentCounterState = ROUND_STATE;
          _currentTimerMillies = _roundLengthInMillies;
          _ticker.start();
        }
      });
  }

  void _roundStateTick(Duration elapsed) {
      setState(() {
        _currentTimerMillies = _roundLengthInMillies - elapsed.inMilliseconds;
        if (_currentTimerMillies <= 0) {
          _ticker.stop();
          if (_roundCounter == widget.roundCount) {
            _currentCounterState = REST_STATE;
            _currentTimerMillies = _restLengthInMillies;
            _ticker.start();
          } else {
            _currentCounterState = FINISHED_STATE;
            _ticker.stop();
          }
        }
      });
  }

  void _restStateTick(Duration elapsed) {
      setState(() {
        _currentTimerMillies = _restLengthInMillies - elapsed.inMilliseconds;
        if (_currentTimerMillies <= 0) {
          _ticker.stop();
          _currentCounterState = ROUND_STATE;
          _currentTimerMillies = _roundLengthInMillies;
          _roundCounter++;
          _ticker.start();
        }
      });
  }

  void _handleTick(Duration elapsed) {
    setState(() {
      switch (_currentCounterState) {
        case PREPARATION_STATE:
          _preparationStateTick(elapsed);
          break;
        case ROUND_STATE:
          _roundStateTick(elapsed);
          break;
        case REST_STATE:
          _restStateTick(elapsed);
          break;
      }
    });
  }

  String _getCurrentStateText() {
    switch (_currentCounterState) {
      case PREPARATION_STATE:
        return 'Preparation';
      case ROUND_STATE:
        return 'Round';
      case REST_STATE:
        return 'Rest';
      case FINISHED_STATE:
        return 'Match Ended';
      default:
        return 'bruh';
    }
  }

  @override
  void initState() {
    super.initState();
    _roundLengthInMillies = widget.roundSeconds * 1000;
    _prepLengthInMillies = widget.preparationSeconds * 1000;
    _restLengthInMillies = widget.restSeconds * 1000;
    _secondaryBellIntervalInMillies = widget.soundIntervalSeconds * 1000;
    _currentTimerMillies = _prepLengthInMillies;
    _currentCounterState = PREPARATION_STATE;
    _ticker = createTicker(_handleTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

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
              'Round $_roundCounter',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              'of ${widget.roundCount}',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            const Spacer(),
            Text(
              TimerFormatter.formatFromMilliseconds(_currentTimerMillies),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 80,
              ),
            ),
            const Spacer(),
            Text(
              _getCurrentStateText(),
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: _stopTimer, child: const Text('Pause')),
                ElevatedButton(
                    onPressed: _startTimer, child: const Text('Resume')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: unused_import
import 'dart:developer';

import 'package:boxing_round_timer/src/utils/timer_formatter.dart';
import 'package:audioplayers/audioplayers.dart';
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
  bool _isPlayingStarterBell = false;
  bool _isPlayingRegularBell = false;
  Color _backgroundColor = Colors.greenAccent;
  late final Ticker _ticker;
  final _player = AudioPlayer();

  void _startTimer() {
    _ticker.start();
  }

  void _stopTimer() {
    _ticker.stop();
  }

  void _resetTimer() {
    _ticker.stop();
    setState(() {
      _roundCounter = 1;
      _currentCounterState = PREPARATION_STATE;
      _currentTimerMillies = _prepLengthInMillies;
    });
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
        if (_currentTimerMillies < 3000 && !_isPlayingStarterBell) {
          _isPlayingStarterBell = true;
          _player.play(AssetSource('ear_stuff/starter_bell.wav'));
        }
      });
  }

  void _roundStateTick(Duration elapsed) {
      setState(() {
        _currentTimerMillies = _roundLengthInMillies - elapsed.inMilliseconds;
        if (_currentTimerMillies <= 0) {
          _ticker.stop();
          _player.play(AssetSource('ear_stuff/regular_bell.wav'));
          if (_roundCounter == widget.roundCount) {
            _currentCounterState = FINISHED_STATE;
            _backgroundColor = Colors.grey;
          } else {
            _currentCounterState = REST_STATE;
            _currentTimerMillies = _restLengthInMillies;
            _ticker.start();
          }
        }
      });
  }

  void _restStateTick(Duration elapsed) {
      setState(() {
        _currentTimerMillies = _restLengthInMillies - elapsed.inMilliseconds;
        if (_currentTimerMillies <= 0) {
          _ticker.stop();
          if (!_isPlayingRegularBell) {
            _isPlayingRegularBell = true;
            _player.play(AssetSource('ear_stuff/regular_bell.wav'));
          }
          _currentCounterState = ROUND_STATE;
          _currentTimerMillies = _roundLengthInMillies;
          _ticker.start();
          _roundCounter++;
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
    _player.onPlayerComplete.listen((_){
      if (_isPlayingRegularBell) { _isPlayingRegularBell = false; }
      if (_isPlayingStarterBell) { _isPlayingStarterBell = false; }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _player.dispose();
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
              'Round $_roundCounter of ${widget.roundCount}',
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
                SizedBox(
                  child: IconButton(
                    onPressed: _stopTimer,
                    icon: const Icon(Icons.motion_photos_pause_outlined, size: 60.0),
                    style: ButtonStyle(
                      iconColor: MaterialStateProperty.all(Colors.white),
                    )
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    onPressed: _startTimer,
                    icon: const Icon(Icons.play_circle_outlined, size: 60.0),
                    style: ButtonStyle(
                      iconColor: MaterialStateProperty.all(Colors.white),
                    )
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.replay, size: 60.0),
                    style: ButtonStyle(
                      iconColor: MaterialStateProperty.all(Colors.white),
                    )
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

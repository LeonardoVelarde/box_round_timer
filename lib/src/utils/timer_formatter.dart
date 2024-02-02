class TimerFormatter {
  static String formatFromSeconds(int seconds) {
    if (seconds < 0) return '00:00';
    return '${_getFormattedMinutesFromSeconds(seconds)}:${_getFormattedSecondsFromSeconds(seconds)}';
  }

  static formatFromMilliseconds(int milliseconds) {
    if (milliseconds < 0) return '00:00,00';
    return '${formatFromSeconds((milliseconds / 1000).floor())},${((milliseconds % 1000) / 10).floor().toString().padLeft(2, '0')}';
  }

  static String _getFormattedMinutesFromSeconds(int seconds) {
    if (seconds < 60) return '00';
    return (seconds / 60).floor().toString().padLeft(2, '0');
  }

  static String _getFormattedSecondsFromSeconds(int seconds) {
    return (seconds % 60).toString().padLeft(2, '0');
  }
}

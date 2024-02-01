class TimerFormatter {
  static String format(int seconds) {
    return '${_getFormattedMinutesFromSeconds(seconds)}:${_getFormattedSecondsFromSeconds(seconds)}';
  }

  static String _getFormattedMinutesFromSeconds(int seconds) {
    if (seconds < 60) return '00';
    return (seconds / 60).floor().toString().padLeft(2, '0');
  }

  static String _getFormattedSecondsFromSeconds(int seconds) {
    return (seconds % 60).toString().padLeft(2, '0');
  }
}

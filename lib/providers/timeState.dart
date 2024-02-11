import 'dart:async';
import 'package:flutter/foundation.dart';

class TimeClockedIn with ChangeNotifier {
  DateTime? _clockedInTime;
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  DateTime? get clockedInTime => _clockedInTime;
  Duration get elapsed => _elapsed;

  void clockIn() {
    _clockedInTime = DateTime.now();
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _updateTime();
    });
    notifyListeners();
  }

  void clockOut() {
    _clockedInTime = null;
    _timer?.cancel();
    _elapsed = Duration.zero;
    notifyListeners();
  }

  void _updateTime() {
    if (_clockedInTime != null) {
      final now = DateTime.now();
      _elapsed = now.difference(_clockedInTime!);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

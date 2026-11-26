import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class RetentionSnapshot {
  const RetentionSnapshot({required this.currentStreak, required this.completedToday});
  final int currentStreak;
  final bool completedToday;
}

class MindMatchRetention {
  MindMatchRetention._();
  static final instance = MindMatchRetention._();

  final ValueNotifier<RetentionSnapshot> snapshot = ValueNotifier(
    const RetentionSnapshot(currentStreak: 0, completedToday: false),
  );
  bool _loaded = false;
  Set<String> _completedDays = <String>{};

  String _dayKey(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Future<File> _dataFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/mindmatch-daily-history.json');
  }

  Future<void> load() async {
    if (_loaded) return;
    try {
      final file = await _dataFile();
      if (await file.exists()) {
        final decoded = jsonDecode(await file.readAsString());
        if (decoded is Map<String, dynamic> && decoded['completedDays'] is List) {
          _completedDays = (decoded['completedDays'] as List)
              .whereType<String>()
              .where((value) => RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value))
              .toSet();
        }
      }
    } catch (_) {
      // A damaged local history must never block playing the quiz.
      _completedDays = <String>{};
    }
    _loaded = true;
    _refresh(DateTime.now());
  }

  Future<void> recordDailyCompletion(DateTime date) async {
    await load();
    _completedDays.add(_dayKey(date));
    final ordered = _completedDays.toList()..sort();
    if (ordered.length > 400) {
      _completedDays = ordered.skip(ordered.length - 400).toSet();
    }
    try {
      final file = await _dataFile();
      final temporary = File('${file.path}.tmp');
      await temporary.writeAsString(
        jsonEncode(<String, Object>{'completedDays': _completedDays.toList()..sort()}),
        flush: true,
      );
      if (await file.exists()) await file.delete();
      await temporary.rename(file.path);
    } catch (_) {
      // Keep the in-memory streak for this session if storage is unavailable.
    }
    _refresh(date);
  }

  void _refresh(DateTime date) {
    snapshot.value = RetentionSnapshot(
      currentStreak: calculateCurrentStreak(_completedDays, date),
      completedToday: _completedDays.contains(_dayKey(date)),
    );
  }

  @visibleForTesting
  static int calculateCurrentStreak(Set<String> completedDays, DateTime today) {
    String key(DateTime value) =>
        '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
    var cursor = DateTime(today.year, today.month, today.day);
    if (!completedDays.contains(key(cursor))) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    var streak = 0;
    while (completedDays.contains(key(cursor))) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }
}

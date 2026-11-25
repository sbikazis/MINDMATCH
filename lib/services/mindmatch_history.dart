import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class QuizHistoryEntry {
  const QuizHistoryEntry({
    required this.id,
    required this.completedAt,
    required this.answers,
    required this.questionIds,
    this.friendAnswers,
  });

  final String id;
  final DateTime completedAt;
  final List<int> answers;
  final List<String> questionIds;
  final List<int>? friendAnswers;

  int? get matchPercent {
    final other = friendAnswers;
    if (other == null || other.isEmpty || other.length != answers.length) return null;
    final matches = List<int>.generate(answers.length, (index) => index)
        .where((index) => answers[index] == other[index])
        .length;
    return ((matches / answers.length) * 100).round();
  }

  Map<String, Object?> toJson() => {
        'id': id,
        'completedAt': completedAt.toUtc().toIso8601String(),
        'answers': answers,
        'questionIds': questionIds,
        if (friendAnswers != null) 'friendAnswers': friendAnswers,
      };

  static QuizHistoryEntry? fromJson(Object? value) {
    if (value is! Map<String, dynamic>) return null;
    final rawAnswers = value['answers'];
    final rawIds = value['questionIds'];
    final rawFriend = value['friendAnswers'];
    final rawDate = value['completedAt'];
    if (value['id'] is! String ||
        rawDate is! String ||
        rawAnswers is! List ||
        rawIds is! List ||
        rawAnswers.isEmpty ||
        rawAnswers.length != rawIds.length ||
        !rawAnswers.every((item) => item is int && item >= 0 && item <= 3) ||
        !rawIds.every((item) => item is String && item.isNotEmpty) ||
        (rawFriend != null &&
            (rawFriend is! List ||
                rawFriend.length != rawAnswers.length ||
                !rawFriend.every((item) => item is int && item >= 0 && item <= 3)))) {
      return null;
    }
    final date = DateTime.tryParse(rawDate);
    if (date == null) return null;
    return QuizHistoryEntry(
      id: value['id'] as String,
      completedAt: date.toLocal(),
      answers: List<int>.unmodifiable(rawAnswers.cast<int>()),
      questionIds: List<String>.unmodifiable(rawIds.cast<String>()),
      friendAnswers: rawFriend == null
          ? null
          : List<int>.unmodifiable((rawFriend as List).cast<int>()),
    );
  }
}

class MindMatchHistory {
  MindMatchHistory._();
  static final instance = MindMatchHistory._();

  final ValueNotifier<List<QuizHistoryEntry>> entries =
      ValueNotifier<List<QuizHistoryEntry>>(<QuizHistoryEntry>[]);
  bool _loaded = false;
  Future<void> _writeQueue = Future<void>.value();

  Future<File> _file() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/mindmatch-quiz-history.json');
  }

  Future<void> load() async {
    if (_loaded) return;
    try {
      final file = await _file();
      if (await file.exists()) {
        final decoded = jsonDecode(await file.readAsString());
        if (decoded is Map<String, dynamic> && decoded['entries'] is List) {
          entries.value = List<QuizHistoryEntry>.unmodifiable(
            (decoded['entries'] as List)
                .map(QuizHistoryEntry.fromJson)
                .whereType<QuizHistoryEntry>()
                .take(50),
          );
        }
      }
    } catch (_) {
      // A damaged history file must never prevent the user from playing.
      entries.value = <QuizHistoryEntry>[];
    }
    _loaded = true;
  }

  Future<void> record({
    required List<int> answers,
    required List<String> questionIds,
    List<int>? friendAnswers,
  }) async {
    if (answers.isEmpty ||
        answers.length != questionIds.length ||
        (friendAnswers != null && friendAnswers.length != answers.length)) {
      return;
    }
    await load();
    final now = DateTime.now();
    final entry = QuizHistoryEntry(
      id: '${now.microsecondsSinceEpoch}',
      completedAt: now,
      answers: List<int>.unmodifiable(answers),
      questionIds: List<String>.unmodifiable(questionIds),
      friendAnswers: friendAnswers == null
          ? null
          : List<int>.unmodifiable(friendAnswers),
    );
    entries.value = List<QuizHistoryEntry>.unmodifiable(
      <QuizHistoryEntry>[entry, ...entries.value].take(50),
    );
    _writeQueue = _writeQueue.then((_) => _persist());
    await _writeQueue;
  }

  Future<void> _persist() async {
    try {
      final file = await _file();
      final temporary = File('${file.path}.tmp');
      await temporary.writeAsString(
        jsonEncode(<String, Object>{
          'version': 1,
          'entries': entries.value.map((entry) => entry.toJson()).toList(),
        }),
        flush: true,
      );
      if (await file.exists()) await file.delete();
      await temporary.rename(file.path);
    } catch (_) {
      // History is a convenience; a storage failure must not block results.
    }
  }
}

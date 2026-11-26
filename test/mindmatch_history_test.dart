import 'package:flutter_test/flutter_test.dart';
import 'package:mindmatch/features/history/data/mindmatch_history.dart';

void main() {
  test('history entry preserves answers and question identifiers', () {
    final entry = QuizHistoryEntry(
      id: 'test-1',
      completedAt: DateTime.utc(2026, 11, 25, 12),
      answers: const [0, 2, 1],
      questionIds: const ['one', 'two', 'three'],
      friendAnswers: const [0, 1, 1],
    );

    final restored = QuizHistoryEntry.fromJson(entry.toJson());

    expect(restored, isNotNull);
    expect(restored!.answers, [0, 2, 1]);
    expect(restored.questionIds, ['one', 'two', 'three']);
    expect(restored.friendAnswers, [0, 1, 1]);
    expect(restored.matchPercent, 67);
  });

  test('solo history entry has no match score', () {
    final entry = QuizHistoryEntry(
      id: 'solo',
      completedAt: DateTime(2026, 11, 25),
      answers: const [1, 2],
      questionIds: const ['one', 'two'],
    );

    expect(entry.matchPercent, isNull);
    expect(QuizHistoryEntry.fromJson(entry.toJson())!.friendAnswers, isNull);
  });

  test('malformed history records are ignored safely', () {
    expect(QuizHistoryEntry.fromJson({'id': 'bad'}), isNull);
    expect(
      QuizHistoryEntry.fromJson({
        'id': 'bad',
        'completedAt': '2026-11-25T12:00:00Z',
        'answers': [9],
        'questionIds': ['one'],
      }),
      isNull,
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mindmatch/models/quiz_catalog.dart';
import 'package:mindmatch/models/quiz_question.dart';

void main() {
  test('question library contains 56 uniquely identified questions', () {
    expect(mindMatchQuestions, hasLength(56));
    expect(mindMatchQuestions.map((question) => question.id).toSet(), hasLength(28));
  });

  test('each themed pack resolves to seven valid questions', () {
    expect(quizPacks, hasLength(8));
    for (final pack in quizPacks) {
      expect(pack.questions, hasLength(7));
      expect(pack.questions.every((question) => mindMatchQuestions.contains(question)), isTrue);
    }
  });

  test('daily challenge is stable for a date and contains fourteen unique questions', () {
    final date = DateTime(2026, 11, 24);
    final first = dailyQuestions(date);
    final second = dailyQuestions(date);
    expect(first, hasLength(14));
    expect(first.map((question) => question.id).toList(), second.map((question) => question.id).toList());
    expect(first.map((question) => question.id).toSet(), hasLength(14));
  });

  test('daily challenge rotates across consecutive dates', () {
    final today = dailyQuestions(DateTime(2026, 11, 24)).map((question) => question.id).toSet();
    final tomorrow = dailyQuestions(DateTime(2026, 11, 25)).map((question) => question.id).toSet();
    expect(today, isNot(equals(tomorrow)));
  });
}

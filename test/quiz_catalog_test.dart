import 'package:flutter_test/flutter_test.dart';
import 'package:mindmatch/models/quiz_catalog.dart';
import 'package:mindmatch/models/quiz_question.dart';

void main() {
  test('question library contains 56 uniquely identified questions', () {
    expect(mindMatchQuestions, hasLength(56));
    expect(mindMatchQuestions.map((question) => question.id).toSet(), hasLength(56));
  });

  test('each themed pack resolves to seven valid questions', () {
    expect(quizPacks, hasLength(8));
    for (final pack in quizPacks) {
      expect(pack.questions, hasLength(7));
      expect(pack.questions.every((question) => mindMatchQuestions.contains(question)), isTrue);
    }
  });

  test('every question has four choices and Arabic/French translations', () {
    for (final question in mindMatchQuestions) {
      expect(question.options, hasLength(4), reason: question.id);
      expect(localizedQuestion(question, 'ar').prompt, isNot(question.prompt), reason: 'Arabic: ${question.id}');
      expect(localizedQuestion(question, 'fr').prompt, isNot(question.prompt), reason: 'French: ${question.id}');
    }
  });

  test('all questions are discoverable through the themed packs', () {
    final packedIds = quizPacks.expand((pack) => pack.questionIds).toSet();
    expect(packedIds, hasLength(56));
    expect(packedIds, containsAll(mindMatchQuestions.map((question) => question.id)));
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

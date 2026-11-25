import 'package:flutter_test/flutter_test.dart';
import 'package:mindmatch/services/mindmatch_retention.dart';

void main() {
  test('daily streak counts consecutive completed calendar days', () {
    final days = <String>{'2026-11-22', '2026-11-23', '2026-11-24'};
    expect(
      MindMatchRetention.calculateCurrentStreak(days, DateTime(2026, 11, 24)),
      3,
    );
  });

  test('streak remains visible during the current day before completion', () {
    final days = <String>{'2026-11-22', '2026-11-23'};
    expect(
      MindMatchRetention.calculateCurrentStreak(days, DateTime(2026, 11, 24)),
      2,
    );
  });

  test('a missed day breaks the streak', () {
    final days = <String>{'2026-11-20', '2026-11-22', '2026-11-23'};
    expect(
      MindMatchRetention.calculateCurrentStreak(days, DateTime(2026, 11, 24)),
      2,
    );
  });

  test('no completed daily challenge means no streak', () {
    expect(
      MindMatchRetention.calculateCurrentStreak(<String>{}, DateTime(2026, 11, 24)),
      0,
    );
  });
}

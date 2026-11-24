import 'package:flutter_test/flutter_test.dart';
import 'package:mindmatch/services/challenge_codec.dart';

void main() {
  group('ChallengeCodec', () {
    test('round trips a fourteen-answer challenge', () {
      const answers = [0, 1, 2, 3, 0, 2, 1, 3, 2, 1, 0, 3, 2, 1];
      final code = ChallengeCodec.encode(answers);
      final decoded = ChallengeCodec.decode(code);
      expect(decoded.answers, answers);
    });

    test('rejects a code with the wrong prefix', () {
      expect(() => ChallengeCodec.decode('NOT-A-CODE'), throwsA(isA<FormatException>()));
    });

    test('rejects an incomplete answer set', () {
      final code = ChallengeCodec.encode([0, 1, 2]);
      expect(() => ChallengeCodec.decode(code), throwsA(isA<FormatException>()));
    });

    test('rejects an answer outside the supported option range', () {
      final code = ChallengeCodec.encode([0, 1, 2, 3, 0, 2, 1, 3, 2, 1, 0, 3, 2, 4]);
      expect(() => ChallengeCodec.decode(code), throwsA(isA<FormatException>()));
    });
  });

  group('calculateMatchPercent', () {
    test('returns 100 for identical answers', () {
      expect(calculateMatchPercent([0, 1, 2], [0, 1, 2]), 100);
    });

    test('returns the rounded percentage for partial matches', () {
      expect(calculateMatchPercent([0, 1, 2, 3], [0, 1, 0, 0]), 50);
    });

    test('rejects different answer lengths', () {
      expect(() => calculateMatchPercent([0], [0, 1]), throwsArgumentError);
    });
  });
}

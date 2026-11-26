import 'dart:convert';

class ChallengeData {
  const ChallengeData({required this.answers, this.questionIds = const []});

  final List<int> answers;
  final List<String> questionIds;
}

class ChallengeCodec {
  static const _prefix = 'MM1-';

  /// Base64URL is transport encoding, NOT encryption. Never put private data in it.
  static String encode(List<int> answers, {List<String>? questionIds}) {
    if (questionIds != null && questionIds.length != answers.length) {
      throw ArgumentError('Question IDs and answers must have the same length.');
    }
    final payload = jsonEncode({'v': 1, 'a': answers, if (questionIds != null) 'q': questionIds});
    return '$_prefix${base64Url.encode(utf8.encode(payload)).replaceAll('=', '')}';
  }

  static ChallengeData decode(String raw, {int? expectedQuestions}) {
    final code = raw.trim();
    if (!code.startsWith(_prefix)) {
      throw const FormatException('This does not look like a MINDMATCH code.');
    }

    try {
      final encoded = code.substring(_prefix.length);
      final normalized = base64Url.normalize(encoded);
      final decoded = jsonDecode(utf8.decode(base64Url.decode(normalized)));
      if (decoded is! Map<String, dynamic> || decoded['v'] != 1) {
        throw const FormatException('This challenge version is not supported.');
      }
      final rawAnswers = decoded['a'];
      if (rawAnswers is! List || !const [7, 14, 28].contains(rawAnswers.length) || (expectedQuestions != null && rawAnswers.length != expectedQuestions)) {
        throw const FormatException('This challenge has an invalid answer set.');
      }
      final answers = rawAnswers.map((value) {
        if (value is! int || value < 0 || value > 3) {
          throw const FormatException('This challenge contains an invalid answer.');
        }
        return value;
      }).toList(growable: false);
      final rawIds = decoded['q'];
      final questionIds = rawIds == null ? <String>[] : rawIds is List && rawIds.length == answers.length && rawIds.every((id) => id is String && id.isNotEmpty) ? rawIds.cast<String>() : throw const FormatException('This challenge contains invalid question IDs.');
      return ChallengeData(answers: answers, questionIds: List<String>.unmodifiable(questionIds));
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('The challenge code is damaged or incomplete.');
    }
  }
}

int calculateMatchPercent(List<int> first, List<int> second) {
  if (first.isEmpty || first.length != second.length) {
    throw ArgumentError('Answer sets must have the same non-zero length.');
  }
  final matches = List<int>.generate(first.length, (index) => index)
      .where((index) => first[index] == second[index])
      .length;
  return ((matches / first.length) * 100).round();
}

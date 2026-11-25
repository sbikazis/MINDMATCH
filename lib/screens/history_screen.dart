import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../main.dart';
import '../models/quiz_question.dart';
import '../services/challenge_codec.dart';
import '../services/mindmatch_history.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.t('historyTitle'),
          style: const TextStyle(fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w900),
        ),
      ),
      body: ValueListenableBuilder<List<QuizHistoryEntry>>(
        valueListenable: MindMatchHistory.instance.entries,
        builder: (context, entries, _) {
          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_stories_rounded, color: mindLilac, size: 42),
                    const SizedBox(height: 16),
                    Text(strings.t('historyEmpty'), textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(height: 8),
                    Text(strings.t('historySubtitle'), textAlign: TextAlign.center,
                        style: const TextStyle(color: mindMuted, height: 1.5, fontSize: 11)),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final entry = entries[index];
              final score = entry.matchPercent;
              final date = entry.completedAt;
              final dateLabel = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
              final timeLabel = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
              return Material(
                color: mindSurface,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    final questions = <QuizQuestion>[];
                    for (final id in entry.questionIds) {
                      final matches = mindMatchQuestions.where((question) => question.id == id);
                      if (matches.isEmpty) return;
                      questions.add(matches.first);
                    }
                    final friendAnswers = entry.friendAnswers;
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (_) => ResultScreen(
                        answers: entry.answers,
                        quizQuestions: questions,
                        incomingChallenge: friendAnswers == null
                            ? null
                            : ChallengeData(answers: friendAnswers, questionIds: entry.questionIds),
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Container(
                          width: 43,
                          height: 43,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: mindSurfaceRaised,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Icon(
                            score == null ? Icons.outgoing_mail_rounded : Icons.compare_arrows_rounded,
                            color: mindLilac,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                score == null ? strings.t('historySolo') : strings.t('historyMatched'),
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${entry.answers.length} ${strings.t('questionsShort')}  ·  $dateLabel  ·  $timeLabel',
                                style: const TextStyle(color: mindMuted, fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                        if (score != null)
                          Text('$score%', style: const TextStyle(color: mindGold, fontSize: 18, fontWeight: FontWeight.w900))
                        else
                          const Icon(Icons.chevron_right_rounded, color: mindMuted),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

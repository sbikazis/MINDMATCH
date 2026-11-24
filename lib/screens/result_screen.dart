import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/quiz_question.dart';
import '../services/challenge_codec.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.answers, this.incomingChallenge});
  final List<int> answers;
  final ChallengeData? incomingChallenge;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _copied = false;
  String get _challengeCode => ChallengeCodec.encode(widget.answers);

  Future<void> _copyChallenge() async {
    await Clipboard.setData(ClipboardData(text: _challengeCode));
    if (!mounted) return;
    setState(() => _copied = true);
  }

  Future<void> _copyResult() async {
    final score = ChallengeCodec.calculateMatchPercent(widget.answers, widget.incomingChallenge!.answers);
    final text = 'We got $score% MINDMATCH! Can your mind match mine? Try MINDMATCH.';
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Result copied. Share it with your friend!')));
  }

  @override
  Widget build(BuildContext context) {
    final other = widget.incomingChallenge;
    final score = other == null ? null : ChallengeCodec.calculateMatchPercent(widget.answers, other.answers);
    final matches = other == null ? 0 : List<int>.generate(widget.answers.length, (i) => i).where((i) => widget.answers[i] == other.answers[i]).length;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: const Text('YOUR MIND REPORT', style: TextStyle(fontSize: 12, letterSpacing: 1.6, fontWeight: FontWeight.w800))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 26),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF39265F), Color(0xFF191328), Color(0xFF171326)]),
                border: Border.all(color: const Color(0xFF70559F)),
              ),
              child: Column(children: [
                const Icon(Icons.auto_awesome_rounded, color: Color(0xFFFFD27D), size: 30),
                const SizedBox(height: 14),
                Text(score == null ? 'YOUR ANSWERS ARE IN' : '$score%', style: const TextStyle(fontSize: 58, fontWeight: FontWeight.w900, letterSpacing: -2)),
                Text(score == null ? 'READY FOR A MIND MATCH?' : 'MIND MATCH SCORE', style: const TextStyle(color: Color(0xFFD7C9FF), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.8)),
                const SizedBox(height: 16),
                Text(
                  score == null
                      ? 'Your challenge code is ready. Send it to a friend and see how closely your answers align.'
                      : '$matches out of ${widget.answers.length} answers matched. Every unexpected similarity counts!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFFC5BDD3), height: 1.5),
                ),
              ]),
            ),
            const SizedBox(height: 24),
            if (score == null) ...[
              const Text('CHALLENGE CODE', style: TextStyle(fontSize: 11, letterSpacing: 1.5, color: Color(0xFFB69CFF), fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              SelectableText(_challengeCode, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _copyChallenge,
                icon: Icon(_copied ? Icons.check_rounded : Icons.copy_rounded),
                label: Text(_copied ? 'COPIED — SEND TO YOUR FRIEND' : 'COPY CHALLENGE CODE'),
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFF9A78F0), minimumSize: const Size.fromHeight(54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your friend opens MINDMATCH, pastes this code on the home screen, and answers the same questions. This first version uses a shareable code rather than live accounts.',
                style: TextStyle(color: Color(0xFF91899F), fontSize: 12, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              const Text('QUESTION-BY-QUESTION', style: TextStyle(fontSize: 11, letterSpacing: 1.5, color: Color(0xFFB69CFF), fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              ...List.generate(widget.answers.length, (index) {
                final matched = widget.answers[index] == other.answers[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: const Color(0xFF171326), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFF302744))),
                  child: Row(children: [
                    Icon(matched ? Icons.check_circle_rounded : Icons.bolt_rounded, color: matched ? const Color(0xFF76D9AE) : const Color(0xFFFFC879)),
                    const SizedBox(width: 12),
                    Expanded(child: Text('Q${index + 1} · ${mindMatchQuestions[index].category}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                    Text(matched ? 'MATCH' : 'DIFFERENT', style: TextStyle(color: matched ? const Color(0xFF76D9AE) : const Color(0xFFFFC879), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: .8)),
                  ]),
                );
              }),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _copyResult,
                icon: const Icon(Icons.share_rounded),
                label: const Text('COPY MY RESULT'),
                style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFD7C9FF), side: const BorderSide(color: Color(0xFF66518D)), minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              ),
            ],
            const SizedBox(height: 18),
            TextButton(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text('BACK TO HOME', style: TextStyle(color: Color(0xFFB9B1C9), letterSpacing: 1, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}

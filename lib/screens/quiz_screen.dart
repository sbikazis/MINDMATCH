import 'package:flutter/material.dart';

import '../models/quiz_question.dart';
import '../services/challenge_codec.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, this.incomingChallenge});
  final ChallengeData? incomingChallenge;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<int> _answers = [];
  int _current = 0;

  void _select(int answer) {
    setState(() {
      if (_answers.length > _current) {
        _answers[_current] = answer;
      } else {
        _answers.add(answer);
      }
    });
  }

  void _next() {
    if (_answers.length <= _current) return;
    if (_current < mindMatchQuestions.length - 1) {
      setState(() => _current++);
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ResultScreen(
          answers: List<int>.unmodifiable(_answers),
          incomingChallenge: widget.incomingChallenge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = mindMatchQuestions[_current];
    final selected = _answers.length > _current ? _answers[_current] : -1;
    final progress = (_current + 1) / mindMatchQuestions.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.of(context).pop()),
        title: const Text('THE MIND TEST', style: TextStyle(fontSize: 12, letterSpacing: 1.7, fontWeight: FontWeight.w800)),
        actions: [Padding(padding: const EdgeInsets.only(right: 20), child: Center(child: Text('${_current + 1}/${mindMatchQuestions.length}', style: const TextStyle(color: Color(0xFFB9B1C9), fontWeight: FontWeight.w700))))],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(value: progress, minHeight: 6, backgroundColor: const Color(0xFF302744), color: const Color(0xFFB69CFF)),
              ),
              const SizedBox(height: 34),
              Text(question.category, style: const TextStyle(color: Color(0xFFB69CFF), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 13),
              Text(question.prompt, style: const TextStyle(fontSize: 27, height: 1.2, fontWeight: FontWeight.w800)),
              const SizedBox(height: 28),
              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 11),
                  itemBuilder: (context, index) {
                    final isSelected = selected == index;
                    return InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _select(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF332653) : const Color(0xFF171326),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: isSelected ? const Color(0xFFB69CFF) : const Color(0xFF302744), width: isSelected ? 1.6 : 1),
                        ),
                        child: Row(children: [
                          Container(
                            width: 30, height: 30, alignment: Alignment.center,
                            decoration: BoxDecoration(color: isSelected ? const Color(0xFF9A78F0) : const Color(0xFF292239), borderRadius: BorderRadius.circular(10)),
                            child: Text(String.fromCharCode(65 + index), style: const TextStyle(fontWeight: FontWeight.w800)),
                          ),
                          const SizedBox(width: 13),
                          Expanded(child: Text(question.options[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                          if (isSelected) const Icon(Icons.check_circle_rounded, color: Color(0xFFB69CFF)),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              FilledButton(
                onPressed: selected < 0 ? null : _next,
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFF9A78F0), minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17))),
                child: Text(_current == mindMatchQuestions.length - 1 ? 'REVEAL MY RESULT' : 'NEXT QUESTION', style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

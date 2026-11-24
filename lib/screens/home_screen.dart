import 'package:flutter/material.dart';

import '../services/challenge_codec.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _codeController = TextEditingController();
  String? _codeError;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _startQuiz({ChallengeData? challenge}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(incomingChallenge: challenge),
      ),
    );
  }

  void _joinChallenge() {
    try {
      final challenge = ChallengeCodec.decode(_codeController.text);
      setState(() => _codeError = null);
      _startQuiz(challenge: challenge);
    } on FormatException catch (error) {
      setState(() => _codeError = error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 32),
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB69CFF), Color(0xFF7652D8)],
                    ),
                  ),
                  child: const Icon(Icons.psychology_alt_rounded, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text('MINDMATCH', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, letterSpacing: 2.2)),
                const Spacer(),
                const Icon(Icons.bolt_rounded, color: Color(0xFFFFD27D)),
                const Text(' 7 QUESTIONS', style: TextStyle(fontSize: 10, letterSpacing: 1.1, color: Color(0xFFB9B1C9))),
              ],
            ),
            const SizedBox(height: 42),
            Center(
              child: Container(
                width: 174,
                height: 174,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [const Color(0xFF7452C8).withOpacity(.45), const Color(0xFF171326).withOpacity(.05)],
                  ),
                  border: Border.all(color: const Color(0xFF6F55A4).withOpacity(.45)),
                ),
                child: const Icon(Icons.psychology_alt_rounded, size: 104, color: Color(0xFFC5B1FF)),
              ),
            ),
            const SizedBox(height: 30),
            const Text('SAME BRAIN?\nLET’S FIND OUT.', textAlign: TextAlign.center, style: TextStyle(fontSize: 34, height: 1.08, fontWeight: FontWeight.w900, letterSpacing: -.8)),
            const SizedBox(height: 14),
            const Text(
              'Answer 7 unexpected questions. Challenge a friend. Discover how often your minds meet.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFB9B1C9), fontSize: 14, height: 1.55),
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: () => _startQuiz(),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF9A78F0),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(58),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text('START A NEW MATCH', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1)),
            ),
            const SizedBox(height: 22),
            const Row(children: [
              Expanded(child: Divider(color: Color(0xFF302744))),
              Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('OR JOIN A FRIEND', style: TextStyle(fontSize: 10, letterSpacing: 1.4, color: Color(0xFF91899F), fontWeight: FontWeight.w700))),
              Expanded(child: Divider(color: Color(0xFF302744))),
            ]),
            const SizedBox(height: 18),
            TextField(
              controller: _codeController,
              textCapitalization: TextCapitalization.characters,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Paste a challenge code (MM1-...)',
                prefixIcon: const Icon(Icons.key_rounded, color: Color(0xFFB69CFF)),
                errorText: _codeError,
              ),
              onChanged: (_) {
                if (_codeError != null) setState(() => _codeError = null);
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _joinChallenge,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFD7C9FF),
                side: const BorderSide(color: Color(0xFF66518D)),
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('JOIN CHALLENGE'),
            ),
            const SizedBox(height: 22),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.lock_outline_rounded, size: 14, color: Color(0xFF91899F)),
              SizedBox(width: 7),
              Text('No account. No profile. Just a fun match.', style: TextStyle(fontSize: 11, color: Color(0xFF91899F))),
            ]),
          ],
        ),
      ),
    );
  }
}

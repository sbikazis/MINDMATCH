import 'package:flutter/material.dart';
import '../main.dart';
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
  void dispose() { _codeController.dispose(); super.dispose(); }

  void _startQuiz({ChallengeData? challenge}) {
    Navigator.of(context).push(PageRouteBuilder<void>(
      pageBuilder: (_, animation, secondaryAnimation) => QuizScreen(incomingChallenge: challenge),
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(opacity: curve, child: SlideTransition(position: Tween<Offset>(begin: const Offset(0, .035), end: Offset.zero).animate(curve), child: child));
      },
    ));
  }

  void _joinChallenge() {
    try {
      final challenge = ChallengeCodec.decode(_codeController.text);
      setState(() => _codeError = null);
      _startQuiz(challenge: challenge);
    } on FormatException catch (error) { setState(() => _codeError = error.message); }
  }

  Widget _brandMark() => Container(
    width: 46, height: 46,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFE0D4FF), Color(0xFF9B7BFF), Color(0xFF6542C2)]),
      boxShadow: [BoxShadow(color: mindPurple.withOpacity(.32), blurRadius: 24, offset: const Offset(0, 8))],
    ),
    child: const Icon(Icons.bubble_chart_rounded, color: Color(0xFF130D22), size: 28),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(top: -130, right: -100, child: Container(width: 320, height: 320, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [mindPurple.withOpacity(.22), mindBackground.withOpacity(0)])))),
        Positioned(bottom: 70, left: -160, child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [const Color(0xFF5B3D9D).withOpacity(.18), mindBackground.withOpacity(0)])))),
        SafeArea(child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 30),
          children: [
            Row(children: [
              _brandMark(), const SizedBox(width: 12),
              const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('MINDMATCH', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2.1)),
                SizedBox(height: 3),
                Text('THE SOCIAL MIND GAME', style: TextStyle(fontSize: 9, color: mindMuted, letterSpacing: 1.8, fontWeight: FontWeight.w700)),
              ]),
              const Spacer(),
              Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8), decoration: BoxDecoration(color: mindSurface, borderRadius: BorderRadius.circular(30), border: Border.all(color: const Color(0xFF352B4A))), child: const Row(children: [
                Icon(Icons.bolt_rounded, size: 15, color: mindGold), SizedBox(width: 5),
                Text('7 QUICK Qs', style: TextStyle(fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w800, color: mindLilac)),
              ])),
            ]),
            const SizedBox(height: 38),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF2C2148), Color(0xFF171326), Color(0xFF11101B)]),
                border: Border.all(color: const Color(0xFF574477).withOpacity(.8)),
                boxShadow: [BoxShadow(color: mindPurple.withOpacity(.09), blurRadius: 34, offset: const Offset(0, 16))],
              ),
              child: Column(children: [
                SizedBox(width: 190, height: 172, child: DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [mindPurple.withOpacity(.28), mindPurple.withOpacity(.02), Colors.transparent])),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(width: 136, height: 136, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: mindLilac.withOpacity(.18), width: 1.2))),
                    Container(width: 104, height: 104, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: mindLilac.withOpacity(.25), width: 1.2))),
                    Container(width: 76, height: 76, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFE0D4FF), Color(0xFF9674F3), Color(0xFF5636A5)]), boxShadow: [BoxShadow(color: mindPurple.withOpacity(.4), blurRadius: 32)]), child: const Icon(Icons.psychology_alt_rounded, size: 43, color: Color(0xFF170F29))),
                    const Positioned(top: 17, right: 28, child: Icon(Icons.auto_awesome, color: mindGold, size: 18)),
                    const Positioned(bottom: 22, left: 24, child: Icon(Icons.circle, color: Color(0xFF8F75D5), size: 8)),
                  ]),
                )),
                const SizedBox(height: 10),
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7), decoration: BoxDecoration(color: const Color(0xFF40305F).withOpacity(.65), borderRadius: BorderRadius.circular(30)), child: const Text('✦  ONE GAME. TWO MINDS.  ✦', style: TextStyle(color: mindLilac, fontSize: 9, letterSpacing: 1.4, fontWeight: FontWeight.w900))),
                const SizedBox(height: 19),
                const Text('SAME BRAIN?\nLET’S FIND OUT.', textAlign: TextAlign.center, style: TextStyle(fontSize: 34, height: 1.06, fontWeight: FontWeight.w900, letterSpacing: -1.2)),
                const SizedBox(height: 13),
                const Text('Your choices say more than you think. Answer unexpected questions, challenge your people, and see where your minds meet.', textAlign: TextAlign.center, style: TextStyle(color: mindMuted, fontSize: 13, height: 1.6)),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, height: 58, child: FilledButton(
                  onPressed: () => _startQuiz(),
                  style: FilledButton.styleFrom(backgroundColor: mindPurple, foregroundColor: const Color(0xFF130D22), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.play_arrow_rounded, size: 23), SizedBox(width: 8),
                    Text('START YOUR MINDMATCH', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: .8, fontSize: 12)),
                    SizedBox(width: 7), Icon(Icons.arrow_forward_rounded, size: 16),
                  ]),
                )),
              ]),
            ),
            const SizedBox(height: 25),
            Row(children: [
              const Expanded(child: Divider(color: Color(0xFF352B4A))),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('ALREADY HAVE A CHALLENGE?', style: TextStyle(fontSize: 9, letterSpacing: 1.2, color: mindMuted, fontWeight: FontWeight.w800))),
              const Expanded(child: Divider(color: Color(0xFF352B4A))),
            ]),
            const SizedBox(height: 17),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(color: mindSurface.withOpacity(.92), borderRadius: BorderRadius.circular(23), border: Border.all(color: const Color(0xFF352B4A))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [Icon(Icons.vpn_key_rounded, color: mindLilac, size: 17), SizedBox(width: 8), Text('JOIN A FRIEND', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.1, fontSize: 11))]),
                const SizedBox(height: 7),
                const Text('Paste their code and take the same test.', style: TextStyle(color: mindMuted, fontSize: 12)),
                const SizedBox(height: 14),
                TextField(
                  controller: _codeController, textCapitalization: TextCapitalization.characters, autocorrect: false,
                  decoration: InputDecoration(hintText: 'MM1-XXXX-XXXX', prefixIcon: const Icon(Icons.qr_code_2_rounded, color: mindLilac), errorText: _codeError),
                  onChanged: (_) { if (_codeError != null) setState(() => _codeError = null); },
                ),
                const SizedBox(height: 11),
                SizedBox(width: double.infinity, height: 49, child: OutlinedButton(
                  onPressed: _joinChallenge,
                  style: OutlinedButton.styleFrom(foregroundColor: mindLilac, side: const BorderSide(color: Color(0xFF66518D)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  child: const Text('ENTER THE MATCH', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
                )),
              ]),
            ),
            const SizedBox(height: 19),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.shield_moon_outlined, size: 14, color: mindMuted), SizedBox(width: 7),
              Text('NO ACCOUNT  ·  NO PRESSURE  ·  JUST VIBES', style: TextStyle(fontSize: 9, letterSpacing: .8, color: mindMuted, fontWeight: FontWeight.w700)),
            ]),
          ],
        )),
      ]),
    );
  }
}
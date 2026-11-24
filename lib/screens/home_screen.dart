import 'package:flutter/material.dart';
import '../l10n/app_strings.dart';
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
    try { final challenge = ChallengeCodec.decode(_codeController.text); setState(() => _codeError = null); _startQuiz(challenge: challenge); }
    on FormatException catch (error) { setState(() => _codeError = error.message); }
  }
  Widget _brandMark() => Container(
    width: 46, height: 46,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFE0D4FF), Color(0xFF9B7BFF), Color(0xFF6542C2)]), boxShadow: [BoxShadow(color: mindPurple.withOpacity(.32), blurRadius: 24, offset: const Offset(0, 8))]),
    child: const Icon(Icons.bubble_chart_rounded, color: Color(0xFF130D22), size: 28),
  );
  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final language = Localizations.localeOf(context).languageCode;
    return Scaffold(body: Stack(children: [
      Positioned(top: -130, right: -100, child: Container(width: 320, height: 320, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [mindPurple.withOpacity(.22), mindBackground.withOpacity(0)])))),
      Positioned(bottom: 70, left: -160, child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [const Color(0xFF5B3D9D).withOpacity(.18), mindBackground.withOpacity(0)])))),
      SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(22, 16, 22, 30), children: [
        Row(children: [
          _brandMark(), const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('MINDMATCH', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2.1)),
            const SizedBox(height: 3),
            Text(s.t('brandTag'), style: const TextStyle(fontSize: 9, color: mindMuted, letterSpacing: 1.1, fontWeight: FontWeight.w700)),
          ])),
          Container(height: 39, padding: const EdgeInsets.symmetric(horizontal: 8), decoration: BoxDecoration(color: mindSurface, borderRadius: BorderRadius.circular(13), border: Border.all(color: const Color(0xFF493B60))),
            child: DropdownButtonHideUnderline(child: DropdownButton<String>(
              value: language, dropdownColor: mindSurfaceRaised, iconEnabledColor: mindLilac,
              items: const [DropdownMenuItem(value:'en',child:Text('EN')),DropdownMenuItem(value:'ar',child:Text('عربي')),DropdownMenuItem(value:'fr',child:Text('FR'))],
              onChanged: (value) { if(value!=null) mindLocale.value=Locale(value); },
            )),
          ),
        ]),
        const SizedBox(height: 34),
        Container(padding: const EdgeInsets.fromLTRB(18, 22, 18, 24), decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF2C2148), Color(0xFF171326), Color(0xFF11101B)]), border: Border.all(color: const Color(0xFF574477).withOpacity(.8)), boxShadow: [BoxShadow(color: mindPurple.withOpacity(.09), blurRadius: 34, offset: const Offset(0, 16))]),
          child: Column(children: [
            SizedBox(width: 190, height: 172, child: DecoratedBox(decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [mindPurple.withOpacity(.28), mindPurple.withOpacity(.02), Colors.transparent])), child: Stack(alignment: Alignment.center, children: [
              Container(width: 136,height:136,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:mindLilac.withOpacity(.18),width:1.2))),
              Container(width:104,height:104,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:mindLilac.withOpacity(.25),width:1.2))),
              Container(width:76,height:76,decoration:BoxDecoration(shape:BoxShape.circle,gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFFE0D4FF),Color(0xFF9674F3),Color(0xFF5636A5)]),boxShadow:[BoxShadow(color:mindPurple.withOpacity(.4),blurRadius:32)]),child:const Icon(Icons.psychology_alt_rounded,size:43,color:Color(0xFF170F29))),
              const Positioned(top:17,right:28,child:Icon(Icons.auto_awesome,color:mindGold,size:18)),
              const Positioned(bottom:22,left:24,child:Icon(Icons.circle,color:Color(0xFF8F75D5),size:8)),
            ]))),
            const SizedBox(height:10),
            Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:7),decoration:BoxDecoration(color:const Color(0xFF40305F).withOpacity(.65),borderRadius:BorderRadius.circular(30)),child:Text(s.t('eyebrow'),style:const TextStyle(color:mindLilac,fontSize:9,letterSpacing:1.1,fontWeight:FontWeight.w900))),
            const SizedBox(height:19),
            Text(s.t('heroTitle'),textAlign:TextAlign.center,style:const TextStyle(fontSize:31,height:1.12,fontWeight:FontWeight.w900,letterSpacing:-.7)),
            const SizedBox(height:13),
            Text(s.t('heroBody'),textAlign:TextAlign.center,style:const TextStyle(color:mindMuted,fontSize:13,height:1.6)),
            const SizedBox(height:24),
            SizedBox(width:double.infinity,height:58,child:FilledButton(onPressed:()=>_startQuiz(),style:FilledButton.styleFrom(backgroundColor:mindPurple,foregroundColor:const Color(0xFF130D22),elevation:0,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18))),child:Text(s.t('start'),style:const TextStyle(fontWeight:FontWeight.w900,letterSpacing:.5,fontSize:12)))),
          ]),
        ),
        const SizedBox(height:25),
        Row(children:[const Expanded(child:Divider(color:Color(0xFF352B4A))),Padding(padding:const EdgeInsets.symmetric(horizontal:12),child:Text(s.t('already'),style:const TextStyle(fontSize:9,letterSpacing:.7,color:mindMuted,fontWeight:FontWeight.w800))),const Expanded(child:Divider(color:Color(0xFF352B4A)))]),
        const SizedBox(height:17),
        Container(padding:const EdgeInsets.all(17),decoration:BoxDecoration(color:mindSurface.withOpacity(.92),borderRadius:BorderRadius.circular(23),border:Border.all(color:const Color(0xFF352B4A))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Row(children:[const Icon(Icons.vpn_key_rounded,color:mindLilac,size:17),const SizedBox(width:8),Text(s.t('join'),style:const TextStyle(fontWeight:FontWeight.w900,letterSpacing:1,fontSize:11))]),
          const SizedBox(height:7),Text(s.t('paste'),style:const TextStyle(color:mindMuted,fontSize:12)),
          const SizedBox(height:14),
          TextField(controller:_codeController,textCapitalization:TextCapitalization.characters,autocorrect:false,decoration:InputDecoration(hintText:s.t('codeHint'),prefixIcon:const Icon(Icons.qr_code_2_rounded,color:mindLilac),errorText:_codeError),onChanged:(_){if(_codeError!=null)setState(()=>_codeError=null);}),
          const SizedBox(height:11),
          SizedBox(width:double.infinity,height:49,child:OutlinedButton(onPressed:_joinChallenge,style:OutlinedButton.styleFrom(foregroundColor:mindLilac,side:const BorderSide(color:Color(0xFF66518D)),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15))),child:Text(s.t('enter'),style:const TextStyle(fontSize:11,fontWeight:FontWeight.w900,letterSpacing:.8)))),
        ])),
        const SizedBox(height:19),
        Center(child:Text(s.t('privacy'),style:const TextStyle(fontSize:9,letterSpacing:.5,color:mindMuted,fontWeight:FontWeight.w700))),
      ])),
    ]));
  }
}

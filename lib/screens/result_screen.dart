import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../l10n/app_strings.dart';
import '../main.dart';
import '../models/quiz_question.dart';
import '../services/challenge_codec.dart';

class ResultScreen extends StatefulWidget{
  const ResultScreen({super.key,required this.answers,this.incomingChallenge});
  final List<int> answers;
  final ChallengeData? incomingChallenge;
  @override
  State<ResultScreen> createState()=>_ResultScreenState();
}
class _ResultScreenState extends State<ResultScreen>{
  bool _copied=false;
  String get _challengeCode=>ChallengeCodec.encode(widget.answers);
  Future<void> _copyChallenge()async{
    await Clipboard.setData(ClipboardData(text:_challengeCode));
    if(!mounted)return;
    HapticFeedback.lightImpact();
    setState(()=>_copied=true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(AppStrings.of(context).t('copiedToast'))));
  }
  Future<void> _shareChallenge()async{
    final s=AppStrings.of(context);
    await Share.share('${s.t('start')}\nMINDMATCH — ${s.t('heroBody')}\n\n${s.t('invite')}:\n$_challengeCode',subject:'MINDMATCH challenge');
  }
  Future<void> _shareResult(int score)async{
    final s=AppStrings.of(context);
    await Share.share('${s.scoreShare(score)}\nMINDMATCH — ${s.verdict(score)}\n${s.t('where')}: $score%',subject:'My MINDMATCH result');
    if(!mounted)return;
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(s.t('sharedToast'))));
  }
  @override
  Widget build(BuildContext context){
    final s=AppStrings.of(context);
    final other=widget.incomingChallenge;
    final score=other==null?null:ChallengeCodec.calculateMatchPercent(widget.answers,other.answers);
    final matches=other==null?0:List<int>.generate(widget.answers.length,(i)=>i).where((i)=>widget.answers[i]==other.answers[i]).length;
    return Scaffold(
      appBar:AppBar(automaticallyImplyLeading:false,title:Text(s.t('report'),style:const TextStyle(fontSize:11,letterSpacing:1.5,fontWeight:FontWeight.w900)),actions:[IconButton(onPressed:()=>Navigator.of(context).popUntil((route)=>route.isFirst),icon:const Icon(Icons.close_rounded))]),
      body:SafeArea(child:ListView(padding:const EdgeInsets.fromLTRB(22,14,22,30),children:[
        Container(padding:const EdgeInsets.fromLTRB(20,27,20,25),decoration:BoxDecoration(borderRadius:BorderRadius.circular(29),gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF49316F),Color(0xFF211832),Color(0xFF15121F)]),border:Border.all(color:const Color(0xFF8065B4).withOpacity(.8)),boxShadow:[BoxShadow(color:mindPurple.withOpacity(.12),blurRadius:30,offset:const Offset(0,12))]),child:Column(children:[
          const Icon(Icons.auto_awesome_rounded,color:mindGold,size:27),const SizedBox(height:13),
          Text(score==null?s.t('yourMind'):'$score%',textAlign:TextAlign.center,style:const TextStyle(fontSize:score==null?40:58,height:1.05,fontWeight:FontWeight.w900,letterSpacing:-1.5)),
          const SizedBox(height:10),
          Text(score==null?s.t('firstHalf'):s.verdict(score),style:const TextStyle(color:mindLilac,fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.2)),
          const SizedBox(height:18),Container(height:1,width:70,color:const Color(0xFF8B73B4).withOpacity(.5)),const SizedBox(height:16),
          Text(score==null?s.t('firstDescription'):'$matches / ${widget.answers.length}  ·  ${score==100?s.t('sameDescription'):s.t('diffDescription')}',textAlign:TextAlign.center,style:const TextStyle(color:Color(0xFFD2C8E2),height:1.55,fontSize:13)),
        ])),
        const SizedBox(height:24),
        if(score==null)...[
          Text(s.t('invite'),style:const TextStyle(fontSize:10,letterSpacing:1.4,color:mindLilac,fontWeight:FontWeight.w900)),
          const SizedBox(height:10),
          Container(padding:const EdgeInsets.symmetric(horizontal:14,vertical:18),decoration:BoxDecoration(color:mindSurface,borderRadius:BorderRadius.circular(17),border:Border.all(color:const Color(0xFF493B60))),child:SelectableText(_challengeCode,textAlign:TextAlign.center,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w900,letterSpacing:1.3,color:Colors.white))),
          const SizedBox(height:12),
          SizedBox(height:53,child:FilledButton.icon(onPressed:_copyChallenge,icon:Icon(_copied?Icons.check_rounded:Icons.copy_rounded),label:Text(_copied?s.t('copied'):s.t('copyCode')),style:FilledButton.styleFrom(backgroundColor:mindPurple,foregroundColor:const Color(0xFF160F25),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(17))))),
          const SizedBox(height:9),
          SizedBox(height:51,child:OutlinedButton.icon(onPressed:_shareChallenge,icon:const Icon(Icons.ios_share_rounded),label:Text(s.t('shareScore')),style:OutlinedButton.styleFrom(foregroundColor:mindLilac,side:const BorderSide(color:Color(0xFF66518D)),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16))))),
          const SizedBox(height:12),
          Text(s.t('howTo'),textAlign:TextAlign.center,style:const TextStyle(color:mindMuted,fontSize:11,height:1.5)),
        ]else...[
          Text(s.t('where'),style:const TextStyle(fontSize:10,letterSpacing:1.4,color:mindLilac,fontWeight:FontWeight.w900)),
          const SizedBox(height:12),
          ...List.generate(widget.answers.length,(index){
            final matched=widget.answers[index]==other.answers[index];
            final localized=localizedQuestion(mindMatchQuestions[index],s.languageCode);
            return Container(margin:const EdgeInsets.only(bottom:9),padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:mindSurface,borderRadius:BorderRadius.circular(16),border:Border.all(color:matched?const Color(0xFF426B60):const Color(0xFF3B304D))),child:Row(children:[
              Container(width:31,height:31,alignment:Alignment.center,decoration:BoxDecoration(color:matched?const Color(0xFF24463D):mindSurfaceRaised,borderRadius:BorderRadius.circular(10)),child:Text('${index+1}',style:TextStyle(color:matched?const Color(0xFF9CE2C8):mindLilac,fontWeight:FontWeight.w900,fontSize:11))),
              const SizedBox(width:12),Expanded(child:Text(localized.category,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:11,letterSpacing:.5))),
              Icon(matched?Icons.check_circle_rounded:Icons.bolt_rounded,color:matched?const Color(0xFF83D9B7):mindGold,size:17),const SizedBox(width:6),
              Text(matched?s.t('match'):s.t('different'),style:TextStyle(color:matched?const Color(0xFF83D9B7):mindGold,fontSize:9,fontWeight:FontWeight.w900,letterSpacing:.4)),
            ]));
          }),
          const SizedBox(height:8),
          SizedBox(height:53,child:OutlinedButton.icon(onPressed:()=>_shareResult(score),icon:const Icon(Icons.ios_share_rounded,size:18),label:Text(s.t('shareScore')),style:OutlinedButton.styleFrom(foregroundColor:mindLilac,side:const BorderSide(color:Color(0xFF66518D)),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16))))),
        ],
        const SizedBox(height:18),
        TextButton(onPressed:()=>Navigator.of(context).popUntil((route)=>route.isFirst),child:Text(s.t('back'),style:const TextStyle(color:mindMuted,letterSpacing:1,fontSize:10,fontWeight:FontWeight.w900))),
      ])),
    );
  }
}

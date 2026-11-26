import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindmatch/shared/l10n/app_strings.dart';
import 'package:mindmatch/core/theme/mindmatch_theme.dart';
import 'package:mindmatch/features/quiz/domain/models/quiz_question.dart';
import 'package:mindmatch/features/challenges/data/challenge_codec.dart';
import 'package:mindmatch/features/ads/data/mindmatch_ads.dart';
import 'package:mindmatch/features/daily/data/mindmatch_retention.dart';
import 'package:mindmatch/features/results/presentation/pages/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key,this.incomingChallenge,this.questions,this.isDaily=false});
  final ChallengeData? incomingChallenge;
  final List<QuizQuestion>? questions;
  final bool isDaily;
  @override
  State<QuizScreen> createState()=>_QuizScreenState();
}
class _QuizScreenState extends State<QuizScreen>{
  final List<int> _answers=[];
  List<QuizQuestion> get _questions {
    final ids = widget.incomingChallenge?.questionIds;
    if (ids != null && ids.isNotEmpty) {
      return ids.map((id) => mindMatchQuestions.firstWhere((question) => question.id == id)).toList(growable:false);
    }
    if (widget.incomingChallenge != null) return mindMatchQuestions.take(widget.incomingChallenge!.answers.length).toList(growable:false);
    return widget.questions ?? mindMatchQuestions;
  }
  int _current=0;
  void _select(int answer){HapticFeedback.selectionClick();setState((){if(_answers.length>_current){_answers[_current]=answer;}else{_answers.add(answer);}});}
  Future<void> _next() async {
    if(_answers.length<=_current)return;
    HapticFeedback.lightImpact();
    if(_current<_questions.length-1){setState(()=>_current++);return;}
    await MindMatchAds.instance.showInterstitialBetweenRounds();
    if (!mounted) return;
    if (widget.isDaily) {
      await MindMatchRetention.instance.recordDailyCompletion(DateTime.now());
      if (!mounted) return;
    }
    Navigator.of(context).pushReplacement(PageRouteBuilder<void>(
      pageBuilder:(_,animation,secondaryAnimation)=>ResultScreen(answers:List<int>.unmodifiable(_answers),quizQuestions:_questions,incomingChallenge:widget.incomingChallenge),
      transitionsBuilder:(_,animation,secondaryAnimation,child)=>FadeTransition(opacity:CurvedAnimation(parent:animation,curve:Curves.easeOut),child:child),
    ));
  }
  @override
  Widget build(BuildContext context){
    final s=AppStrings.of(context);
    final question=_questions[_current];
    final localized=localizedQuestion(question,s.languageCode);
    final selected=_answers.length>_current?_answers[_current]:-1;
    final progress=(_current+1)/_questions.length;
    return Scaffold(
      appBar:AppBar(leading:IconButton(icon:const Icon(Icons.close_rounded),onPressed:()=>Navigator.of(context).pop()),title:Text(s.t('mindLab'),style:const TextStyle(fontSize:11,letterSpacing:2,fontWeight:FontWeight.w900)),actions:[Padding(padding:const EdgeInsetsDirectional.only(end:21),child:Center(child:Text('${_current+1} / ${_questions.length}',style:const TextStyle(color:mindLilac,fontSize:12,fontWeight:FontWeight.w900))))]),
      body:SafeArea(child:Padding(padding:const EdgeInsets.fromLTRB(22,14,22,22),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[Expanded(child:ClipRRect(borderRadius:BorderRadius.circular(20),child:TweenAnimationBuilder<double>(tween:Tween(begin:0,end:progress),duration:const Duration(milliseconds:420),curve:Curves.easeOutCubic,builder:(_,value,__)=>LinearProgressIndicator(value:value,minHeight:7,backgroundColor:mindSurfaceRaised,color:mindPurple)))),const SizedBox(width:12),Text('${(progress*100).round()}%',style:const TextStyle(color:mindMuted,fontSize:10,fontWeight:FontWeight.w800))]),
        const SizedBox(height:31),
        Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:7),decoration:BoxDecoration(color:const Color(0xFF30234B),borderRadius:BorderRadius.circular(30),border:Border.all(color:const Color(0xFF574477))),child:Text(localized.category,style:const TextStyle(color:mindLilac,fontSize:9,fontWeight:FontWeight.w900,letterSpacing:1.2))),
        const SizedBox(height:17),
        Text(localized.prompt,style:const TextStyle(fontSize:27,height:1.2,fontWeight:FontWeight.w900,letterSpacing:-.5)),
        const SizedBox(height:9),Text(s.t('firstInstinct'),style:const TextStyle(color:mindMuted,fontSize:12,height:1.45)),
        const SizedBox(height:24),
        Expanded(child:ListView.separated(itemCount:localized.options.length,separatorBuilder:(_,__)=>const SizedBox(height:11),itemBuilder:(context,index){
          final isSelected=selected==index;
          return InkWell(borderRadius:BorderRadius.circular(19),onTap:()=>_select(index),child:AnimatedContainer(duration:const Duration(milliseconds:190),curve:Curves.easeOut,padding:const EdgeInsets.symmetric(horizontal:15,vertical:17),decoration:BoxDecoration(gradient:isSelected?const LinearGradient(colors:[Color(0xFF3B2A5C),Color(0xFF28203C)]):null,color:isSelected?null:mindSurface,borderRadius:BorderRadius.circular(19),border:Border.all(color:isSelected?mindPurple:const Color(0xFF352B4A),width:isSelected?1.6:1),boxShadow:isSelected?[BoxShadow(color:mindPurple.withOpacity(.12),blurRadius:18,offset:const Offset(0,7))]:[]),child:Row(children:[
            Container(width:34,height:34,alignment:Alignment.center,decoration:BoxDecoration(color:isSelected?mindPurple:mindSurfaceRaised,borderRadius:BorderRadius.circular(11)),child:Text(String.fromCharCode(65+index),style:TextStyle(color:isSelected?const Color(0xFF160F25):mindLilac,fontWeight:FontWeight.w900,fontSize:12))),
            const SizedBox(width:13),Expanded(child:Text(localized.options[index],style:TextStyle(fontSize:13,height:1.35,fontWeight:isSelected?FontWeight.w800:FontWeight.w600,color:isSelected?Colors.white:const Color(0xFFD4CDDF)))),
            AnimatedSwitcher(duration:const Duration(milliseconds:160),child:isSelected?const Icon(Icons.check_circle_rounded,key:ValueKey('selected'),color:mindLilac,size:21):const Icon(Icons.circle_outlined,key:ValueKey('unselected'),color:Color(0xFF5A506B),size:20)),
          ])));
        })),
        SizedBox(width:double.infinity,height:56,child:FilledButton(onPressed:selected<0?null:_next,style:FilledButton.styleFrom(backgroundColor:mindPurple,disabledBackgroundColor:const Color(0xFF302744),foregroundColor:const Color(0xFF160F25),disabledForegroundColor:mindMuted,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(17))),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Text(_current==_questions.length-1?s.t('reveal'):s.t('continue'),style:const TextStyle(fontWeight:FontWeight.w900,fontSize:11,letterSpacing:.6)),const SizedBox(width:8),const Icon(Icons.arrow_forward_rounded,size:17)]))),
      ]))),
    );
  }
}

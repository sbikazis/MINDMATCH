import 'quiz_question.dart';

class QuizPack {
  const QuizPack({required this.id, required this.titleKey, required this.descriptionKey, required this.icon, required this.questionIds});
  final String id;
  final String titleKey;
  final String descriptionKey;
  final String icon;
  final List<String> questionIds;

  List<QuizQuestion> get questions => questionIds.map((id) => mindMatchQuestions.firstWhere((q) => q.id == id)).toList(growable: false);
}

const quizPacks = <QuizPack>[
  QuizPack(id:'friendship',titleKey:'packFriendship',descriptionKey:'packFriendshipDesc',icon:'🤝',questionIds:['betrayal','firstmove','secret','loyalty','romance','island','choice']),
  QuizPack(id:'deep',titleKey:'packDeep',descriptionKey:'packDeepDesc',icon:'🌙',questionIds:['mirror','rewind','memory2','future','fear','truth','secretwish']),
  QuizPack(id:'chaos',titleKey:'packChaos',descriptionKey:'packChaosDesc',icon:'⚡',questionIds:['mystery','plot','thoughts','midnight','power','risk','risk2']),
  QuizPack(id:'social',titleKey:'packSocial',descriptionKey:'packSocialDesc',icon:'🎭',questionIds:['socialbattery','jealousy','lead','argument','creative','weekend','time']),
  QuizPack(id:'lifestyle',titleKey:'packLifestyle',descriptionKey:'packLifestyleDesc',icon:'🎧',questionIds:['roadtrip','foodmood','playlist','gift','grouptrip','textstyle','weekendplan']),
  QuizPack(id:'ambition',titleKey:'packAmbition',descriptionKey:'packAmbitionDesc',icon:'🚀',questionIds:['dreamjob','secretproject','challenge','reset','inspiration','proudmoment','learning']),
  QuizPack(id:'imagination',titleKey:'packImagination',descriptionKey:'packImaginationDesc',icon:'🪐',questionIds:['timeportal','alien','detective','impossible','gameworld','treasure','mystery']),
  QuizPack(id:'connection',titleKey:'packConnection',descriptionKey:'packConnectionDesc',icon:'💜',questionIds:['conflictrepair','boundaries','supportstyle','appreciation','trustbuild','forgiveness','celebration']),
];

List<QuizQuestion> dailyQuestions(DateTime date) {
  final dayNumber = DateTime.utc(date.year, date.month, date.day).difference(DateTime.utc(2024, 1, 1)).inDays;
  final start = (dayNumber * 11) % mindMatchQuestions.length;
  return List<QuizQuestion>.generate(14, (index) => mindMatchQuestions[(start + index) % mindMatchQuestions.length], growable:false);
}

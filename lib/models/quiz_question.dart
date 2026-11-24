import 'package:flutter/widgets.dart';

class QuizQuestion {
  const QuizQuestion({required this.id, required this.prompt, required this.options, required this.category});
  final String id;
  final String prompt;
  final List<String> options;
  final String category;
}

class LocalizedQuestion {
  const LocalizedQuestion(this.category, this.prompt, this.options);
  final String category;
  final String prompt;
  final List<String> options;
}

LocalizedQuestion localizedQuestion(QuizQuestion question, String languageCode) {
  final data = _translations[question.id]?[languageCode];
  if (data == null) return LocalizedQuestion(question.category, question.prompt, question.options);
  return LocalizedQuestion(data[0], data[1], data.sublist(2));
}

const mindMatchQuestions = <QuizQuestion>[
  QuizQuestion(id:'midnight',category:'INSTINCT',prompt:'You get a free ticket to anywhere. When do you leave?',options:['Right now','Tomorrow morning','After a little planning','I need to know who is coming']),
  QuizQuestion(id:'mystery',category:'CURIOSITY',prompt:'A mysterious door appears in your room. What do you do?',options:['Open it immediately','Look for clues first','Ask someone to come with me','Pretend I did not see it']),
  QuizQuestion(id:'power',category:'IMAGINATION',prompt:'Choose one unusual superpower.',options:['Pause time','Read animal thoughts','Teleport anywhere','Replay one memory']),
  QuizQuestion(id:'weekend',category:'VIBE',prompt:'Your perfect unexpected free day looks like…',options:['A spontaneous adventure','A cozy day at home','Meeting my favorite people','Trying something completely new']),
  QuizQuestion(id:'truth',category:'INSTINCT',prompt:'Your friend asks for an honest opinion. You…',options:['Say exactly what I think','Find the kindest way to say it','Ask if they really want the truth','Wait until the right moment']),
  QuizQuestion(id:'time',category:'IMAGINATION',prompt:'Which place would you explore first?',options:['The deep ocean','Outer space','An ancient lost city','A future version of Earth']),
  QuizQuestion(id:'choice',category:'VIBE',prompt:'Pick the message that feels most like you.',options:['Let us do it!','I have a plan.','This is going to be interesting.','Tell me everything.']),
];

const _translations = <String, Map<String, List<String>>>{
'midnight': {
'ar':['الحدس','حصلت على تذكرة مجانية إلى أي مكان. متى ستغادر؟','حالاً','غداً صباحاً','بعد قليل من التخطيط','أحتاج لمعرفة من سيرافقني'],
'fr':['INSTINCT','Tu reçois un billet gratuit pour n’importe où. Tu pars quand ?','Tout de suite','Demain matin','Après un peu de préparation','Je dois savoir qui vient'],
},
'mystery': {
'ar':['الفضول','ظهر باب غامض في غرفتك. ماذا ستفعل؟','أفتحه فوراً','أبحث عن أدلة أولاً','أطلب من شخص أن يرافقني','أتظاهر بأنني لم أره'],
'fr':['CURIOSITÉ','Une porte mystérieuse apparaît dans ta chambre. Que fais-tu ?','Je l’ouvre immédiatement','Je cherche des indices','Je demande à quelqu’un de venir','Je fais comme si je ne l’avais pas vue'],
},
'power': {
'ar':['الخيال','اختر قوة خارقة غير عادية.','إيقاف الزمن','فهم أفكار الحيوانات','الانتقال الفوري إلى أي مكان','إعادة عيش ذكرى واحدة'],
'fr':['IMAGINATION','Choisis un superpouvoir inhabituel.','Arrêter le temps','Lire les pensées des animaux','Me téléporter partout','Revivre un souvenir'],
},
'weekend': {
'ar':['الأجواء','كيف تقضي يوماً حراً ومفاجئاً؟','مغامرة عفوية','يوم هادئ في المنزل','لقاء الأشخاص المفضلين','تجربة شيء جديد تماماً'],
'fr':['AMBIANCE','À quoi ressemble ta journée libre idéale ?','Une aventure spontanée','Une journée cocooning','Voir mes personnes préférées','Essayer quelque chose de nouveau'],
},
'truth': {
'ar':['الحدس','طلب منك صديق رأياً صريحاً. ماذا تفعل؟','أقول ما أفكر فيه تماماً','أختار ألطف طريقة للقول','أسأله إن كان يريد الحقيقة فعلاً','أنتظر اللحظة المناسبة'],
'fr':['INSTINCT','Un ami te demande un avis honnête. Tu…','Dis exactement ce que je pense','Trouve une façon douce de le dire','Demande s’il veut vraiment la vérité','Attends le bon moment'],
},
'time': {
'ar':['الخيال','أي مكان ستستكشف أولاً؟','أعماق المحيط','الفضاء الخارجي','مدينة قديمة مفقودة','نسخة مستقبلية من الأرض'],
'fr':['IMAGINATION','Quel endroit explorerais-tu en premier ?','Les profondeurs océaniques','L’espace','Une cité antique perdue','Une version future de la Terre'],
},
'choice': {
'ar':['الأجواء','اختر العبارة الأقرب إلى شخصيتك.','هيا نفعلها!','لدي خطة.','سيكون هذا مثيراً للاهتمام.','أخبرني بكل شيء.'],
'fr':['AMBIANCE','Choisis la phrase qui te ressemble.','On y va !','J’ai un plan.','Ça promet d’être intéressant.','Raconte-moi tout.'],
},
};

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
  QuizQuestion(id:'betrayal',category:'FRIENDSHIP',prompt:'Your group chat goes silent after your message. What is your move?',options:['Send a dramatic follow-up','Drop a meme and disappear','Assume everyone is busy','Call the one friend who always replies']),
  QuizQuestion(id:'plot',category:'CHAOS',prompt:'You wake up famous tomorrow. What is your first move?',options:['Find out why','Call my closest people','Enjoy the moment quietly','Use the attention for good']),
  QuizQuestion(id:'secret',category:'TRUST',prompt:'Someone tells you a secret that could change everything. You…',options:['Keep it locked forever','Ask how I can help','Help solve the problem','Tell the hard truth kindly']),
  QuizQuestion(id:'island',category:'ADVENTURE',prompt:'You are stranded on an island. Choose one companion.',options:['The clever problem-solver','The fearless adventurer','The funny mood-lifter','The calm one who never panics']),
  QuizQuestion(id:'thoughts',category:'CURIOSITY',prompt:'You can hear one person’s thoughts for 10 minutes. Whose?',options:['My best friend','My future self','Someone I admire','Someone I cannot understand']),
  QuizQuestion(id:'rewind',category:'MEMORIES',prompt:'You can relive one day. Which would you choose?',options:['My happiest childhood day','A day with someone I miss','The day everything changed','A day I would do differently']),
  QuizQuestion(id:'risk',category:'BOLDNESS',prompt:'A once-in-a-lifetime opportunity arrives, but it is risky. You…',options:['Jump in immediately','Research every detail','Ask someone I trust','Wait for a sign, then decide']),
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
'betrayal': {'ar':['الصداقة','ساد الصمت في مجموعة الأصدقاء بعد رسالتك. ماذا تفعل؟','أرسل رسالة درامية','أرسل ميم وأختفي','الجميع مشغول غالباً','أتصل بالصديق الذي يرد دائماً'],'fr':['AMITIÉ','Le groupe devient silencieux après ton message. Tu…','Envoies un message dramatique','Balances un meme et disparais','Ils sont sûrement occupés','Appelles ton ami toujours présent']},
'plot': {'ar':['الفوضى','استيقظت مشهوراً غداً. ما أول شيء تفعله؟','أكتشف السبب','أتصل بأقرب الناس','أستمتع بهدوء','أستغل الاهتمام لشيء مفيد'],'fr':['CHAOS','Demain, tu te réveilles célèbre. Tu…','Découvres pourquoi','Appelles tes proches','Profites tranquillement','Utilises cette attention pour le bien']},
'secret': {'ar':['الثقة','أخبرك شخص بسر قد يغير كل شيء. ماذا تفعل؟','أحفظه إلى الأبد','أسأله كيف أساعده','أساعده في الحل','أقول الحقيقة بلطف'],'fr':['CONFIANCE','Quelqu’un te confie un secret important. Tu…','Le gardes pour toujours','Demandes comment aider','Aides à trouver une solution','Dis la vérité avec tact']},
'island': {'ar':['المغامرة','أنت عالق في جزيرة. من تختار؟','الذكي الذي يجد الحلول','المغامر الشجاع','خفيف الظل','الهادئ الذي لا يفزع'],'fr':['AVENTURE','Tu es coincé sur une île. Qui choisis-tu ?','Le débrouillard','L’aventurier intrépide','Le drôle','Le calme']},
'thoughts': {'ar':['الفضول','يمكنك سماع أفكار شخص لعشر دقائق. من تختار؟','أفضل صديق','نسختي المستقبلية','شخص أُعجب به','شخص لا أفهمه'],'fr':['CURIOSITÉ','Tu peux lire les pensées 10 minutes. Qui ?','Mon meilleur ami','Mon moi futur','Quelqu’un que j’admire','Une personne mystérieuse']},
'rewind': {'ar':['الذكريات','يمكنك عيش يوم من جديد. أي يوم؟','أسعد يوم في طفولتي','يوم مع شخص أفتقده','اليوم الذي تغير فيه كل شيء','يوم أتمنى تغييره'],'fr':['SOUVENIRS','Tu peux revivre une journée. Laquelle ?','Mon plus beau jour d’enfance','Un jour avec quelqu’un qui me manque','Le jour où tout a changé','Un jour à refaire']},
'risk': {'ar':['الجرأة','فرصة العمر أمامك لكنها محفوفة بالمخاطر. ماذا تفعل؟','أقفز إليها فوراً','أبحث في التفاصيل','أستشير شخصاً أثق به','أنتظر إشارة ثم أقرر'],'fr':['AUDACE','Une occasion unique se présente, mais elle est risquée. Tu…','Je fonce','J’étudie les détails','Je demande conseil','J’attends un signe']},
};

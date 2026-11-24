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
  QuizQuestion(id:'firstmove',category:'FRIENDSHIP',prompt:"Your friend is having a terrible day but says “I’m fine.” You…",options:["Show up with their favorite snack","Give them space but check in later","Make them laugh until they open up","Ask directly what they need"]),
  QuizQuestion(id:'mirror',category:'SELF',prompt:"What do people usually misunderstand about you?",options:["My silence","My sense of humor","How deeply I care","How ambitious I am"]),
  QuizQuestion(id:'jealousy',category:'EMOTIONS',prompt:"Someone gets the opportunity you secretly wanted. Your first feeling?",options:["Happy for them, honestly","A little jealous, then motivated","I wonder what they did differently","I need a minute to process it"]),
  QuizQuestion(id:'lead',category:'LEADERSHIP',prompt:"Your group is lost during a trip. What role do you take?",options:["The navigator who finds the way","The calm one keeping everyone together","The funny one keeping morale high","The one who asks locals for help"]),
  QuizQuestion(id:'future',category:'FUTURE',prompt:"A message arrives from your future self. What do you hope it says?",options:["You made it. Keep going.","Take more risks.","Spend more time with your people.","Everything you feared was worth it."]),
  QuizQuestion(id:'argument',category:'CONFLICT',prompt:"During an argument, what is hardest for you?",options:["Admitting I was wrong","Staying calm","Explaining what hurt me","Knowing when to stop"]),
  QuizQuestion(id:'creative',category:'CREATIVITY',prompt:"You have one free month and unlimited supplies. You create…",options:["A short film or game","A business or big project","Something beautiful with my hands","A trip and unforgettable memories"]),
  QuizQuestion(id:'loyalty',category:'LOYALTY',prompt:"A friend makes a mistake that hurts you. What matters most?",options:["They own it without excuses","They try to make things right","They understand why it hurt","They do not repeat it"]),
  QuizQuestion(id:'socialbattery',category:'SOCIAL',prompt:"At a party where you know almost nobody, you…",options:["Start conversations with everyone","Find one person with a good vibe","Stay near the snacks and observe","Leave early and recharge"]),
  QuizQuestion(id:'fear',category:'COURAGE',prompt:"Which fear would you most like to defeat?",options:["Fear of failing","Fear of being judged","Fear of losing someone","Fear of starting over"]),
  QuizQuestion(id:'memory2',category:'MEMORIES',prompt:"You find a box of memories from ten years ago. What do you open first?",options:["Old photos","Letters and messages","A forgotten personal object","A note I wrote to myself"]),
  QuizQuestion(id:'romance',category:'CONNECTION',prompt:"What makes you feel most understood?",options:["Someone remembers tiny details","Someone listens without fixing everything","Someone makes time for me","Someone supports my wild ideas"]),
  QuizQuestion(id:'risk2',category:'DECISIONS',prompt:"You must choose without knowing the outcome. You trust…",options:["My gut feeling","Facts and probabilities","Advice from people I trust","The choice I can live with"]),
  QuizQuestion(id:'secretwish',category:'DREAMS',prompt:"If nobody could judge you, what would you try?",options:["Perform on a stage","Move somewhere completely new","Build something people remember","Tell someone how I really feel"]),
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
'firstmove': {'ar':["الصداقة","صديقك يمر بيوم سيئ لكنه يقول «أنا بخير». ماذا تفعل؟","أزوره ومعي طعامه المفضل","أمنحه مساحة وأطمئن عليه لاحقاً","أحاول إضحاكه حتى يتكلم","أسأله مباشرة عما يحتاجه"],'fr':["AMITIÉ","Ton ami passe une mauvaise journée mais dit « ça va ». Tu…","Arrives avec son snack préféré","Lui laisses de l’espace et reprends des nouvelles","Essaies de le faire rire","Lui demandes directement ce dont il a besoin"]},
'mirror': {'ar':["الذات","ما الشيء الذي يسيء الناس فهمه فيك غالباً؟","صمتي","حسّي الفكاهي","مدى اهتمامي بالآخرين","طموحي الكبير"],'fr':["SOI","Que comprennent souvent mal les autres chez toi ?","Mon silence","Mon humour","À quel point je tiens aux autres","Mon ambition"]},
'jealousy': {'ar':["المشاعر","حصل شخص آخر على فرصة كنت تتمناها سراً. ما شعورك الأول؟","سعيد من أجله بصدق","أشعر ببعض الغيرة ثم أتحفز","أتساءل عما فعله بشكل مختلف","أحتاج دقيقة لاستيعاب الأمر"],'fr':["ÉMOTIONS","Quelqu’un obtient l’occasion que tu voulais en secret. Ta première réaction ?","Vraiment heureux pour lui","Un peu jaloux, puis motivé","Je me demande ce qu’il a fait différemment","J’ai besoin d’un moment"]},
'lead': {'ar':["القيادة","ضاعت مجموعتك أثناء رحلة. ما الدور الذي ستتولاه؟","أبحث عن الطريق","أحافظ على هدوء الجميع وتماسكهم","أرفع المعنويات بالمزاح","أطلب المساعدة من السكان"],'fr':["LEADERSHIP","Ton groupe se perd pendant un voyage. Quel rôle prends-tu ?","Je trouve le chemin","Je garde tout le monde calme et uni","Je remonte le moral avec humour","Je demande de l’aide aux habitants"]},
'future': {'ar':["المستقبل","وصلتك رسالة من نفسك في المستقبل. ماذا تتمنى أن تقول؟","لقد نجحت، واصل الطريق","خاطر أكثر","اقضِ وقتاً أطول مع من تحب","كل ما خفت منه كان يستحق"],'fr':["AVENIR","Tu reçois un message de ton futur toi. Que veux-tu lire ?","Tu as réussi. Continue.","Prends plus de risques.","Passe plus de temps avec tes proches.","Tout ce que tu craignais en valait la peine."]},
'argument': {'ar':["الخلاف","أثناء الجدال، ما أصعب شيء عليك؟","الاعتراف بأنني مخطئ","الحفاظ على هدوئي","شرح ما جرحني","معرفة متى يجب أن أتوقف"],'fr':["CONFLIT","Pendant une dispute, qu’est-ce qui est le plus difficile ?","Admettre que j’ai tort","Rester calme","Expliquer ce qui m’a blessé","Savoir quand m’arrêter"]},
'creative': {'ar':["الإبداع","لديك شهر حر وكل الموارد متاحة. ماذا ستصنع؟","فيلماً قصيراً أو لعبة","مشروعاً كبيراً أو شركة","شيئاً جميلاً بيدي","رحلة وذكريات لا تُنسى"],'fr':["CRÉATIVITÉ","Tu as un mois libre et toutes les ressources. Tu crées…","Un court-métrage ou un jeu","Une entreprise ou un grand projet","Quelque chose de beau de tes mains","Un voyage et des souvenirs inoubliables"]},
'loyalty': {'ar':["الوفاء","ارتكب صديق خطأ جرحك. ما الأهم بالنسبة إليك؟","أن يعترف به دون أعذار","أن يحاول إصلاح الأمر","أن يفهم لماذا جرحك","ألا يكرر الخطأ"],'fr':["FIDÉLITÉ","Un ami fait une erreur qui te blesse. Qu’est-ce qui compte le plus ?","Qu’il assume sans excuses","Qu’il essaie de réparer","Qu’il comprenne pourquoi ça fait mal","Qu’il ne recommence pas"]},
'socialbattery': {'ar':["اجتماعيات","في حفلة لا تعرف فيها أحداً تقريباً، ماذا تفعل؟","أبدأ الحديث مع الجميع","أبحث عن شخص أشعر بالانسجام معه","أراقب الأجواء قرب الطعام","أغادر مبكراً لأستعيد طاقتي"],'fr':["SOCIAL","À une fête où tu ne connais presque personne, tu…","Parles avec tout le monde","Trouves une personne avec qui le courant passe","Observes près du buffet","Pars tôt pour recharger tes batteries"]},
'fear': {'ar':["الشجاعة","أي خوف تتمنى التغلب عليه أكثر؟","الخوف من الفشل","الخوف من أحكام الآخرين","الخوف من فقدان شخص","الخوف من البدء من جديد"],'fr':["COURAGE","Quelle peur aimerais-tu le plus vaincre ?","La peur d’échouer","La peur du jugement","La peur de perdre quelqu’un","La peur de recommencer"]},
'memory2': {'ar':["الذكريات","عثرت على صندوق ذكريات من عشر سنوات. ماذا تفتح أولاً؟","الصور القديمة","الرسائل والخطابات","غرض شخصي نسيته","رسالة كتبتها لنفسي"],'fr':["SOUVENIRS","Tu trouves une boîte de souvenirs d’il y a dix ans. Tu ouvres quoi ?","Les vieilles photos","Les lettres et messages","Un objet personnel oublié","Une note que je m’étais écrite"]},
'romance': {'ar':["التواصل","ما الذي يجعلك تشعر بأن شخصاً يفهمك حقاً؟","أن يتذكر التفاصيل الصغيرة","أن يستمع دون محاولة حل كل شيء","أن يخصص لي وقتاً","أن يدعم أفكاري المجنونة"],'fr':["LIEN","Qu’est-ce qui te fait te sentir vraiment compris ?","Quelqu’un qui retient les petits détails","Quelqu’un qui écoute sans tout vouloir réparer","Quelqu’un qui prend du temps pour moi","Quelqu’un qui soutient mes idées folles"]},
'risk2': {'ar':["القرارات","عليك الاختيار دون معرفة النتيجة. بماذا تثق؟","حدسي","الحقائق والاحتمالات","نصيحة من أثق بهم","الخيار الذي أستطيع التعايش معه"],'fr':["DÉCISIONS","Tu dois choisir sans connaître le résultat. Tu fais confiance…","À mon intuition","Aux faits et probabilités","Aux conseils de mes proches","Au choix avec lequel je peux vivre"]},
'secretwish': {'ar':["الأحلام","لو لم يستطع أحد الحكم عليك، ماذا ستجرب؟","الصعود إلى المسرح","الانتقال إلى مكان جديد تماماً","بناء شيء يتذكره الناس","إخبار شخص بما أشعر به حقاً"],'fr':["RÊVES","Si personne ne pouvait te juger, qu’essaierais-tu ?","Monter sur scène","Partir vivre ailleurs","Créer quelque chose dont on se souvient","Dire à quelqu’un ce que je ressens vraiment"]},
};

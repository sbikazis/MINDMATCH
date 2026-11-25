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
  final data = _translations[question.id]?[languageCode] ?? expandedQuestionTranslations[question.id]?[languageCode];
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
  ...expandedMindMatchQuestions,
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


import 'quiz_question.dart';

/// Original second-season question set. Keep IDs stable: challenge codes store them.
const expandedMindMatchQuestions = <QuizQuestion>[
  QuizQuestion(id:'roadtrip',category:'ADVENTURE',prompt:'The road trip has one empty seat. Who gets it?',options:['The friend with the best stories','The one who plans every stop','The person who makes everyone laugh','Someone I have never met']),
  QuizQuestion(id:'foodmood',category:'LIFESTYLE',prompt:'A new restaurant menu has one dish you cannot identify. You…',options:['Order it immediately','Ask the waiter everything','Watch what other people order','Choose my usual favourite']),
  QuizQuestion(id:'playlist',category:'MUSIC',prompt:'Your life gets a soundtrack for one day. What is the vibe?',options:['Main-character energy','Calm and cinematic','Pure chaotic fun','A nostalgic throwback']),
  QuizQuestion(id:'gift',category:'FRIENDSHIP',prompt:'You have to choose a meaningful gift with a tiny budget. You pick…',options:['Something handmade','A shared experience','A thoughtful little detail','A funny surprise']),
  QuizQuestion(id:'grouptrip',category:'SOCIAL',prompt:'Your friends plan a trip but nobody chooses a destination. You…',options:['Take charge and decide','Create a quick vote','Suggest somewhere unexpected','Wait for the group mood']),
  QuizQuestion(id:'textstyle',category:'COMMUNICATION',prompt:'How do you usually reply to a message you really like?',options:['Instantly with a long reply','A voice note','A meme that says it all','I think about the perfect response']),
  QuizQuestion(id:'weekendplan',category:'LIFESTYLE',prompt:'Your plans get cancelled at the last minute. Best reaction?',options:['Celebrate the unexpected free time','Find a new plan immediately','Invite someone over','Enjoy doing absolutely nothing']),
  QuizQuestion(id:'dreamjob',category:'AMBITION',prompt:'You can try any job for one month. What do you choose?',options:['Film director','Wildlife explorer','Game designer','Chef with a tiny restaurant']),
  QuizQuestion(id:'secretproject',category:'CREATIVITY',prompt:'You can secretly work on one project for a year. It is…',options:['A story or comic','A useful app or invention','A music or art project','A community event']),
  QuizQuestion(id:'challenge',category:'GROWTH',prompt:'A skill becomes easy if you practise it for 30 days. Which one?',options:['Speaking a new language','Playing an instrument','A sport or dance','Coding or building things']),
  QuizQuestion(id:'reset',category:'SELF',prompt:'You get one completely fresh start. What changes first?',options:['My daily routine','The people I spend time with','The place I live or work','The goal I am chasing']),
  QuizQuestion(id:'inspiration',category:'DREAMS',prompt:'Where do your best ideas usually appear?',options:['While walking outside','Late at night','During conversations','When I am bored']),
  QuizQuestion(id:'proudmoment',category:'MEMORIES',prompt:'Which small win would make you quietly proud?',options:['Keeping a promise to myself','Helping someone without being asked','Finishing something difficult','Trying after being afraid']),
  QuizQuestion(id:'learning',category:'CURIOSITY',prompt:'A free class appears in your feed. Which title gets your click?',options:['How the universe works','How to understand people','How to make something from scratch','How to solve a strange mystery']),
  QuizQuestion(id:'timeportal',category:'IMAGINATION',prompt:'A time portal opens for one hour. Where do you go?',options:['A day in my own future','A famous moment in history','A world that no longer exists','A day from my childhood']),
  QuizQuestion(id:'alien',category:'CURIOSITY',prompt:'An alien asks what humans are best at. What do you say?',options:['Creating stories','Making connections','Finding clever solutions','Turning mistakes into jokes']),
  QuizQuestion(id:'detective',category:'MYSTERY',prompt:'A mystery appears with three clues. Your first move?',options:['Connect the clues immediately','Question everyone involved','Look for the detail nobody noticed','Build a wild theory and test it']),
  QuizQuestion(id:'impossible',category:'BOLDNESS',prompt:'You are offered one impossible ability for 24 hours. Choose…',options:['Understand every language','Visit any place instantly','Build anything I can imagine','See how a decision might unfold']),
  QuizQuestion(id:'gameworld',category:'GAMES',prompt:'You enter a game world with your friends. Your role?',options:['The strategist','The explorer','The healer and helper','The unpredictable wildcard']),
  QuizQuestion(id:'treasure',category:'ADVENTURE',prompt:'You find a map to a hidden treasure. What matters most?',options:['The adventure getting there','Who joins me','What the treasure could be','The story I will tell after']),
  QuizQuestion(id:'conflictrepair',category:'CONNECTION',prompt:'After a disagreement, what helps you reconnect?',options:['A sincere apology','A calm conversation','A little time, then a check-in','Doing something kind together']),
  QuizQuestion(id:'boundaries',category:'SELF',prompt:'A friend asks for a favour when your week is already full. You…',options:['Say yes and rearrange everything','Explain honestly that I cannot','Offer a smaller way to help','Take time before answering']),
  QuizQuestion(id:'supportstyle',category:'FRIENDSHIP',prompt:'When you are stressed, what kind of support feels best?',options:['Someone listens without judging','Someone helps make a plan','Someone distracts me with fun','A little space and a check-in later']),
  QuizQuestion(id:'appreciation',category:'CONNECTION',prompt:'Which gesture makes you feel most appreciated?',options:['A thoughtful message','Someone making time for me','Being remembered in a small detail','Help without having to ask']),
  QuizQuestion(id:'trustbuild',category:'TRUST',prompt:'What builds trust fastest between two people?',options:['Consistency over time','Honesty when it is difficult','Respecting private things','Showing up when it matters']),
  QuizQuestion(id:'forgiveness',category:'EMOTIONS',prompt:'Someone sincerely regrets hurting you. What do you need first?',options:['Time to process','A clear explanation','Actions that show change','A direct conversation']),
  QuizQuestion(id:'celebration',category:'FRIENDSHIP',prompt:'Your friend achieves something huge. How do you celebrate?',options:['Plan a surprise','Make a heartfelt message','Go out and make a memory','Tell everyone how proud I am']),
];

const expandedQuestionTranslations = <String, Map<String, List<String>>>{
  'roadtrip': {'ar':['المغامرة','رحلة الطريق فيها مقعد واحد فارغ. من تختار؟','الصديق صاحب القصص الممتعة','من يخطط لكل محطة','من يضحك الجميع','شخص لا أعرفه بعد'],'fr':['AVENTURE','Il reste une place pour le road trip. Qui l’invites-tu ?','L’ami aux meilleures histoires','La personne qui planifie tout','Celle qui fait rire tout le monde','Quelqu’un que je ne connais pas']},
  'foodmood': {'ar':['أسلوب الحياة','وجدت في قائمة مطعم طبقاً لا تعرفه. ماذا تفعل؟','أطلبه فوراً','أسأل النادل عن كل شيء','أراقب ما يطلبه الآخرون','أختار طبقي المعتاد'],'fr':['STYLE DE VIE','Un plat inconnu attire ton attention au restaurant. Tu…','Le commandes tout de suite','Demandes des détails au serveur','Regardes ce que les autres prennent','Choisis mon plat habituel']},
  'playlist': {'ar':['الموسيقى','لو كانت لحياتك موسيقى تصويرية ليوم واحد، فما أجواؤها؟','طاقة بطل القصة','هادئة وسينمائية','فوضى ممتعة','حنين إلى الماضي'],'fr':['MUSIQUE','Ta vie reçoit une bande-son pour une journée. Quelle ambiance ?','Énergie de personnage principal','Calme et cinématographique','Un chaos joyeux','Un retour nostalgique']},
  'gift': {'ar':['الصداقة','تريد إهداء صديق هدية جميلة بميزانية صغيرة. ماذا تختار؟','شيئاً صنعته بيدي','تجربة نعيشها معاً','تفصيلاً صغيراً يحمل معنى','مفاجأة مضحكة'],'fr':['AMITIÉ','Tu veux offrir un cadeau touchant avec un petit budget. Tu choisis…','Quelque chose fait main','Une expérience à partager','Un petit détail attentionné','Une surprise drôle']},
  'grouptrip': {'ar':['اجتماعيات','أصدقاؤك يخططون لرحلة ولا أحد يختار الوجهة. ماذا تفعل؟','أتولى الأمر وأقرر','أقترح تصويتاً سريعاً','أقترح مكاناً غير متوقع','أنتظر أجواء المجموعة'],'fr':['SOCIAL','Tes amis préparent un voyage mais personne ne choisit la destination. Tu…','Prends les commandes','Lances un petit vote','Proposes un lieu inattendu','Attends de voir l’ambiance']},
  'textstyle': {'ar':['التواصل','كيف ترد عادة على رسالة أعجبتك كثيراً؟','أرد فوراً برسالة طويلة','أرسل تسجيلاً صوتياً','أرسل ميم يختصر كل شيء','أفكر في أفضل رد'],'fr':['COMMUNICATION','Comment réponds-tu à un message qui te plaît vraiment ?','Tout de suite avec un long message','Avec une note vocale','Avec un meme qui dit tout','Je cherche la réponse parfaite']},
  'weekendplan': {'ar':['أسلوب الحياة','أُلغيت خططك في آخر لحظة. ما أفضل رد فعل؟','أستمتع بوقت الفراغ المفاجئ','أبحث فوراً عن خطة أخرى','أدعو أحداً لزيارتي','أستمتع بعدم فعل أي شيء'],'fr':['STYLE DE VIE','Tes plans sont annulés à la dernière minute. Ta réaction ?','Je profite de ce temps libre','Je trouve vite un autre plan','J’invite quelqu’un','Je ne fais absolument rien']},
  'dreamjob': {'ar':['الطموح','يمكنك تجربة أي مهنة لمدة شهر. ماذا تختار؟','مخرج أفلام','مستكشف للحياة البرية','مصمم ألعاب','طاهٍ في مطعم صغير'],'fr':['AMBITION','Tu peux essayer n’importe quel métier pendant un mois. Lequel ?','Réalisateur','Explorateur de la nature','Concepteur de jeux','Chef dans un petit restaurant']},
  'secretproject': {'ar':['الإبداع','يمكنك العمل سراً على مشروع لمدة سنة. ماذا سيكون؟','قصة أو قصة مصورة','تطبيق مفيد أو اختراع','مشروع موسيقي أو فني','فعالية مجتمعية'],'fr':['CRÉATIVITÉ','Tu peux travailler secrètement sur un projet pendant un an. Ce serait…','Une histoire ou une BD','Une appli utile ou une invention','Un projet musical ou artistique','Un événement communautaire']},
  'challenge': {'ar':['التطور','ستصبح مهارة ما سهلة إذا تدربت عليها 30 يوماً. ماذا تختار؟','التحدث بلغة جديدة','العزف على آلة موسيقية','رياضة أو رقص','البرمجة أو صنع الأشياء'],'fr':['PROGRESSION','Une compétence devient facile après 30 jours de pratique. Laquelle ?','Parler une nouvelle langue','Jouer d’un instrument','Un sport ou la danse','Coder ou fabriquer des choses']},
  'reset': {'ar':['الذات','حصلت على فرصة بداية جديدة تماماً. ما أول شيء تغيره؟','روتيني اليومي','الأشخاص الذين أقضي وقتي معهم','مكان عيشي أو عملي','الهدف الذي أسعى إليه'],'fr':['SOI','Tu as droit à un nouveau départ. Que changes-tu en premier ?','Ma routine quotidienne','Les personnes autour de moi','Mon lieu de vie ou de travail','L’objectif que je poursuis']},
  'inspiration': {'ar':['الأحلام','أين تأتيك أفضل أفكارك عادة؟','أثناء المشي في الخارج','في وقت متأخر من الليل','خلال الأحاديث','عندما أشعر بالملل'],'fr':['RÊVES','Où te viennent tes meilleures idées ?','En marchant dehors','Tard dans la nuit','Pendant une conversation','Quand je m’ennuie']},
  'proudmoment': {'ar':['الذكريات','أي إنجاز صغير يجعلك فخوراً بنفسك؟','الوفاء بوعد قطعته لنفسي','مساعدة شخص دون أن يطلب','إنهاء شيء صعب','المحاولة رغم الخوف'],'fr':['SOUVENIRS','Quelle petite victoire te rendrait discrètement fier ?','Tenir une promesse envers moi-même','Aider sans qu’on me le demande','Terminer quelque chose de difficile','Essayer malgré la peur']},
  'learning': {'ar':['الفضول','ظهر أمامك درس مجاني. أي عنوان يجذبك؟','كيف يعمل الكون','كيف نفهم الناس','كيف نصنع شيئاً من الصفر','كيف نحل لغزاً غريباً'],'fr':['CURIOSITÉ','Un cours gratuit apparaît. Quel titre te donne envie de cliquer ?','Comment fonctionne l’univers','Comment comprendre les gens','Comment créer quelque chose','Comment résoudre un mystère']},
  'timeportal': {'ar':['الخيال','فُتحت بوابة زمنية لمدة ساعة. إلى أين تذهب؟','يوم من مستقبلي','لحظة مشهورة في التاريخ','عالم لم يعد موجوداً','يوم من طفولتي'],'fr':['IMAGINATION','Un portail temporel s’ouvre pendant une heure. Où vas-tu ?','Un jour de mon futur','Un moment célèbre de l’histoire','Un monde disparu','Un jour de mon enfance']},
  'alien': {'ar':['الفضول','سألك كائن فضائي: ما أفضل ما يجيده البشر؟ ماذا تقول؟','ابتكار القصص','بناء العلاقات','إيجاد حلول ذكية','تحويل الأخطاء إلى نكات'],'fr':['CURIOSITÉ','Un extraterrestre demande ce que les humains savent faire de mieux. Tu réponds…','Créer des histoires','Créer des liens','Trouver des solutions ingénieuses','Transformer les erreurs en blagues']},
  'detective': {'ar':['الغموض','ظهرت أمامك قضية غامضة مع ثلاثة أدلة. ما أول خطوة؟','أربط الأدلة فوراً','أستجوب كل المعنيين','أبحث عن التفصيل الذي لم يلاحظه أحد','أضع نظرية غريبة وأختبرها'],'fr':['MYSTÈRE','Une énigme arrive avec trois indices. Ta première action ?','Relier les indices immédiatement','Interroger les personnes concernées','Chercher le détail oublié','Créer une théorie folle et la tester']},
  'impossible': {'ar':['الجرأة','عُرضت عليك قدرة مستحيلة لمدة 24 ساعة. ماذا تختار؟','فهم كل اللغات','زيارة أي مكان فوراً','بناء كل ما أتخيله','رؤية كيف قد يتطور قرار ما'],'fr':['AUDACE','On t’offre un pouvoir impossible pendant 24 heures. Lequel ?','Comprendre toutes les langues','Aller partout instantanément','Construire tout ce que j’imagine','Voir comment une décision pourrait évoluer']},
  'gameworld': {'ar':['الألعاب','دخلت عالماً داخل لعبة مع أصدقائك. ما دورك؟','المخطط الاستراتيجي','المستكشف','المعالج والمساعد','الشخص غير المتوقع'],'fr':['JEUX','Tu entres dans un monde de jeu avec tes amis. Ton rôle ?','Le stratège','L’explorateur','Le soigneur et l’entraide','L’imprévisible']},
  'treasure': {'ar':['المغامرة','وجدت خريطة لكنز مخفي. ما الأهم بالنسبة إليك؟','المغامرة في الطريق','من سيرافقني','ما قد يكون عليه الكنز','القصة التي سأحكيها لاحقاً'],'fr':['AVENTURE','Tu trouves une carte au trésor. Qu’est-ce qui compte le plus ?','L’aventure du voyage','Qui m’accompagne','Ce que le trésor pourrait être','L’histoire à raconter après']},
  'conflictrepair': {'ar':['التواصل','بعد خلاف، ما الذي يساعدك على استعادة العلاقة؟','اعتذار صادق','حوار هادئ','بعض الوقت ثم الاطمئنان','فعل لطيف نقوم به معاً'],'fr':['LIEN','Après un désaccord, qu’est-ce qui aide à renouer ?','Des excuses sincères','Une conversation calme','Un peu de temps puis reprendre contact','Faire quelque chose de gentil ensemble']},
  'boundaries': {'ar':['الذات','طلب منك صديق خدمة وأسبوعك مزدحم. ماذا تفعل؟','أوافق وأعيد ترتيب كل شيء','أشرح بصراحة أنني لا أستطيع','أعرض مساعدة أصغر','آخذ وقتاً قبل الرد'],'fr':['SOI','Un ami demande un service alors que ta semaine est pleine. Tu…','Acceptes et réorganises tout','Expliques honnêtement que tu ne peux pas','Proposes une aide plus limitée','Prends le temps de répondre']},
  'supportstyle': {'ar':['الصداقة','عندما تشعر بالضغط، أي دعم يناسبك أكثر؟','شخص يستمع دون حكم','شخص يساعدني في وضع خطة','شخص يلهيني بالمرح','مساحة صغيرة ثم سؤال عن حالي'],'fr':['AMITIÉ','Quand tu es stressé, quel soutien te convient le mieux ?','Quelqu’un qui écoute sans juger','Quelqu’un qui aide à faire un plan','Quelqu’un qui me change les idées','Un peu d’espace puis prendre des nouvelles']},
  'appreciation': {'ar':['التواصل','أي تصرف يجعلك تشعر بالتقدير أكثر؟','رسالة مليئة بالاهتمام','شخص يخصص لي وقتاً','تذكر تفصيل صغير عني','مساعدة دون أن أطلب'],'fr':['LIEN','Quel geste te fait te sentir le plus apprécié ?','Un message attentionné','Quelqu’un qui prend du temps pour moi','Se souvenir d’un petit détail','Aider sans que je demande']},
  'trustbuild': {'ar':['الثقة','ما الذي يبني الثقة بسرعة بين شخصين؟','الثبات مع مرور الوقت','الصدق عندما يكون صعباً','احترام الخصوصية','الحضور وقت الحاجة'],'fr':['CONFIANCE','Qu’est-ce qui construit le plus vite la confiance ?','La constance avec le temps','L’honnêteté même difficile','Le respect de la vie privée','Être présent quand il le faut']},
  'forgiveness': {'ar':['المشاعر','شخص نادم بصدق لأنه جرحك. ما الذي تحتاجه أولاً؟','وقتاً لاستيعاب الأمر','تفسيراً واضحاً','أفعالاً تثبت التغيير','حواراً مباشراً'],'fr':['ÉMOTIONS','Quelqu’un regrette sincèrement de t’avoir blessé. De quoi as-tu besoin d’abord ?','De temps pour digérer','D’une explication claire','D’actes qui prouvent le changement','D’une conversation directe']},
  'celebration': {'ar':['الصداقة','حقق صديقك إنجازاً كبيراً. كيف تحتفل معه؟','أخطط لمفاجأة','أكتب له رسالة صادقة','نخرج ونصنع ذكرى','أخبر الجميع كم أنا فخور به'],'fr':['AMITIÉ','Ton ami accomplit quelque chose d’énorme. Comment fêtes-tu ça ?','Je prépare une surprise','J’écris un message sincère','On sort créer un souvenir','Je dis à tout le monde combien je suis fier']},
};

import 'package:flutter/widgets.dart';

class AppStrings {
  AppStrings._(this.languageCode);
  final String languageCode;
  static AppStrings of(BuildContext context) => AppStrings._(Localizations.localeOf(context).languageCode);

  static const _values = <String, Map<String, String>>{
    'brandTag': {'en':'THE SOCIAL MIND GAME','ar':'لعبة العقول الاجتماعية','fr':'LE JEU DES ESPRITS'},
    'quickQs': {'en':'28 QUICK QUESTIONS','ar':'٢٨ سؤالاً سريعاً','fr':'28 QUESTIONS'},
    'eyebrow': {'en':'✦  ONE GAME. TWO MINDS.  ✦','ar':'✦  لعبة واحدة، عقلان  ✦','fr':'✦  UN JEU. DEUX ESPRITS.  ✦'},
    'heroTitle': {'en':'SAME BRAIN?\nLET’S FIND OUT.','ar':'هل نفكر بنفس الطريقة؟\nلنكتشف ذلك!','fr':'LE MÊME CERVEAU ?\nVÉRIFIONS !'},
    'heroBody': {'en':'Your choices say more than you think. Answer unexpected questions, challenge your people, and see where your minds meet.','ar':'اختياراتك تكشف أكثر مما تتوقع. أجب عن أسئلة ممتعة، وتحدَّ أصدقاءك واكتشف مدى تشابه عقولكم.','fr':'Tes choix en disent long. Réponds à des questions surprenantes, défie tes proches et découvre vos points communs.'},
    'start': {'en':'START YOUR MINDMATCH','ar':'ابدأ اختبار تطابق العقول','fr':'LANCER MINDMATCH'},
    'already': {'en':'ALREADY HAVE A CHALLENGE?','ar':'لديك رمز تحدٍ بالفعل؟','fr':'TU AS DÉJÀ UN DÉFI ?'},
    'join': {'en':'JOIN A FRIEND','ar':'انضم إلى صديق','fr':'REJOINDRE UN AMI'},
    'paste': {'en':'Paste their code and take the same test.','ar':'أدخل رمز صديقك وأجب عن الاختبار نفسه.','fr':'Colle son code et réponds au même quiz.'},
    'codeHint': {'en':'MM1-XXXX-XXXX','ar':'MM1-XXXX-XXXX','fr':'MM1-XXXX-XXXX'},
    'enter': {'en':'ENTER THE MATCH','ar':'ابدأ التحدي','fr':'REJOINDRE LE DÉFI'},
    'privacy': {'en':'NO ACCOUNT  ·  NO PRESSURE  ·  JUST VIBES','ar':'بلا حساب · بلا ضغط · فقط متعة','fr':'SANS COMPTE · SANS PRESSION · JUSTE DU FUN'},
    'dailyLabel': {'en':'TODAY’S MIND QUEST','ar':'تحدي العقول اليومي','fr':'DÉFI DU JOUR'},
    'dailyFresh': {'en':'FRESH EVERY DAY','ar':'يتجدد يومياً','fr':'NOUVEAU CHAQUE JOUR'},
    'dailyTitle': {'en':'One day. One new mind challenge.','ar':'يوم جديد، وتحدٍ جديد للعقول.','fr':'Un jour. Un nouveau défi mental.'},
    'dailyDesc': {'en':'A rotating set of 14 questions. Challenge a friend with the same code and compare your minds.','ar':'١٤ سؤالاً تتغير يومياً. أرسل رمزك لصديق واكتشف مدى تطابق عقولكما.','fr':'14 questions qui changent chaque jour. Défie un ami avec le même code et comparez vos esprits.'},
    'playDaily': {'en':'PLAY TODAY’S CHALLENGE','ar':'ابدأ تحدي اليوم','fr':'JOUER AU DÉFI DU JOUR'},
    'packsTitle': {'en':'PICK YOUR VIBE','ar':'اختر نوع التحدي','fr':'CHOISIS TON AMBIANCE'},
    'packsDesc': {'en':'Short themed quizzes made for friend challenges.','ar':'اختبارات قصيرة بمواضيع مختلفة لتحدي أصدقائك.','fr':'Des quiz thématiques courts pour défier tes amis.'},
    'packFriendship': {'en':'Friendship Decoder','ar':'كاشف الصداقة','fr':'Décodeur d’amitié'},
    'packFriendshipDesc': {'en':'Trust, loyalty and the little things.','ar':'الثقة والوفاء والتفاصيل الصغيرة.','fr':'Confiance, loyauté et petits détails.'},
    'packDeep': {'en':'Deep Talk','ar':'أحاديث عميقة','fr':'Conversations profondes'},
    'packDeepDesc': {'en':'Dreams, fears and what makes you tick.','ar':'الأحلام والمخاوف وما يحركك من الداخل.','fr':'Rêves, peurs et ce qui te fait vibrer.'},
    'packChaos': {'en':'Chaos & Curiosity','ar':'الفوضى والفضول','fr':'Chaos et curiosité'},
    'packChaosDesc': {'en':'Wild choices and unexpected situations.','ar':'اختيارات جريئة ومواقف غير متوقعة.','fr':'Choix fous et situations inattendues.'},
    'packSocial': {'en':'Social Energy','ar':'الطاقة الاجتماعية','fr':'Énergie sociale'},
    'packSocialDesc': {'en':'People, pressure and group dynamics.','ar':'الناس والمواقف وديناميكية المجموعات.','fr':'Les gens, la pression et la dynamique de groupe.'},
    'questionsShort': {'en':'questions','ar':'أسئلة','fr':'questions'},
    'mindLab': {'en':'MIND LAB','ar':'مختبر العقول','fr':'LABO DES ESPRITS'},
    'firstInstinct': {'en':'Go with your first instinct. There are no wrong answers.','ar':'اختر ما يخطر ببالك أولاً. لا توجد إجابة خاطئة.','fr':'Suis ton instinct. Il n’y a pas de mauvaise réponse.'},
    'reveal': {'en':'REVEAL MY MATCH','ar':'اكشف نتيجة التطابق','fr':'RÉVÉLER LE RÉSULTAT'},
    'continue': {'en':'LOCK IT IN & CONTINUE','ar':'تأكيد ومتابعة','fr':'VALIDER ET CONTINUER'},
    'report': {'en':'THE MIND REPORT','ar':'تقرير العقول','fr':'RAPPORT DES ESPRITS'},
    'yourMind': {'en':'YOUR MIND\nIS UNLOCKED','ar':'لقد أطلقت\nعنان عقلك!','fr':'TON ESPRIT\nEST LIBÉRÉ'},
    'firstHalf': {'en':'THE FIRST HALF OF THE MATCH','ar':'النصف الأول من التحدي','fr':'LA PREMIÈRE MOITIÉ DU DÉFI'},
    'invite': {'en':'YOUR INVITE CODE','ar':'رمز الدعوة الخاص بك','fr':'TON CODE D’INVITATION'},
    'copyCode': {'en':'COPY MY CHALLENGE','ar':'انسخ رمز التحدي','fr':'COPIER MON DÉFI'},
    'copied': {'en':'CODE COPIED — SEND IT!','ar':'تم نسخ الرمز — أرسله!','fr':'CODE COPIÉ — ENVOIE-LE !'},
    'howTo': {'en':'Your friend opens MINDMATCH, enters this code, and answers the same questions. Your match score appears when they finish.','ar':'يفتح صديقك MINDMATCH، ويدخل الرمز، ثم يجيب عن الأسئلة نفسها. ستظهر نتيجة التطابق بعد الانتهاء.','fr':'Ton ami ouvre MINDMATCH, saisit ce code et répond aux mêmes questions. Votre score apparaît à la fin.'},
    'where': {'en':'WHERE YOUR MINDS MET','ar':'أين تلاقت عقولكما؟','fr':'VOS POINTS COMMUNS'},
    'match': {'en':'MATCH','ar':'تطابق','fr':'PAREIL'},
    'different': {'en':'DIFFERENT','ar':'مختلف','fr':'DIFFÉRENT'},
    'shareChallenge': {'en':'SHARE MY CHALLENGE','ar':'شارك التحدي','fr':'PARTAGER MON DÉFI'},
    'shareScore': {'en':'SHARE MY MATCH SCORE','ar':'شارك نتيجة التطابق','fr':'PARTAGER MON SCORE'},
    'showQr': {'en':'SHOW CHALLENGE QR','ar':'اعرض رمز QR للتحدي','fr':'AFFICHER LE QR DU DÉFI'},
    'qrTitle': {'en':'LET THEM SCAN YOUR CHALLENGE','ar':'دع صديقك يمسح رمز التحدي','fr':'FAIS SCANNER TON DÉFI'},
    'back': {'en':'BACK TO MIND LAB','ar':'العودة إلى مختبر العقول','fr':'RETOUR AU LABO'},
    'copiedToast': {'en':'Challenge code copied. Send it to your friend!','ar':'تم نسخ رمز التحدي. أرسله إلى صديقك!','fr':'Code copié. Envoie-le à ton ami !'},
    'sharedToast': {'en':'Your result is ready to share!','ar':'نتيجتك جاهزة للمشاركة!','fr':'Ton résultat est prêt à être partagé !'},
    'scoreShare': {'en':'We got {score}% MINDMATCH! 🧠✨ Can your mind match mine?','ar':'حققنا تطابقاً بنسبة {score}% في MINDMATCH! 🧠✨ هل يستطيع عقلك مجاراة عقلي؟','fr':'Nous avons {score}% sur MINDMATCH ! 🧠✨ Ton esprit peut-il rivaliser avec le mien ?'},
    'perfect': {'en':'MIND TWINS','ar':'توأم العقول','fr':'JUMEAUX D’ESPRIT'},
    'high': {'en':'SYNCHRONIZED','ar':'متناغمان','fr':'SYNCHRONISÉS'},
    'mid': {'en':'SAME WAVELENGTH','ar':'على نفس الموجة','fr':'SUR LA MÊME LONGUEUR D’ONDE'},
    'low': {'en':'BEAUTIFULLY DIFFERENT','ar':'اختلاف جميل','fr':'DIFFÉRENTS, ET C’EST BEAU'},
    'firstDescription': {'en':'You made the first move. Send your challenge code and see who thinks on your wavelength.','ar':'لقد بدأت التحدي! أرسل الرمز واكتشف من يفكر مثلك.','fr':'Tu as lancé le défi ! Envoie ton code et découvre qui pense comme toi.'},
    'sameDescription': {'en':'You two share one seriously synchronized brain.','ar':'عقلان متناغمان بشكل مذهل!','fr':'Vos deux esprits sont incroyablement synchronisés.'},
    'diffDescription': {'en':'Different minds make the best conversations.','ar':'اختلاف العقول يصنع أجمل الحوارات.','fr':'Les esprits différents créent les meilleures conversations.'},
  };

  String t(String key) {
    final entry = _values[key];
    return entry?[languageCode] ?? entry?['en'] ?? key;
  }
  String scoreShare(int score) => t('scoreShare').replaceAll('{score}', '$score');
  String get verdictPerfect => t('perfect');
  String verdict(int score) => t(score == 100 ? 'perfect' : score >= 70 ? 'high' : score >= 40 ? 'mid' : 'low');
}

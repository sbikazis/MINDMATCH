class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.category,
  });

  final String id;
  final String prompt;
  final List<String> options;
  final String category;
}

const mindMatchQuestions = <QuizQuestion>[
  QuizQuestion(
    id: 'midnight',
    category: 'INSTINCT',
    prompt: 'You get a free ticket to anywhere. When do you leave?',
    options: ['Right now', 'Tomorrow morning', 'After a little planning', 'I need to know who is coming'],
  ),
  QuizQuestion(
    id: 'mystery',
    category: 'CURIOSITY',
    prompt: 'A mysterious door appears in your room. What do you do?',
    options: ['Open it immediately', 'Look for clues first', 'Ask someone to come with me', 'Pretend I did not see it'],
  ),
  QuizQuestion(
    id: 'power',
    category: 'IMAGINATION',
    prompt: 'Choose one unusual superpower.',
    options: ['Pause time', 'Read animal thoughts', 'Teleport anywhere', 'Replay one memory'],
  ),
  QuizQuestion(
    id: 'weekend',
    category: 'VIBE',
    prompt: 'Your perfect unexpected free day looks like…',
    options: ['A spontaneous adventure', 'A cozy day at home', 'Meeting my favorite people', 'Trying something completely new'],
  ),
  QuizQuestion(
    id: 'truth',
    category: 'INSTINCT',
    prompt: 'Your friend asks for an honest opinion. You…',
    options: ['Say exactly what I think', 'Find the kindest way to say it', 'Ask if they really want the truth', 'Wait until the right moment'],
  ),
  QuizQuestion(
    id: 'time',
    category: 'IMAGINATION',
    prompt: 'Which place would you explore first?',
    options: ['The deep ocean', 'Outer space', 'An ancient lost city', 'A future version of Earth'],
  ),
  QuizQuestion(
    id: 'choice',
    category: 'VIBE',
    prompt: 'Pick the message that feels most like you.',
    options: ['Let us do it!', 'I have a plan.', 'This is going to be interesting.', 'Tell me everything.'],
  ),
];

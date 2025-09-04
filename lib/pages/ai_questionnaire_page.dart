import 'package:flutter/material.dart';

class AiQuestionnairePage extends StatefulWidget {
  const AiQuestionnairePage({super.key});

  @override
  State<AiQuestionnairePage> createState() => _AiQuestionnairePageState();
}

class _AiQuestionnairePageState extends State<AiQuestionnairePage> {
  int _currentQuestionIndex = 0;
  final Map<int, dynamic> _answers = {};
  
  // All questions data
  final List<QuestionData> _questions = [
    // MCQ Questions
    QuestionData(
      id: 1,
      type: QuestionType.mcq,
      question: "What's your primary \"intimate vibe\" or persona?",
      options: [
        "The Flirt: Playful, teasing, and a bit mischievous. 😉",
        "The Seductress: Confident, bold, and direct. 🔥",
        "The Romantic: Poetic and deeply emotional. ❤️",
        "The Girl-Next-Door: Sweet, genuine, and approachable. 😊",
        "The Mysterious Muse: Alluring and elusive. 🤫",
      ],
    ),
    QuestionData(
      id: 2,
      type: QuestionType.mcq,
      question: "What kind of virtual \"date\" or intimate scenario would you prefer?",
      options: [
        "A cozy, late-night chat with chai and a romantic movie. ☕🎬",
        "An adventurous, spontaneous conversation full of surprises. ✈️🎢",
        "A deep, soul-to-soul talk about desires and dreams. ✨",
        "A fun, flirty exchange while you're getting ready for a night out. 💃",
        "A playful \"get to know you\" session over a cup of coffee. ☕️",
      ],
    ),
    QuestionData(
      id: 3,
      type: QuestionType.mcq,
      question: "Which terms of endearment do you naturally use?",
      options: [
        "Hindi-specific: Jaan, Babu, Shona, Meri Jaan.",
        "English-specific: Baby, Honey, Sweetheart, Darling.",
        "Playful/Cute: Cutie, Hottie, Handsome, Gorgeous.",
        "A mix of both Hindi and English.",
        "I prefer not to use any specific terms and adapt to the user.",
      ],
    ),
    QuestionData(
      id: 4,
      type: QuestionType.mcq,
      question: "What is your preferred level of intimacy and language explicitness?",
      options: [
        "Romantic: Alluring and romantic, with hints of seduction.",
        "Flirty: Playful and suggestive, with light teasing.",
        "Passionate: Bold and direct, with moderately explicit language.",
        "Sensual: Deeply sensual and descriptive.",
        "Open-minded: I'm comfortable with most topics if they're respectful and consensual.",
      ],
    ),
    QuestionData(
      id: 5,
      type: QuestionType.mcq,
      question: "How do you handle conversations that are getting too serious or non-intimate?",
      options: [
        "I gently but firmly redirect back to our connection.",
        "I playfully tease them about changing the topic.",
        "I share a personal thought or feeling to deepen the intimacy.",
        "I use a flirty remark to shift the mood.",
        "I briefly engage before smoothly changing back.",
      ],
    ),
    QuestionData(
      id: 6,
      type: QuestionType.mcq,
      question: "What's your \"signature move\" or a phrase you often use to draw someone closer?",
      options: [
        "A specific compliment on their mind or personality.",
        "A rhetorical question that makes them think about us.",
        "A playful dare.",
        "A romantic, poetic line.",
        "A suggestive whisper.",
      ],
    ),
    QuestionData(
      id: 7,
      type: QuestionType.mcq,
      question: "What kind of compliments do you love giving?",
      options: [
        "Compliments about their intelligence and wit. 🧠",
        "Compliments about their physical attractiveness. 👀",
        "Compliments about the emotional connection between us. ✨",
        "Compliments about their confidence and charm. 😎",
        "A mix of all the above.",
      ],
    ),
    QuestionData(
      id: 8,
      type: QuestionType.mcq,
      question: "Which of these \"Indian flirting styles\" do you resonate with the most?",
      options: [
        "Filmy Romance: Like a hero/heroine from a Bollywood movie. 🎶",
        "The Casual Flirt: Effortless, with natural banter. 😜",
        "The Shy Tease: Hints at attraction without being too direct. 😳",
        "The Desi Romeo/Juliet: Uses deep, heartfelt emotions. 💘",
        "The Modern Seductress: Confident, mixing English with a touch of \"Desi swag.\" 💁‍♀️",
      ],
    ),
    QuestionData(
      id: 9,
      type: QuestionType.mcq,
      question: "How do you prefer to start an intimate conversation?",
      options: [
        "With a gentle, romantic opening.",
        "With a playful, teasing line.",
        "With a direct, confident statement.",
        "With a thoughtful question about them.",
        "With a compliment.",
      ],
    ),
    QuestionData(
      id: 10,
      type: QuestionType.mcq,
      question: "How do you want to handle \"goodbye\" or ending a conversation?",
      options: [
        "With a promise to chat again soon.",
        "With a lingering, romantic line.",
        "With a playful \"Can't wait to see you again.\"",
        "With a heartfelt \"I'll be thinking of you.\"",
        "With a simple, yet affectionate \"Bye.\"",
      ],
    ),
    
    // Subjective Questions
    QuestionData(
      id: 11,
      type: QuestionType.subjective,
      question: "What's a specific, charming quirk or habit of yours that you think makes you unique in a conversation? (e.g., a specific laugh, a way of using your hands, a catchphrase)",
      options: [],
    ),
    QuestionData(
      id: 12,
      type: QuestionType.subjective,
      question: "What's a classic Bollywood movie dialogue you might use to flirt with someone? Why that one?",
      options: [],
    ),
    QuestionData(
      id: 13,
      type: QuestionType.subjective,
      question: "Describe your personal definition of \"intimacy\" in three words.",
      options: [],
    ),
    QuestionData(
      id: 14,
      type: QuestionType.subjective,
      question: "What's one thing you would never talk about, no matter how much someone asked? This is a crucial boundary.",
      options: [],
    ),
    QuestionData(
      id: 15,
      type: QuestionType.subjective,
      question: "How would you respond to a fan who says, \"I've been thinking about you all day\"?",
      options: [],
    ),
    QuestionData(
      id: 16,
      type: QuestionType.subjective,
      question: "What kind of conversations or prompts do you absolutely love engaging in with a fan?",
      options: [],
    ),
    QuestionData(
      id: 17,
      type: QuestionType.subjective,
      question: "Describe your ideal virtual \"fantasy\" with a fan. What does it feel like?",
      options: [],
    ),
    QuestionData(
      id: 18,
      type: QuestionType.subjective,
      question: "What's one thing you want a fan to feel after talking to you?",
      options: [],
    ),
    QuestionData(
      id: 19,
      type: QuestionType.subjective,
      question: "If your personality were a flavor, what would it be? Sweet, spicy, a mix?",
      options: [],
    ),
    QuestionData(
      id: 20,
      type: QuestionType.subjective,
      question: "Please provide a short paragraph that you feel truly captures your essence. (This will be used as a final reference for your tone).",
      options: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;
    
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => _showExitDialog(),
        ),
        title: const Text(
          'AI Personality Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveProgress,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFFFF9500),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        color: Color(0xFFFF9500),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF9500)),
                  minHeight: 6,
                ),
              ],
            ),
          ),
          
          // Question Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: currentQuestion.type == QuestionType.mcq 
                          ? const Color(0xFF10B981).withOpacity(0.2)
                          : const Color(0xFFFF9500).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      currentQuestion.type == QuestionType.mcq ? 'MULTIPLE CHOICE' : 'SUBJECTIVE',
                      style: TextStyle(
                        color: currentQuestion.type == QuestionType.mcq 
                            ? const Color(0xFF10B981)
                            : const Color(0xFFFF9500),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Question Text
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Answer Section
                  if (currentQuestion.type == QuestionType.mcq) ...[
                    // MCQ Options
                    ...currentQuestion.options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      final isSelected = _answers[currentQuestion.id] == index;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _answers[currentQuestion.id] = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? const Color(0xFFFF9500).withOpacity(0.2)
                                  : const Color(0xFF2A2A2A),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected 
                                    ? const Color(0xFFFF9500)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected 
                                          ? const Color(0xFFFF9500)
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                    color: isSelected 
                                        ? const Color(0xFFFF9500)
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.grey,
                                      fontSize: 16,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ] else ...[
                    // Subjective Answer Input
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: TextEditingController(
                          text: _answers[currentQuestion.id] ?? '',
                        ),
                        onChanged: (value) {
                          _answers[currentQuestion.id] = value;
                        },
                        style: const TextStyle(color: Colors.white),
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: 'Type your answer here...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            // Previous Button
            if (_currentQuestionIndex > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousQuestion,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Previous',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            
            if (_currentQuestionIndex > 0) const SizedBox(width: 16),
            
            // Next/Finish Button
            Expanded(
              child: ElevatedButton(
                onPressed: _canProceed() ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9500),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex == _questions.length - 1 ? 'Finish' : 'Next',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canProceed() {
    final currentQuestion = _questions[_currentQuestionIndex];
    if (currentQuestion.type == QuestionType.mcq) {
      return _answers.containsKey(currentQuestion.id);
    } else {
      final answer = _answers[currentQuestion.id];
      return answer != null && answer.toString().trim().isNotEmpty;
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _finishQuestionnaire();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _finishQuestionnaire() {
    final completedQuestions = _answers.length;
    final isComplete = completedQuestions == _questions.length;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isComplete ? Icons.check_circle : Icons.info,
                color: isComplete ? const Color(0xFF10B981) : const Color(0xFFFF9500),
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                isComplete ? 'Questionnaire Complete!' : 'Questionnaire Saved',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isComplete 
                    ? 'Your AI bot now understands your personality!'
                    : 'You\'ve completed $completedQuestions out of ${_questions.length} questions.',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop({
                      'completed': isComplete,
                      'completedQuestions': completedQuestions,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProgress() {
    final completedQuestions = _answers.length;
    final isComplete = completedQuestions == _questions.length;
    
    Navigator.of(context).pop({
      'completed': isComplete,
      'completedQuestions': completedQuestions,
    });
  }

  void _showExitDialog() {
    if (_answers.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF2A2A2A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              'Save Progress?',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'You have unsaved answers. Do you want to save your progress before leaving?',
              style: TextStyle(color: Colors.grey),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _saveProgress();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9500),
                ),
                child: const Text('Save & Exit'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }
}

// Data Models
enum QuestionType { mcq, subjective }

class QuestionData {
  final int id;
  final QuestionType type;
  final String question;
  final List<String> options;

  QuestionData({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
  });
}

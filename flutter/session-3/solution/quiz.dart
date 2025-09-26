import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;

  final List<Map<String, Object>> questions = [
    {
      'questionText': 'What is the main building block of a Flutter UI?',
      'answers': [
        {'text': 'Functions', 'score': 0},
        {'text': 'Widgets', 'score': 10},
        {'text': 'Classes', 'score': 0},
      ],
    },
    {
      'questionText':
          'Which method do you call to trigger a UI rebuild in a StatefulWidget?',
      'answers': [
        {'text': 'rebuild()', 'score': 0},
        {'text': 'refresh()', 'score': 0},
        {'text': 'setState()', 'score': 10},
      ],
    },
    {
      'questionText':
          'What programming language is Flutter primarily written in?',
      'answers': [
        {'text': 'Java', 'score': 0},
        {'text': 'Dart', 'score': 10},
        {'text': 'JavaScript', 'score': 0},
        {'text': 'Python', 'score': 0},
      ],
    },
    {
      'questionText': 'Which company developed Flutter?',
      'answers': [
        {'text': 'Facebook', 'score': 0},
        {'text': 'Apple', 'score': 0},
        {'text': 'Google', 'score': 10},
        {'text': 'Microsoft', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  Widget _buildQuestion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            children: [
              Text(
                'Question ${_questionIndex + 1} of ${questions.length}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                questions[_questionIndex]['questionText'] as String,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ...(questions[_questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(answer['score'] as int),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    answer['text'] as String,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            })
            .toList(),
      ],
    );
  }

  Widget _buildResults() {
    String resultMessage;
    Color resultColor;
    IconData resultIcon;

    double percentage = (_totalScore / (questions.length * 10)) * 100;

    if (percentage >= 80) {
      resultMessage = 'Excellent! 🎉';
      resultColor = Colors.green;
      resultIcon = Icons.emoji_events;
    } else if (percentage >= 60) {
      resultMessage = 'Good job! 👍';
      resultColor = Colors.orange;
      resultIcon = Icons.thumb_up;
    } else {
      resultMessage = 'Keep practicing! 📚';
      resultColor = Colors.red;
      resultIcon = Icons.school;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(resultIcon, size: 100, color: resultColor),
          const SizedBox(height: 30),
          const Text(
            'Quiz Complete!',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            resultMessage,
            style: TextStyle(
              fontSize: 24,
              color: resultColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: resultColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: resultColor.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'Your Score',
                  style: TextStyle(
                    fontSize: 18,
                    color: resultColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$_totalScore / ${questions.length * 10}',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                ),
                Text(
                  '${percentage.round()}%',
                  style: TextStyle(
                    fontSize: 20,
                    color: resultColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _resetQuiz,
            icon: const Icon(Icons.refresh),
            label: const Text('Take Quiz Again'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body:
          _questionIndex < questions.length
              ? _buildQuestion()
              : _buildResults(),
    );
  }
}

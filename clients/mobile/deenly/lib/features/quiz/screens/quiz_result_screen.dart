// lib/screens/quiz_result_screen.dart
import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import 'home_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final List<Map<String, dynamic>> answers;

  const QuizResultScreen({
    Key? key,
    required this.questions,
    required this.answers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate quiz statistics
    final totalQuestions = questions.length;
    final correctAnswers = answers.where((a) => a['isCorrect']).length;
    final accuracy = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$correctAnswers / $totalQuestions',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${accuracy.toStringAsFixed(1)}% Accuracy',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Question Review',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (ctx, i) {
                  final question = questions[i];
                  final answer = answers[i];
                  final isCorrect = answer['isCorrect'];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: isCorrect ? Colors.green[50] : Colors.red[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isCorrect ? Icons.check_circle : Icons.cancel,
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  question.question,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Correct Answer: Surah ${question.surahNumber}:${question.verseNumber}',
                            style: TextStyle(
                              color: isCorrect
                                  ? Colors.green[800]
                                  : Colors.grey[800],
                            ),
                          ),
                          if (!isCorrect)
                            Text(
                              'Your Answer: Surah ${answer['userSurah']}:${answer['userVerse']}',
                              style: TextStyle(
                                color: Colors.red[800],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Return to Home',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

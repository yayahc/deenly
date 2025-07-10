// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quiz_model.dart';
import '../provider/quiz_provider.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<QuizQuestion> _quizQuestions = [];
  final List<Map<String, dynamic>> _userAnswers = [];
  final _surahController = TextEditingController();
  final _verseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final int _totalQuestions = 10; // Set number of questions to 10

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      // Get shuffled list of questions for the quiz
      final allQuestions = [...quizProvider.questions];
      allQuestions.shuffle();

      // Take only the first 10 questions (or all if less than 10 available)
      final selectedQuestions = allQuestions.length > _totalQuestions
          ? allQuestions.sublist(0, _totalQuestions)
          : allQuestions;

      setState(() {
        _quizQuestions.addAll(selectedQuestions);
      });
    });
  }

  @override
  void dispose() {
    _surahController.dispose();
    _verseController.dispose();
    super.dispose();
  }

  void _submitAnswer() {
    if (_formKey.currentState!.validate()) {
      final currentQuestion = _quizQuestions[_currentQuestionIndex];

      // Check if the answer is correct
      final isCorrect = _surahController.text == currentQuestion.surahNumber &&
          _verseController.text == currentQuestion.verseNumber;

      // Record the user's answer
      _userAnswers.add({
        'questionId': currentQuestion.id,
        'userSurah': _surahController.text,
        'userVerse': _verseController.text,
        'isCorrect': isCorrect,
      });

      // Record the attempt in the provider
      Provider.of<QuizProvider>(context, listen: false).recordAttempt(
        currentQuestion.id,
        "${_surahController.text}:${_verseController.text}",
        isCorrect,
      );

      // Clear the input fields
      _surahController.clear();
      _verseController.clear();

      // Move to the next question or finish the quiz
      if (_currentQuestionIndex < _quizQuestions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
      } else {
        // Navigate to results screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => QuizResultScreen(
              questions: _quizQuestions,
              answers: _userAnswers,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_quizQuestions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentQuestion = _quizQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_quizQuestions.length}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentQuestion.question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (currentQuestion.notes != null &&
                        currentQuestion.notes!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Note: ${currentQuestion.notes}',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _surahController,
                          decoration: const InputDecoration(
                            labelText: 'Surah Number',
                            hintText: 'e.g., 2',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter surah number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _verseController,
                          decoration: const InputDecoration(
                            labelText: 'Verse Number',
                            hintText: 'e.g., 50',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter verse number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitAnswer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Submit Answer',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/providers/quiz_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/quiz_model.dart';

class QuizProvider with ChangeNotifier {
  List<QuizQuestion> _questions = [];
  List<QuizAttempt> _attempts = [];
  final _uuid = const Uuid();

  List<QuizQuestion> get questions => [..._questions];
  List<QuizAttempt> get attempts => [..._attempts];

  // Get questions filtered by most recent
  List<QuizQuestion> get recentQuestions {
    final sorted = [..._questions];
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  // Calculate statistics for performance tracking
  Map<String, dynamic> getStats() {
    if (_attempts.isEmpty) {
      return {
        'totalAttempts': 0,
        'correctAnswers': 0,
        'accuracy': 0.0,
      };
    }

    final totalAttempts = _attempts.length;
    final correctAnswers =
        _attempts.where((attempt) => attempt.isCorrect).length;
    final accuracy = (correctAnswers / totalAttempts) * 100;

    return {
      'totalAttempts': totalAttempts,
      'correctAnswers': correctAnswers,
      'accuracy': accuracy,
    };
  }

  // Add a new question
  Future<void> addQuestion(
      String question, String surahNumber, String verseNumber,
      {String? notes}) async {
    final newQuestion = QuizQuestion(
      id: _uuid.v4(),
      question: question,
      surahNumber: surahNumber,
      verseNumber: verseNumber,
      notes: notes,
      createdAt: DateTime.now(),
    );

    _questions.add(newQuestion);
    notifyListeners();
    await _saveQuestions();
  }

  // Record a quiz attempt
  Future<void> recordAttempt(
      String questionId, String userAnswer, bool isCorrect) async {
    final attempt = QuizAttempt(
      id: _uuid.v4(),
      questionId: questionId,
      userAnswer: userAnswer,
      isCorrect: isCorrect,
      attemptDate: DateTime.now(),
    );

    _attempts.add(attempt);
    notifyListeners();
    await _saveAttempts();
  }

  // Delete a question
  Future<void> deleteQuestion(String id) async {
    _questions.removeWhere((question) => question.id == id);
    notifyListeners();
    await _saveQuestions();
  }

  // Load data from local storage
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final questionsJson = prefs.getString('questions');
    if (questionsJson != null) {
      final List<dynamic> decodedQuestions = json.decode(questionsJson);
      _questions =
          decodedQuestions.map((item) => QuizQuestion.fromJson(item)).toList();
    }

    final attemptsJson = prefs.getString('attempts');
    if (attemptsJson != null) {
      final List<dynamic> decodedAttempts = json.decode(attemptsJson);
      _attempts =
          decodedAttempts.map((item) => QuizAttempt.fromJson(item)).toList();
    }

    notifyListeners();
  }

  // Save questions to local storage
  Future<void> _saveQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(_questions.map((q) => q.toJson()).toList());
    await prefs.setString('questions', data);
  }

  // Save attempts to local storage
  Future<void> _saveAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(_attempts.map((a) => a.toJson()).toList());
    await prefs.setString('attempts', data);
  }
}

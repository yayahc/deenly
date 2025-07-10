// lib/models/quiz_question.dart
class QuizQuestion {
  final String id;
  final String question;
  final String surahNumber;
  final String verseNumber;
  final String? notes;
  final DateTime createdAt;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.surahNumber,
    required this.verseNumber,
    this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'surahNumber': surahNumber,
      'verseNumber': verseNumber,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      question: json['question'],
      surahNumber: json['surahNumber'],
      verseNumber: json['verseNumber'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // New method to convert a JSON list to a list of QuizQuestion objects
  static List<QuizQuestion> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => QuizQuestion.fromJson(json)).toList();
  }
}

// lib/models/quiz_attempt.dart
class QuizAttempt {
  final String id;
  final String questionId;
  final String userAnswer;
  final bool isCorrect;
  final DateTime attemptDate;

  QuizAttempt({
    required this.id,
    required this.questionId,
    required this.userAnswer,
    required this.isCorrect,
    required this.attemptDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'userAnswer': userAnswer,
      'isCorrect': isCorrect,
      'attemptDate': attemptDate.toIso8601String(),
    };
  }

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      id: json['id'],
      questionId: json['questionId'],
      userAnswer: json['userAnswer'],
      isCorrect: json['isCorrect'],
      attemptDate: DateTime.parse(json['attemptDate']),
    );
  }
  // New method to convert a JSON list to a list of QuizAttempt objects
  static List<QuizAttempt> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => QuizAttempt.fromJson(json)).toList();
  }
}

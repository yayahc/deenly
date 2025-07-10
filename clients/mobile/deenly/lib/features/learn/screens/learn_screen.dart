import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../quiz/models/quiz_model.dart';
import '../../quiz/provider/quiz_provider.dart';

class LearnScreen extends StatefulWidget {
  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  String? selectedSurah;
  String? selectedVerse;
  List<QuizQuestion> filteredQuestions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final quizProvider = Provider.of<QuizProvider>(context);
    filteredQuestions = quizProvider.questions;
  }

  void filterQuestions() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    setState(() {
      filteredQuestions = quizProvider.questions.where((q) {
        final matchesSurah =
            selectedSurah == null || q.surahNumber == selectedSurah;
        final matchesVerse =
            selectedVerse == null || q.verseNumber == selectedVerse;
        return matchesSurah && matchesVerse;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    List<String> surahNumbers =
        quizProvider.questions.map((q) => q.surahNumber).toSet().toList();

    return Scaffold(
      appBar: AppBar(title: Text('Learn - Filter by Verse')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              hint: Text("Select Surah"),
              value: selectedSurah,
              items: surahNumbers.map((surah) {
                return DropdownMenuItem(
                    value: surah, child: Text("Surah $surah"));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSurah = value;
                  filterQuestions();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Enter Verse Number"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  selectedVerse = value.isEmpty ? null : value;
                  filterQuestions();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredQuestions.length,
              itemBuilder: (context, index) {
                final question = filteredQuestions[index];
                return ListTile(
                  title: Text(question.question),
                  subtitle: Text(
                      "Surah ${question.surahNumber}, Verse ${question.verseNumber}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

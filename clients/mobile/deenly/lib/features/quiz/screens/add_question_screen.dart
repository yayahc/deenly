// lib/screens/add_question_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quiz_model.dart';
import '../provider/quiz_provider.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _surahController = TextEditingController();
  final _verseController = TextEditingController();
  final _notesController = TextEditingController();
  final _jsonImportController = TextEditingController();
  bool _isImporting = false;
  bool _showJsonImport = false;

  @override
  void dispose() {
    _questionController.dispose();
    _surahController.dispose();
    _verseController.dispose();
    _notesController.dispose();
    _jsonImportController.dispose();
    super.dispose();
  }

  void _saveQuestion() {
    if (_formKey.currentState!.validate()) {
      Provider.of<QuizProvider>(context, listen: false).addQuestion(
        _questionController.text,
        _surahController.text,
        _verseController.text,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );
      Navigator.of(context).pop();
    }
  }

  void _toggleJsonImport() {
    setState(() {
      _showJsonImport = !_showJsonImport;
    });
  }

  void _importFromJson() {
    setState(() {
      _isImporting = true;
    });

    try {
      final jsonString = _jsonImportController.text;

      if (jsonString.isEmpty) {
        _showErrorSnackBar('JSON field is empty');
        return;
      }

      // Try to parse the JSON
      try {
        final dynamic jsonData = jsonDecode(jsonString);
        List<dynamic> questionsList;

        // Check if it's an array or an object with a questions property
        if (jsonData is List) {
          questionsList = jsonData;
        } else if (jsonData is Map && jsonData.containsKey('questions')) {
          questionsList = jsonData['questions'] as List;
        } else {
          _showErrorSnackBar(
              'Invalid JSON format. Expected an array or object with questions property');
          return;
        }

        // Convert JSON to QuizQuestion objects
        final questions = QuizQuestion.listFromJson(questionsList);

        if (questions.isEmpty) {
          _showErrorSnackBar('No valid questions found in the JSON');
          return;
        }

        // Add all questions to the provider
        final provider = Provider.of<QuizProvider>(context, listen: false);
        int addedCount = 0;

        for (final question in questions) {
          provider.addQuestion(
              question.question, question.surahNumber, question.verseNumber,
              notes: question.notes);
          addedCount++;
        }

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported $addedCount questions'),
            backgroundColor: Colors.green,
          ),
        );

        // Return to previous screen
        Navigator.of(context).pop();
      } catch (e) {
        _showErrorSnackBar('Error parsing JSON: ${e.toString()}');
      }
    } finally {
      setState(() {
        _isImporting = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Question'),
        actions: [
          TextButton.icon(
            onPressed: _toggleJsonImport,
            icon: Icon(_showJsonImport ? Icons.close : Icons.data_array),
            label: Text(_showJsonImport ? 'Cancel' : 'Import JSON'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _showJsonImport
                ? _buildJsonImportForm()
                : _buildSingleQuestionForm(),
          ),
          if (_isImporting)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSingleQuestionForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
                hintText: 'e.g., Where does Allah mention splitting the sea?',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a question';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
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
                        return 'Required';
                      }
                      final number = int.tryParse(value);
                      if (number == null || number < 1 || number > 114) {
                        return 'Enter valid surah (1-114)';
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
                        return 'Required';
                      }
                      final number = int.tryParse(value);
                      if (number == null || number < 1) {
                        return 'Enter valid verse';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (Optional)',
                hintText: 'Any additional context or details',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveQuestion,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Question',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJsonImportForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Import Multiple Questions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Paste JSON data containing quiz questions below.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TextFormField(
            controller: _jsonImportController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Paste JSON here...',
            ),
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _importFromJson,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Import Questions',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

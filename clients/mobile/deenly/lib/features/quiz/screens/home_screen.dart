import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../learn/screens/learn_screen.dart';
import '../../streak/screen/streak.dart';
import '../../tasbih/screens/tasbih_screen.dart';
import '../provider/quiz_provider.dart';
import '../widgets/state_card.dart';
import 'add_question_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String botToken =
      'F0'; // Your Telegram Bot Token
  final String chatId = '905831171'; // Y
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<QuizProvider>(context, listen: false).loadData();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _exportToTelegram() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final questions = quizProvider.questions;

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No questions to export')),
      );
      return;
    }

    // Convert questions to JSON string
    final jsonString = jsonEncode(questions.map((q) => q.toJson()).toList());

    try {
      // Get the directory to save the file
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/quran_ref_export.json');

      // Write JSON data to the file
      await file.writeAsString(jsonString);

      // Send the file via Telegram API
      var uri = Uri.parse('https://api.telegram.org/bot$botToken/sendDocument');

      var request = MultipartRequest('POST', uri)
        ..fields['chat_id'] = chatId
        ..files.add(await MultipartFile.fromPath('document', file.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exported successfully as a file')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final questions = quizProvider.questions;
    final stats = quizProvider.getStats();

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuranRef'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Export to Telegram',
            onPressed: _exportToTelegram,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatsCard(stats: stats),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Question'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const AddQuestionScreen(),
                      ),
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.quiz),
                  label: const Text('Start Quiz'),
                  onPressed: questions.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const QuizScreen(),
                            ),
                          );
                        },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.touch_app),
                  label: const Text('Tasbih'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const TasbihScreen(),
                      ),
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.book),
                  label: const Text('Learn'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => LearnScreen(),
                      ),
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.trending_up_outlined),
                  label: const Text('Streak'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const QuranStreakPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

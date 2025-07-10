import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class QuranStreakPage extends StatefulWidget {
  const QuranStreakPage({super.key});

  @override
  _QuranStreakPageState createState() => _QuranStreakPageState();
}

class _QuranStreakPageState extends State<QuranStreakPage> {
  int _currentStreak = 0;
  int _highestStreak = 0;
  bool _hasReadToday = false;
  List<String> _readDates = [];

  @override
  void initState() {
    super.initState();
    _loadStreakData();
  }

  Future<void> _loadStreakData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _currentStreak = prefs.getInt('currentStreak') ?? 0;
      _highestStreak = prefs.getInt('highestStreak') ?? 0;
      _readDates = prefs.getStringList('readDates') ?? [];
      _hasReadToday = _checkIfReadToday();
    });
  }

  bool _checkIfReadToday() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return _readDates.contains(today);
  }

  Future<void> _markAsRead() async {
    if (_hasReadToday) return;

    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final yesterday = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 1)));

    // Check if user read yesterday to continue streak
    final bool readYesterday = _readDates.contains(yesterday);

    // Calculate new streak
    int newStreak = readYesterday ? _currentStreak + 1 : 1;
    int newHighestStreak =
        newStreak > _highestStreak ? newStreak : _highestStreak;

    // Add today to read dates
    List<String> newReadDates = List<String>.from(_readDates);
    newReadDates.add(today);

    // Keep only last 100 dates to save space
    if (newReadDates.length > 100) {
      newReadDates = newReadDates.sublist(newReadDates.length - 100);
    }

    // Save data
    await prefs.setInt('currentStreak', newStreak);
    await prefs.setInt('highestStreak', newHighestStreak);
    await prefs.setStringList('readDates', newReadDates);

    // Update state
    setState(() {
      _currentStreak = newStreak;
      _highestStreak = newHighestStreak;
      _readDates = newReadDates;
      _hasReadToday = true;
    });

    // Show achievement popup if milestone reached
    if (newStreak == 7 ||
        newStreak == 30 ||
        newStreak == 100 ||
        newStreak == 365) {
      _showAchievementPopup(newStreak);
    }
  }

  void _showAchievementPopup(int days) {
    String message;

    if (days == 7) {
      message = 'MashaAllah! You\'ve maintained a 7-day streak.';
    } else if (days == 30) {
      message =
          'MashaAllah! You\'ve maintained a 30-day streak. May Allah reward your consistency.';
    } else if (days == 100) {
      message =
          'MashaAllah! 100 days of continuous reading. An incredible achievement!';
    } else {
      message =
          'MashaAllah! A full year of reading Quran every day. May Allah bless you abundantly!';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Streak Achievement!'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Alhamdulillah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFF5F5F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStreakCard(
                  'Current Streak',
                  _currentStreak,
                  Icons.local_fire_department,
                  Colors.orange,
                ),
                _buildStreakCard(
                  'Highest Streak',
                  _highestStreak,
                  Icons.emoji_events,
                  Colors.amber,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: _hasReadToday ? null : _markAsRead,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E8449),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: Text(
                _hasReadToday
                    ? 'Already Marked for Today'
                    : 'Mark Today\'s Reading Complete',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Reading Calendar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildReadingCalendar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(String title, int count, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              count == 1 ? 'day' : 'days',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingCalendar() {
    // Get dates for current month
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday;

    // Create calendar grid
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 7 + daysInMonth + firstWeekdayOfMonth - 1,
      itemBuilder: (context, index) {
        // Weekday headers
        if (index < 7) {
          final weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
          return Center(
            child: Text(
              weekdays[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }

        // Calendar days
        final dayIndex = index - 7 - firstWeekdayOfMonth + 1;
        if (dayIndex < 0 || dayIndex >= daysInMonth) {
          return Container(); // Empty cell for days before/after month
        }

        final day = dayIndex + 1;
        final date = DateTime(now.year, now.month, day);
        final dateString = DateFormat('yyyy-MM-dd').format(date);
        final isRead = _readDates.contains(dateString);
        final isToday = day == now.day;

        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isRead ? const Color(0xFFD5F5E3) : Colors.transparent,
            border: Border.all(
              color: isToday ? const Color(0xFF1E8449) : Colors.grey[300]!,
              width: isToday ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isRead ? const Color(0xFF1E8449) : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}

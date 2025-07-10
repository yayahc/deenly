// lib/widgets/stats_card.dart
import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final Map<String, dynamic> stats;

  const StatsCard({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              'Questions',
              icons: Icons.help_outline,
              value: stats['totalAttempts'].toString(),
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
              color: Colors.grey,
            ),
            _buildStatItem(
              'Correct',
              icons: Icons.check_circle_outline,
              value: stats['correctAnswers'].toString(),
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
              color: Colors.grey,
            ),
            _buildStatItem(
              'Accuracy',
              icons: Icons.analytics_outlined,
              value: '${stats['accuracy'].toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label,
      {required IconData icons, required String value}) {
    return Column(
      children: [
        Icon(
          icons,
          color: Colors.green[700],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

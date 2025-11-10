import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd.MM.yyyy – HH:mm').format(exam.dateTime);
    final color = exam.isPassed ? Colors.red : Colors.green;

    return Card(
      color: color,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exam.examName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 5),
                Text(dateFormatted),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.room, size: 16),
                const SizedBox(width: 5),
                Text(exam.rooms.join(', ')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

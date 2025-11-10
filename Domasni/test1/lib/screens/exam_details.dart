import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  String getRemainingTime() {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    if (diff.isNegative) {
      return 'Испитот веќе помина';
    }
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    return '$days дена, $hours часа';
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy – HH:mm').format(exam.dateTime);

    return Scaffold(
      appBar: AppBar(title: Text(exam.subjectName)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Датум и време: $formattedDate',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Простории: ${exam.rooms.join(', ')}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Преостанато време: ${getRemainingTime()}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}

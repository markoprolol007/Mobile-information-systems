import 'package:flutter/material.dart';

import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'exam_details.dart';

class ListAllExamsScreen extends StatelessWidget {
  const ListAllExamsScreen({super.key});

  List<Exam> get exams => [
    Exam(
        examName: 'Алгоритми и податочни структури',
        dateTime: DateTime(2026, 1, 12, 9, 0),
        rooms: ['AMF', 'LAB 2'],
        isPassed: false
    ),
    Exam(
      examName: 'Објектно ориентирано програмирање',
      dateTime: DateTime(2025, 1, 15, 10, 0),
      rooms: ['LAB 3'],
    ),
    Exam(
        examName: 'Оперативни системи',
        dateTime: DateTime(2026, 1, 8, 8, 0),
        rooms: ['AMF'],
        isPassed: false
    ),
    Exam(
        examName: 'Вештачка интелигенција',
        dateTime: DateTime(2026, 1, 20, 13, 0),
        rooms: ['LAB 1'],
        isPassed: false
    ),
    Exam(
        examName: 'Бази на податоци',
        dateTime: DateTime(2026, 1, 17, 9, 0),
        rooms: ['LAB 3'],
        isPassed: false
    ),
    Exam(
      examName: 'Компјутерски мрежи и безбедност',
      dateTime: DateTime(2025, 1, 25, 9, 0),
      rooms: ['AMF', 'LAB 1'],
    ),
    Exam(
      examName: 'Интернет технологии',
      dateTime: DateTime(2025, 1, 27, 11, 0),
      rooms: ['LAB 4'],
    ),
    Exam(
        examName: 'Структурно програмирање',
        dateTime: DateTime(2026, 2, 2, 10, 0),
        rooms: ['LAB 6', 'AMF'],
        isPassed: false
    ),
    Exam(
      examName: 'Мобилни информациски системи',
      dateTime: DateTime(2025, 2, 5, 9, 0),
      rooms: ['AMF'],
    ),
    Exam(
      examName: 'Вовед во науката за податоци',
      dateTime: DateTime(2025, 1, 30, 8, 0),
      rooms: ['LAB 215'],
    ),
    Exam(
      examName: 'Веројатност и статистика',
      dateTime: DateTime(2025, 2, 30, 8, 0),
      rooms: ['LAB 215'],
    ),
    Exam(
      examName: 'Логички кола',
      dateTime: DateTime(2025, 7, 30, 8, 0),
      rooms: ['LAB 215'],
    ),
    Exam(
        examName: 'Принципи на компјутерска организација',
        dateTime: DateTime(2026, 4, 30, 8, 0),
        rooms: ['LAB 215'],
        isPassed: false
    ),
  ]..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Распоред на испити - 221077'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ExamDetailScreen(exam: exam)),
              );
            },
            child: ExamCard(exam: exam),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list_alt),
            const SizedBox(width: 8),
            Text(
              'Вкупно испити: ${exams.length}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
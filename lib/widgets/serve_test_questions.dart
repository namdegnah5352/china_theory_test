import 'package:flutter/material.dart';
import '../domain/entities/question.dart';

class ServeTestQuestions extends StatefulWidget {
  const ServeTestQuestions(this.questions, {super.key});
  final List<Question> questions;
  @override
  State<ServeTestQuestions> createState() => _ServeTestQuestionsState();
}

class _ServeTestQuestionsState extends State<ServeTestQuestions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(child: Text('Serve')),
    );
  }
}

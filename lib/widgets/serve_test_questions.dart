import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import '../screens/question_test.dart';

class ServeTestQuestions extends StatefulWidget {
  const ServeTestQuestions(this.questions, {super.key});
  final List<Question> questions;
  @override
  State<ServeTestQuestions> createState() => _ServeTestQuestionsState();
}

class _ServeTestQuestionsState extends State<ServeTestQuestions> {
  int index = 0;
  void increaseIndex() {
    setState(() {
      index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(child: Text('Serve')),
          const SizedBox(height: 5),
          QuestionTest(widget.questions[index], increaseIndex),
        ],
      ),
    );
  }
}

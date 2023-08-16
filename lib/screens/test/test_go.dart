import 'package:flutter/material.dart';
import '../../widgets/serve_test_questions.dart';
import '../../widgets/test_dashboard.dart';
import '../../domain/entities/question.dart';

class TestGo extends StatefulWidget {
  const TestGo(this.questions, {super.key});
  final List<Question> questions;
  @override
  State<TestGo> createState() => _TestGoState();
}

class _TestGoState extends State<TestGo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TestDashboard(),
          ServeTestQuestions(widget.questions),
        ],
      ),
    );
  }
}

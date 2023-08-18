import 'package:flutter/material.dart';
import '../../widgets/serve_test_questions.dart';
import '../../widgets/test_dashboard.dart';
import '../../domain/entities/question.dart';

class TestGo extends StatefulWidget {
  const TestGo(this.questions, this.noQuestions, this.noSeconds, this.popMaster, {super.key});
  final List<Question> questions;
  final int noQuestions;
  final int noSeconds;
  final Function popMaster;
  @override
  State<TestGo> createState() => _TestGoState();
}

class _TestGoState extends State<TestGo> {
  void goAway() {
    Navigator.pop(context);
    widget.popMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TestDashboard(widget.noQuestions, widget.noSeconds, goAway),
          ServeTestQuestions(widget.questions, goAway),
        ],
      ),
    );
  }
}

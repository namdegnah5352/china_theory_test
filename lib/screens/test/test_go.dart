import 'package:flutter/material.dart';
import '../../widgets/serve_test_questions.dart';
import '../../widgets/test_dashboard.dart';
import '../../domain/entities/question.dart';
import '../../config/constants.dart';
import '../../calls/app_calls.dart' as calls;

class TestGo extends StatefulWidget {
  const TestGo(this.questions, this.noQuestions, this.noSeconds, {super.key});
  final List<Question> questions;
  final int noQuestions;
  final int noSeconds;
  @override
  State<TestGo> createState() => _TestGoState();
}

class _TestGoState extends State<TestGo> {
  void finishTest(bool method, int? mark) async {
    if (method == AppConstants.questionsFinished) {
      calls.resetCounter();
      print('Test Finished Questions done');
      Navigator.of(context).pop();
      await calls.loadTestResults(3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TestDashboard(widget.noQuestions, widget.noSeconds),
          ServeTestQuestions(widget.questions, finishTest),
        ],
      ),
    );
  }
}

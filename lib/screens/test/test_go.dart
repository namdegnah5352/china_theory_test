import 'package:flutter/material.dart';
import '../../widgets/serve_test_questions.dart';
import '../../widgets/test_dashboard.dart';
import '../../domain/entities/question.dart';

class TestGo extends StatefulWidget {
  const TestGo(this.questions, this.noSeconds, this.popMaster, {super.key});
  final List<Question> questions;
  final int noSeconds;
  final Function popMaster;
  @override
  State<TestGo> createState() => _TestGoState();
}

class _TestGoState extends State<TestGo> {
  bool _showRunningTotal = true;
  void goAway() {
    Navigator.pop(context);
    widget.popMaster();
  }

  bool get showRunningTotal => _showRunningTotal;
  set showRunningTotal(bool value) => setState(() {
        _showRunningTotal = value;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.hide_source),
            onPressed: () {
              setState(() {
                _showRunningTotal = !_showRunningTotal;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TestDashboard(widget.noSeconds, goAway, showRunningTotal),
            ServeTestQuestions(widget.questions, goAway),
          ],
        ),
      ),
    );
  }
}

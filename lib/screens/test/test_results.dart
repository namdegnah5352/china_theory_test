import 'package:flutter/material.dart';
import '../../calls/test_calls.dart' as testcalls;

class TestResults extends StatefulWidget {
  const TestResults({super.key});

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Your score is ${testcalls.mark} out of ${testcalls.noQuestions}'),
          ],
        ),
      ),
    );
  }
}

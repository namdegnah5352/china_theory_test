import 'package:flutter/material.dart';

class TestResults extends StatefulWidget {
  const TestResults(this.mark, {super.key});
  final int mark;

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
            Text(widget.mark.toString()),
          ],
        ),
      ),
    );
  }
}

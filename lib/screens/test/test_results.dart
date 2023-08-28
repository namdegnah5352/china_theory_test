import 'package:flutter/material.dart';
import '../../calls/test_calls.dart' as testcalls;
import '../../config/text_styles.dart';

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
            const SizedBox(height: 10),
            Center(
              child: switch (testcalls.mark / testcalls.noQuestions) {
                100 => Text('100 % Well Done', style: getGoodResult(context)),
                _ => const Text('Need to improve')
              },
            )
          ],
        ),
      ),
    );
  }
}

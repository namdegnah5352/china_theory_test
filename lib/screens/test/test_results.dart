import 'package:flutter/material.dart';
import '../../calls/test_calls.dart' as testcalls;
import '../../config/text_styles.dart';

class TestResults extends StatefulWidget {
  const TestResults({super.key});

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    animation = Tween<double>(begin: 0.5, end: 2).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget perfectResult() {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        child: Text('100% Well done', style: getGoodResult(context, 30)),
        builder: (context, child) => Transform.scale(
          scale: animation.value,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var result = testcalls.mark / testcalls.noQuestions;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text('Your score is ${testcalls.mark} out of ${testcalls.noQuestions}'),
            const SizedBox(height: 30),
            if (result != 1) const Text('must improve'),
            const SizedBox(height: 30),
            perfectResult(),
          ],
        ),
      ),
    );
  }
}

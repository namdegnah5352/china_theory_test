import 'package:flutter/material.dart';
import '../../calls/test_calls.dart' as testcalls;
import '../../config/text_styles.dart';
import '../../library/core/clippers/star_clipper.dart';
import 'dart:math';

class TestResults extends StatefulWidget {
  const TestResults({super.key});

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationScale;
  late Animation<double> animationRotation;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    animationScale = Tween<double>(begin: 0.5, end: 2).animate(controller);
    animationRotation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);
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
        animation: animationScale,
        child: Text('100% Well done!', style: getGoodResult(context, 30)),
        builder: (context, child) => Transform.scale(
          scale: animationScale.value,
          child: child,
        ),
      ),
    );
  }

  Widget perfectStar() {
    return Center(
      child: AnimatedBuilder(
        animation: animationRotation,
        child: starCelebration(50),
        builder: (context, child) => Transform.rotate(
          angle: animationRotation.value,
          child: child,
        ),
      ),
    );
  }

  Widget starCelebration(double size) {
    return ClipPath(
      clipper: StarClipper(5, 3),
      child: Container(
        width: size,
        height: size,
        color: Colors.yellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var result = testcalls.mark / testcalls.noQuestions;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text('Results', style: getPrimaryContainer(context, 22)),
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
            const SizedBox(height: 10),
            perfectStar(),
          ],
        ),
      ),
    );
  }
}

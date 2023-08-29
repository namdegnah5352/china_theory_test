import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/text_styles.dart';

class TestResult extends StatefulWidget {
  const TestResult({super.key});

  @override
  State<TestResult> createState() => _TestResultState();
}

class _TestResultState extends State<TestResult> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          child: const Text('100% Well Done!'),
          builder: (context, child) => Transform.scale(
            scale: animation.value,
            child: child,
          ),
        ),
      ),
    );
  }
}

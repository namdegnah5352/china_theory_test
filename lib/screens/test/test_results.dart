import 'package:flutter/material.dart';
import '../../calls/test_calls.dart' as testcalls;
import '../../config/text_styles.dart';

class TestResults extends StatefulWidget {
  const TestResults({super.key});

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _size;
  bool _large = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 100.0;
      _large = !_large;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _size = 100;
    super.initState();
  }

  void _onAnimationChanged() {
    setState(() {
      _size = _controller.value * 100;
    });
  }

  @override
  void didUpdateWidget(covariant TestResults oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSize();
    _controller.forward();
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
            result == 1 ? Text('100% Well done', style: getGoodResult(context, 30)) : const Text('must improve'),
            AnimatedSize(
              duration: _controller.duration!,
              curve: Curves.easeInOut,
              child: Container(
                width: _size,
                height: _size,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../calls/app_calls.dart' as calls;

class TestDashboard extends StatefulWidget {
  const TestDashboard(this.noQuestions, this.seconds, {super.key});
  final int noQuestions;
  final int seconds;

  @override
  State<TestDashboard> createState() => _TestDashboardState();
}

class _TestDashboardState extends State<TestDashboard> {
  int icounter = 0;
  int min = 0;
  int iseconds = 0;
  @override
  void initState() {
    calls.countSeconds(counterFunction);
    super.initState();
  }

  void counterFunction(int count) {
    if (mounted) {
      setState(() {
        icounter = count;
        var toDo = widget.seconds - icounter;
        min = (toDo / 60).floor();
        iseconds = toDo - min * 60;
      });
    }
  }

  @override
  void dispose() {
    calls.resetCounter();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(child: Text('$min min and $iseconds seconds')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

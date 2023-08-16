import 'package:flutter/material.dart';
import '../calls/app_calls.dart' as calls;

class TestDashboard extends StatefulWidget {
  const TestDashboard({super.key});

  @override
  State<TestDashboard> createState() => _TestDashboardState();
}

class _TestDashboardState extends State<TestDashboard> {
  int counter = 0;
  @override
  void initState() {
    calls.resetCounter();
    counter = 0;
    calls.countSeconds(counterFunction);
    super.initState();
  }

  void counterFunction(int count) {
    if (mounted) {
      setState(() {
        counter = count;
      });
    }
  }

  @override
  void dispose() {
    calls.countSeconds(counterFunction, true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(child: Text('$counter')),
    );
  }
}

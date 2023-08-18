import 'package:flutter/material.dart';
import '../calls/app_calls.dart' as appcalls;
import '../calls/test_calls.dart' as testcalls;

class TestDashboard extends StatefulWidget {
  const TestDashboard(this.seconds, this.popMaster, {super.key});
  final int seconds;
  final Function popMaster;

  @override
  State<TestDashboard> createState() => _TestDashboardState();
}

class _TestDashboardState extends State<TestDashboard> {
  int icounter = 0;
  int min = 0;
  int iseconds = 0;
  @override
  void initState() {
    appcalls.countSeconds(counterFunction);
    super.initState();
  }

  void counterFunction(int count) async {
    if (mounted) {
      if (count == widget.seconds) {
        widget.popMaster();
        await appcalls.loadTestResults();
      } else {
        setState(() {
          icounter = count;
          var toDo = widget.seconds - icounter;
          min = (toDo / 60).floor();
          iseconds = toDo - min * 60;
        });
      }
    }
  }

  @override
  void dispose() {
    appcalls.resetCounter();
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

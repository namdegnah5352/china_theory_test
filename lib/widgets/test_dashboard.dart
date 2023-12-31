import 'package:flutter/material.dart';
import '../calls/app_calls.dart' as appcalls;
import '../calls/test_calls.dart' as testcalls;

class TestDashboard extends StatefulWidget {
  const TestDashboard(this.seconds, this.popMaster, this.showRunningTotal, {super.key});
  final int seconds;
  final Function popMaster;
  final bool showRunningTotal;

  @override
  State<TestDashboard> createState() => _TestDashboardState();
}

class _TestDashboardState extends State<TestDashboard> {
  int icounter = 0;
  int min = 0;
  int used = 0;
  int iseconds = 0;
  int usedSeconds = 0;

  @override
  void initState() {
    appcalls.countSeconds(counterFunction);
    super.initState();
  }

  void counterFunction(int count) async {
    testcalls.secondsUsed = count;
    if (mounted) {
      if (count == widget.seconds) {
        widget.popMaster();
        await appcalls.loadTestResults();
      } else {
        setState(() {
          icounter = count;
          var toDo = widget.seconds - icounter;
          used = (count / 60).floor();
          min = (toDo / 60).floor();
          iseconds = toDo - min * 60;
          usedSeconds = count - used * 60;
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
          Center(child: Text('$min min and $iseconds seconds left')),
          Center(child: Text('$used min and $usedSeconds seconds used')),
          widget.showRunningTotal
              ? Center(child: Text('${testcalls.noQuestionsDone} out of ${testcalls.noQuestions} done'))
              : Container(width: 0),
        ],
      ),
    );
  }
}

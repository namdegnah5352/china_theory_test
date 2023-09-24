import 'package:flutter/material.dart';
import '../../config/text_styles.dart';
import '../../domain/entities/question.dart';
import '../../calls/app_calls.dart' as appcalls;
import '../../calls/test_calls.dart' as testcalls;

class TestScreen extends StatefulWidget {
  const TestScreen(this.questions, this.finalTest, {super.key});
  final List<Question> questions;
  final bool finalTest;
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late final TextEditingController noQuestionsController;
  late final TextEditingController timeController;
  late List<Question> toUseQuestions;
  int secs = 0;
  @override
  void initState() {
    toUseQuestions = widget.finalTest ? widget.questions : appcalls.filterQuestions(widget.questions);
    noQuestionsController = TextEditingController();
    noQuestionsController.text = '${toUseQuestions.length}';
    timeController = TextEditingController();
    timeController.text = getTimeText(toUseQuestions);
    super.initState();
  }

  String getTimeText(List<Question> questions) {
    secs = questions.length * 27;
    int min = (secs / 60).floor();
    int seconds = secs - min * 60;
    return '$min min $seconds seconds';
  }

  void goAway() {
    Navigator.pop(context);
  }

  List<Question> reduceQuestionSize(List<Question> input, int limit) {
    if (limit < input.length) {
      List<Question> ans = [];
      input.shuffle();
      for (var i = 0; i < limit; i++) {
        ans.add(input[i]);
      }
      return ans;
    }
    return input;
  }

  @override
  void dispose() {
    noQuestionsController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const SizedBox(height: 20), getControlCenter(noQuestionsController, timeController)],
        ),
      ),
    );
  }

  Widget getAdjustableCount(TextEditingController noQuestionsController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: noQuestionsController,
            decoration: InputDecoration(
              labelText: 'No Questions',
              helperStyle: skillsBody,
              contentPadding: const EdgeInsets.only(left: 10),
              errorMaxLines: 2,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.black54),
              ),
              border: const OutlineInputBorder(
                gapPadding: 4.0,
                borderSide: BorderSide(color: Colors.black26),
              ),
            ),
          ),
        ),
        const Spacer(),
        FilledButton.tonal(
          onPressed: () {
            toUseQuestions = reduceQuestionSize(toUseQuestions, int.parse(noQuestionsController.text));
            setState(() {
              timeController.text = getTimeText(toUseQuestions);
            });
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
            alignment: Alignment.center,
          ),
          child: const Text('Update'),
        ),
      ],
    );
  }

  Widget getControlCenter(TextEditingController noQuestionsController, TextEditingController timeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        FilledButton.tonal(
          onPressed: () {
            testcalls.mark = 0;
            testcalls.noQuestionsDone = 0;
            testcalls.noQuestions = toUseQuestions.length;
            appcalls.loadTestGo(toUseQuestions, secs, goAway);
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
            alignment: Alignment.center,
          ),
          child: const Text('Start Test'),
        ),
        const SizedBox(height: 20),
        getAdjustableCount(noQuestionsController),
        const SizedBox(height: 20),
        TextFormField(
          readOnly: true,
          controller: timeController,
          decoration: InputDecoration(
            labelText: 'Time for Test',
            helperStyle: skillsBody,
            contentPadding: const EdgeInsets.only(left: 10),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black54),
            ),
            border: const OutlineInputBorder(
              gapPadding: 4.0,
              borderSide: BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ],
    );
  }
}

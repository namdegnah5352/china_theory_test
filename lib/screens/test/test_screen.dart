import 'package:flutter/material.dart';
import '../../config/text_styles.dart';
import '../../domain/entities/question.dart';
import '../../calls/app_calls.dart';

class TestScreen extends StatefulWidget {
  const TestScreen(this.questions, {super.key});
  final List<Question> questions;
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late final TextEditingController noQuestionsController;
  late final TextEditingController timeController;
  late final List<Question> toUseQuestions;
  @override
  void initState() {
    toUseQuestions = filterQuestions(widget.questions);
    noQuestionsController = TextEditingController();
    noQuestionsController.text = '${toUseQuestions.length}';
    timeController = TextEditingController();
    var secs = toUseQuestions.length * 27;
    int min = (secs / 60).floor();
    int seconds = secs - min * 60;
    timeController.text = '$min min $seconds seconds';
    super.initState();
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

  Widget getControlCenter(TextEditingController noQuestionsController, TextEditingController timeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        FilledButton.tonal(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
            alignment: Alignment.center,
          ),
          child: const Text('Start Test'),
        ),
        const SizedBox(height: 20),
        TextFormField(
          readOnly: true,
          controller: noQuestionsController,
          decoration: InputDecoration(
            labelText: 'No Questions',
            // helperText: 'Helper',
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
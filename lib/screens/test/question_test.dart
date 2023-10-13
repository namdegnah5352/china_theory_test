import 'package:flutter/material.dart';
import '../../domain/entities/question.dart';
import '../../config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/navigation/global_nav.dart';

SharedPreferences sharedPreferences = GlobalNav.instance.sharedPreferences!;

class QuestionTest extends StatefulWidget {
  final Question question;
  final Function callback;
  const QuestionTest(this.question, this.callback, {super.key});

  @override
  State<QuestionTest> createState() => _QuestionTestState();
}

class _QuestionTestState extends State<QuestionTest> {
  late TextEditingController controller;
  late bool randomAnswerSettings;
  bool ans = false;

  @override
  void initState() {
    randomAnswerSettings = sharedPreferences.getBool(AppConstants.randomAnswersKey)!;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.question.questionText;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 5),
            switch (widget.question.type[0]) {
              'P' => widget.question.getPicture(150, true, context)!,
              _ => const SizedBox(height: 1, width: 1),
            },
            TextField(
              readOnly: true,
              controller: controller,
              maxLines: AppConstants.questionLineMax,
            ),
            switch (widget.question.type) {
              'P' => getFourAnswers(widget.question),
              'Plogic' || 'Logic' => getLogicAnswer(widget.question),
              _ => getFourAnswers(widget.question),
            },
          ],
        ),
      ),
    );
  }

  Widget getLogicAnswer(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 5),
        getButton(question.answer, 'True'),
        const SizedBox(height: 20),
        getButton(question.answer, 'False'),
      ],
    );
  }

  Widget getFourAnswers(Question question) {
    var answers = [
      getButton('A', widget.question.a),
      getButton('B', widget.question.b),
      getButton('C', widget.question.c),
      getButton('D', widget.question.d)
    ];
    if (randomAnswerSettings) answers.shuffle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 5),
        answers[0],
        const SizedBox(height: 20),
        answers[1],
        const SizedBox(height: 20),
        answers[2],
        const SizedBox(height: 20),
        answers[3],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget getButton(String value, String question) {
    return FilledButton.tonal(
      onPressed: () async {
        setState(() {
          widget.callback(value);
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primaryContainer),
      ),
      child: Text(
        question,
        maxLines: AppConstants.questionAnswerLineMax,
        textAlign: TextAlign.center,
      ),
    );
  }
}

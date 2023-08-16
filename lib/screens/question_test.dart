import 'package:flutter/material.dart';
import '../domain/entities/question.dart';

class QuestionTest extends StatefulWidget {
  final Question question;
  const QuestionTest(this.question, {super.key});

  @override
  State<QuestionTest> createState() => _QuestionTestState();
}

class _QuestionTestState extends State<QuestionTest> {
  late TextEditingController controller;
  bool ans = false;

  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.question.questionText;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            switch (widget.question.type[0]) {
              'P' => widget.question.getPicture(150, true, context)!,
              _ => const SizedBox(height: 1, width: 1),
            },
            TextField(
              readOnly: true,
              controller: controller,
              maxLines: 4,
            ),
            switch (widget.question.type) {
              'P' => getFourAnswers(widget.question),
              'Plogic' || 'Logic' => getLogicAnswer(widget.question),
              _ => getFourAnswers(widget.question),
            },
            const SizedBox(height: 20),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: ans ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: Colors.black54),
              ),
              child: ans
                  ? const Center(
                      child: Text(
                      'Correct',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ))
                  : const SizedBox(height: 1, width: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLogicAnswer(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        getLogicButton(question.answer, 'True'),
        const SizedBox(height: 20),
        getLogicButton(question.answer, 'False'),
      ],
    );
  }

  Widget getFourAnswers(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        getButton('A', widget.question.a),
        const SizedBox(height: 20),
        getButton('B', widget.question.b),
        const SizedBox(height: 20),
        getButton('C', widget.question.c),
        const SizedBox(height: 20),
        getButton('D', widget.question.d),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget getLogicButton(String value, String question) {
    return FilledButton.tonal(
      onPressed: () {
        setState(() {
          ans = question.toLowerCase() == value.toLowerCase();
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
        alignment: Alignment.center,
        backgroundColor:
            MaterialStateProperty.all<Color>(question.toLowerCase() == value.toLowerCase() ? Colors.green : Colors.blue),
      ),
      child: Text(
        question,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getButton(String value, String question) {
    return FilledButton.tonal(
      onPressed: () async {
        setState(() {
          ans = widget.question.answer == value;
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all<Color>(widget.question.answer == value ? Colors.green : Colors.blue),
      ),
      child: Text(
        question,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}

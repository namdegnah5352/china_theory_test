import 'package:flutter/material.dart';
import '../../domain/entities/question.dart';

class QuestionTest extends StatefulWidget {
  final Question question;
  final Function callback;
  const QuestionTest(this.question, this.callback, {super.key});

  @override
  State<QuestionTest> createState() => _QuestionTestState();
}

class _QuestionTestState extends State<QuestionTest> {
  late TextEditingController controller;
  bool ans = false;

  @override
  void initState() {
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
          widget.callback(value);
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
        alignment: Alignment.center,
        backgroundColor:          MaterialStateProperty.all<Color>MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primaryContainer),
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
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}

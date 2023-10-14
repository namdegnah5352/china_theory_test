import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import '../config/constants.dart';
import '../calls/app_calls.dart';

class QuestionListTile extends StatefulWidget {
  final Question question;
  const QuestionListTile(this.question, {super.key});

  @override
  State<QuestionListTile> createState() => _QuestionListTileState();
}

class _QuestionListTileState extends State<QuestionListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(width: 1),
      ),
      child: ListTile(
        title: Text(
          widget.question.questionText,
          maxLines: AppConstants.questionAnswerLineMax,
        ),
        subtitle: Text(widget.question.id),
        trailing: widget.question.picture ?? const Text(''),
        onTap: () => loadQuestionPage(widget.question),
      ),
    );
  }
}

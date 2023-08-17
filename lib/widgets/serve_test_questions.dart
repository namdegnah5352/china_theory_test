import 'package:china_theory_test/domain/entities/not_learnt.dart';
import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import '../screens/question_test.dart';
import '../config/navigation/global_nav.dart';
import '../config/constants.dart';

GlobalNav globalNav = GlobalNav.instance;

class ServeTestQuestions extends StatefulWidget {
  const ServeTestQuestions(this.questions, this.finishTest, {super.key});
  final List<Question> questions;
  final Function finishTest;
  @override
  State<ServeTestQuestions> createState() => _ServeTestQuestionsState();
}

class _ServeTestQuestionsState extends State<ServeTestQuestions> {
  int index = 0;
  int mark = 0;
  void increaseIndex(String value) {
    setState(() {
      markQuestion(widget.questions[index], value);
      index++;
      if (index == widget.questions.length) {
        widget.finishTest(AppConstants.questionsFinished, mark);
        Navigator.of(context).pop();
      }
    });
  }

  void markQuestion(Question question, String value) {
    if (value == question.answer) {
      mark++;
    } else {
      globalNav.notLearts.addNotLearnt(question.id);
    }
  }

  void markLogicQuestion(Question question, String value) {}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(child: Text('Serve')),
          const SizedBox(height: 5),
          QuestionTest(widget.questions[index], increaseIndex),
        ],
      ),
    );
  }
}

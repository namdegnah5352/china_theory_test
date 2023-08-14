import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../screens/question_list_tile.dart';
import '../config/navigation/global_nav.dart';
import '../domain/entities/question.dart';

GlobalNav globalNav = GlobalNav.instance;

class SubSectionQuestions extends StatefulWidget {
  const SubSectionQuestions(this.questions, {super.key});
  final List<Question> questions;

  @override
  State<SubSectionQuestions> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SubSectionQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(AppConstants.appBarOpacity),
      ),
      body: SafeArea(child: buildPage()),
    );
  }

  Widget buildPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            ListView.builder(
                itemCount: widget.questions.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final question = widget.questions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: QuestionListTile(question),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

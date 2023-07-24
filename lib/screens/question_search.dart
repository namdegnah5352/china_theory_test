import 'package:china_theory_test/config/constants.dart';
import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import 'question_list_tile.dart';
import '../calls/question_calls.dart';
import 'question_screen.dart';
import 'app_drawer.dart';
import '../config/navigation/global_nav.dart';

GlobalNav globalNav = GlobalNav.instance;

class QuestionSearch extends StatefulWidget {
  const QuestionSearch({super.key});

  @override
  State<QuestionSearch> createState() => _QuestionSearchState();
}

class _QuestionSearchState extends State<QuestionSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(AppConstants.appBarOpacity),
        title: const Text('Questions'),
        actions: [
          IconButton(
            onPressed: () async {
              Question question = getRandomQuestion();
              await loadQuestionPage(question);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                globalNav.questions!.shuffle();
              });
            },
            icon: const Icon(Icons.shuffle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              ListView.builder(
                itemCount: globalNav.questions!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Question question = globalNav.questions![index];
                  return QuestionListTile(question);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

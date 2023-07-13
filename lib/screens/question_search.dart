import 'package:flutter/material.dart';
import '../data/question.dart';
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
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Questions'),
        actions: [
          IconButton(
            onPressed: () {
              Question question = getRandomQuestion();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionScreen(question)));
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

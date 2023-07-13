import 'package:flutter/material.dart';
import '../data/question.dart';
import 'question_list_tile.dart';
import '../calls/question_calls.dart';
import 'question_screen.dart';
import 'app_drawer.dart';

class QuestionSearch extends StatefulWidget {
  final List<Question> questions;
  const QuestionSearch(this.questions, {super.key});

  @override
  State<QuestionSearch> createState() => _QuestionSearchState();
}

class _QuestionSearchState extends State<QuestionSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(widget.questions),
      appBar: AppBar(
        title: const Text('Questions'),
        actions: [
          IconButton(
            onPressed: () {
              Question question = getRandomQuestion(widget.questions);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionScreen(question, widget.questions)));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.questions.shuffle();
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
                itemCount: widget.questions.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Question question = widget.questions[index];
                  return QuestionListTile(question, widget.questions);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/question.dart';
import '../calls/search_calls.dart' as calls;
import '../config/app_colors.dart';
import '../config/text_styles.dart';
import '../screens/question_list_tile.dart';

class SpecialScreen extends StatefulWidget {
  const SpecialScreen({required this.questions, super.key});
  final List<Question> questions;

  @override
  State<SpecialScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SpecialScreen> {
  @override
  void initState() {
    super.initState();
    calls.fulldata = widget.questions;
    calls.specialInput();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: buttonFast,
                title: Text(
                  "Special Questions",
                  style: unfocussed,
                ),
              ),
            ]),
        body: SafeArea(child: buildPage()),
      ),
    );
  }

  Widget buildPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Flexible(
          child: ListView.builder(
              itemCount: calls.noItemsToShow(),
              itemBuilder: (context, index) {
                final question = calls.results[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: QuestionListTile(question, widget.questions),
                );
              }),
        ),
      ],
    );
  }
}

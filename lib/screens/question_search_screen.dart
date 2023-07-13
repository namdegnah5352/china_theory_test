import 'package:flutter/material.dart';
import '../data/question.dart';
import '../calls/search_calls.dart' as calls;
import '../config/app_colors.dart';
import '../config/text_styles.dart';
import '../screens/question_list_tile.dart';

class QuestionSearchScreen extends StatefulWidget {
  const QuestionSearchScreen({required this.data, super.key});
  final List<Question> data;

  @override
  State<QuestionSearchScreen> createState() => _PasswordSearchScreenState();
}

class _PasswordSearchScreenState extends State<QuestionSearchScreen> {
  late final _searchTextController = TextEditingController();
  void _validationComplete() {
    setState(() {
      calls.userInput(_searchTextController.text);
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    calls.fulldata = widget.data;
    _searchTextController.addListener(_validationComplete);
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
                  "SEARCH QUESTIONS",
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
        _getSearchTop(context),
        const SizedBox(height: 20),
        Flexible(
          child: ListView.builder(
              itemCount: calls.noItemsToShow(),
              itemBuilder: (context, index) {
                final question = calls.results[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: QuestionListTile(question, widget.data),
                );
              }),
        ),
      ],
    );
  }

  Widget _getSearchTop(BuildContext context) {
    Widget notMobileBox = SizedBox(
      height: 50,
      child: Column(
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10),
            ],
          ),
          searchBox(),
        ],
      ),
    );
    return notMobileBox;
  }

  Widget searchBox() {
    return Row(
      children: [
        const SizedBox(width: 10),
        LimitedBox(
          maxWidth: MediaQuery.of(context).size.width - 20,
          maxHeight: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _searchTextController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black45,
                ),
                hintText: "Enter start or part of description",
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45, width: 0.5)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

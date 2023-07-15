import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../calls/search_calls.dart' as calls;
import '../screens/question_list_tile.dart';
import '../config/navigation/global_nav.dart';

GlobalNav globalNav = GlobalNav.instance;

class QuestionSearchScreen extends StatefulWidget {
  const QuestionSearchScreen({super.key});

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
    calls.fulldata = globalNav.questions!;
    _searchTextController.addListener(_validationComplete);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(AppConstants.appBarOpacity),
        title: const Text('Search Questions'),
      ),
      body: SafeArea(child: buildPage()),
    );
  }

  Widget buildPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getSearchTop(context),
            const SizedBox(height: 20),
            ListView.builder(
                itemCount: calls.noItemsToShow(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final question = calls.results[index];
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

  Widget _getSearchTop(BuildContext context) {
    Widget notMobileBox = SizedBox(
      height: 60,
      child: Column(
        children: [
          const SizedBox(height: 10),
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
          maxWidth: MediaQuery.of(context).size.width - 60,
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

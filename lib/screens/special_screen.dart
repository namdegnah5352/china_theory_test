import 'package:flutter/material.dart';
import '../calls/search_calls.dart' as calls;
import '../config/app_colors.dart';
import '../config/text_styles.dart';
import '../screens/question_list_tile.dart';
import '../config/navigation/global_nav.dart';

GlobalNav globalNav = GlobalNav.instance;

class SpecialScreen extends StatefulWidget {
  const SpecialScreen({super.key});

  @override
  State<SpecialScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SpecialScreen> {
  @override
  void initState() {
    super.initState();
    calls.fulldata = globalNav.questions!;
    calls.specialInput();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specials'),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.25),
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
}

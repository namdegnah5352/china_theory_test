import 'package:china_theory_test/domain/entities/not_learnt.dart';
import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../screens/question_list_tile.dart';
import '../config/navigation/global_nav.dart';
import '../domain/entities/question.dart';
import '../domain/entities/sub_section.dart';
import '../calls/app_calls.dart';
import '../widgets/change_status_dialog.dart';

GlobalNav globalNav = GlobalNav.instance;

class SubSectionQuestions extends StatefulWidget {
  const SubSectionQuestions(this.questions, this.subSection, {super.key});
  final List<Question> questions;
  final SubSection subSection;

  @override
  State<SubSectionQuestions> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SubSectionQuestions> {
  late String showValue;

  @override
  void initState() {
    showValue = globalNav.sharedPreferences!.getString(AppConstants.notLeartSettingsKey)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subsection Questions',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          IconButton.filled(
            onPressed: () async {
              await loadTestStart(widget.subSection.questions, AppConstants.finalTestFalse);
            },
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primaryContainer),
          ),
          ChangeStatusDialog(widget.subSection.questions),
        ],
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
                  final notLearnt = globalNav.notLearts.find(question.id);
                  if (notLearnt != null) {
                    if (notLearnt.code == showValue) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: QuestionListTile(question),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  }
                  return null;
                }),
          ],
        ),
      ),
    );
  }
}

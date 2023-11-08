import 'package:china_theory_test/domain/entities/not_learnt.dart';
import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import '../screens/test/question_test.dart';
import '../config/navigation/global_nav.dart';
import '../config/constants.dart';
import '../calls/test_calls.dart' as testcalls;
import '../calls/app_calls.dart' as appcalls;
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';

GlobalNav globalNav = GlobalNav.instance;

class ServeTestQuestions extends StatefulWidget {
  const ServeTestQuestions(this.questions, this.popMaster, {super.key});
  final List<Question> questions;
  final Function popMaster;
  @override
  State<ServeTestQuestions> createState() => _ServeTestQuestionsState();
}

class _ServeTestQuestionsState extends State<ServeTestQuestions> {
  @override
  void initState() {
    shuffle(widget.questions);
    super.initState();
  }

  int index = 0;

  void increaseIndex(String value) async {
    markQuestion(widget.questions[index], value);
    index++;
    if (index == widget.questions.length) {
      widget.popMaster();
      await appcalls.loadTestResults();
    } else {
      setState(() {});
    }
  }

  void markQuestion(Question question, String value) async {
    testcalls.noQuestionsDone++;
    if (value == question.answer) {
      testcalls.mark++;
    } else {
      // Play Sound
      if (globalNav.sharedPreferences!.getBool(AppConstants.soundsKey)!) {
        final player = AudioPlayer();
        await player.play(AssetSource('media/Doh.mp3'), mode: PlayerMode.lowLatency, volume: AppConstants.volumeSetting);
      }

      globalNav.notLearts.changeStatus(question.id, AppConstants.notLearnt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          QuestionTest(widget.questions[index], increaseIndex),
        ],
      ),
    );
  }
}

import 'package:china_theory_test/domain/entities/not_learnt.dart';
import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import '../config/navigation/global_nav.dart';
import '../config/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import '../domain/entities/special.dart';

GlobalNav globalNav = GlobalNav.instance;

class QuestionScreen extends StatefulWidget {
  final Question question;
  const QuestionScreen(this.question, {super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late TextEditingController controller;
  bool ans = false;
  late bool truthSettings;
  late bool soundSettings;
  late bool specialSettings;
  late bool notLearnt;
  final double volumeSetting = 0.05;

  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.question.questionText;
    truthSettings = globalNav.sharedPreferences!.getBool(AppConstants.truthSettingsKey)!;
    soundSettings = globalNav.sharedPreferences!.getBool(AppConstants.soundsKey)!;
    specialSettings = widget.question.special != null;
    notLearnt = globalNav.notLearts.isNotLearnt(widget.question.id);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question Screen')),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              switch (widget.question.type[0]) {
                'P' => widget.question.getPicture(150, true, context)!,
                _ => const SizedBox(height: 1, width: 1),
              },
              TextField(
                readOnly: true,
                controller: controller,
                maxLines: 4,
              ),
              switch (widget.question.type) {
                'P' => getFourAnswers(widget.question),
                'Plogic' || 'Logic' => getLogicAnswer(widget.question),
                _ => getFourAnswers(widget.question),
              },
              const SizedBox(height: 20),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: ans ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: Colors.black54),
                ),
                child: ans
                    ? const Center(
                        child: Text(
                        'Correct',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                      ))
                    : const SizedBox(height: 1, width: 1),
              ),
              const SizedBox(height: 15),
              getNextButton(),
              const SizedBox(height: 15),
              getSpecial(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSpecial() {
    return SwitchListTile(
      title: const Text('Special'),
      value: specialSettings,
      onChanged: (value) {
        switch (value) {
          case true:
            Special special = Special(id: widget.question.id, code: AppConstants.specialCode);
            GlobalNav.instance.specials.addSpecial(special);
            widget.question.special = special;
          case false:
            GlobalNav.instance.specials.removeSpecial(widget.question.special!);
            widget.question.special = null;
        }
        setState(() {
          specialSettings = value;
        });
      },
    );
  }

  Widget getLogicAnswer(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        getLogicButton(question.answer, 'True'),
        const SizedBox(height: 20),
        getLogicButton(question.answer, 'False'),
      ],
    );
  }

  Widget getFourAnswers(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        getButton('A', widget.question.a),
        const SizedBox(height: 20),
        getButton('B', widget.question.b),
        const SizedBox(height: 20),
        getButton('C', widget.question.c),
        const SizedBox(height: 20),
        getButton('D', widget.question.d),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget getLogicButton(String value, String question) {
    return FilledButton.tonal(
      onPressed: () {
        setState(() {
          ans = question.toLowerCase() == value.toLowerCase();
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all<Color>(
            truthSettings && question.toLowerCase() == value.toLowerCase() ? Colors.green : Colors.blue),
      ),
      child: Text(
        question,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getButton(String value, String question) {
    return FilledButton.tonal(
      onPressed: () async {
        setState(() {
          ans = widget.question.answer == value;
        });
        if ((ans == false) && soundSettings) {
          final player = AudioPlayer();
          await player.play(AssetSource('media/Doh.mp3'), mode: PlayerMode.lowLatency, volume: volumeSetting);
        }
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
        alignment: Alignment.center,
        backgroundColor:
            MaterialStateProperty.all<Color>(truthSettings && widget.question.answer == value ? Colors.green : Colors.blue),
      ),
      child: Text(
        question,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget getStatusDropdown() {}
  Widget getNextButton() {
    return SizedBox(
      height: 50,
      child: FilledButton.tonal(
        onPressed: (notLearnt)
            ? () {
                setState(() {
                  globalNav.notLearts.removeNotLearnt(widget.question.id);
                  notLearnt = !notLearnt;
                });
              }
            : () {
                setState(() {
                  globalNav.notLearts.addNotLearnt(widget.question.id);
                  notLearnt = !notLearnt;
                });
              },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all<Color>(notLearnt ? Colors.green : Colors.blueGrey),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(width: notLearnt ? 3 : 1),
          )),
        ),
        child: Text(
          notLearnt ? 'Not Learnt' : 'Learnt',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: notLearnt ? const TextStyle(color: Colors.black, fontSize: 20) : const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

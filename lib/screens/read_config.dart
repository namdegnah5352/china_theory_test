import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import '../domain/entities/section.dart';
import '../domain/entities/sub_section.dart';
import 'package:flutter/services.dart';
// import 'question_search.dart';
import 'sections_screen.dart';
import '../domain/entities/special.dart';
import '../domain/entities/not_learnt.dart';
import '../config/navigation/global_nav.dart';
import '../config/constants.dart';
import 'package:collection/collection.dart';

GlobalNav globalNav = GlobalNav.instance;

class ReadConfig extends StatefulWidget {
  const ReadConfig({Key? key}) : super(key: key);

  @override
  State<ReadConfig> createState() => _ReadConfigState();
}

class _ReadConfigState extends State<ReadConfig> {
  Future<List<Question>> loadJsonData(BuildContext context) async {
    var jsonText = await rootBundle.loadString('assets/json/traffic_signs.json');
    List<Question> data = questionModelFromJson(jsonText);
    globalNav.specials = specialModelFromJson(globalNav.sharedPreferences!.getString(AppConstants.specialKey)!);
    globalNav.notLearts = notLearntModelFromJson(globalNav.sharedPreferences!.getString(AppConstants.notLearntKey)!);
    if (globalNav.notLearts.isEmpty) {
      globalNav.notLearts.addAllAsNotLearnt(data);
    }
    for (var question in data) {
      question.picture = question.getPicture(50, false, null);
      question.special = globalNav.specials.firstWhereOrNull((element) => element.id == question.id);
    }
    globalNav.questions = data;
    print('The number of questions done is ${data.length} out of 1350');
    globalNav.sections = sectionModelFromJson(jsonText);
    for (var section in globalNav.sections) {
      section.subsections = subSectionModelFromJson(jsonText, int.parse(section.id));
      for (var subsection in section.subsections) {
        subsection.loadQuestions(globalNav.questions!);
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
        future: loadJsonData(context),
        builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
          if (snapshot.hasData) {
            return const SectionsScreen();
          } else {
            return loadingScreen(context);
          }
        });
  }
}

Widget loadingScreen(BuildContext context) {
  return Scaffold(
    body: Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(50),
      child: const Text('loading'),
    ),
  );
}

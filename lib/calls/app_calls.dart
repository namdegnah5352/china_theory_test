import 'package:china_theory_test/domain/entities/not_learnt.dart';
import 'package:collection/collection.dart';
import '../domain/entities/section.dart';
import '../domain/entities/question.dart';
import 'dart:math';
import '../config/navigation/global_nav.dart';
import '../config/navigation/navigation_paths.dart';
import '../domain/entities/sub_section.dart';
import 'dart:async';

GlobalNav globalNav = GlobalNav.instance;

Question getRandomQuestion() {
  int i = globalNav.questions!.length;
  var random = Random();
  int r = random.nextInt(i);
  return globalNav.questions![r];
}

Future<void> loadSearchPage() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.search);
}

Future<void> loadSettinsPage() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.settings);
}

Future<void> loadSpecialPage() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.special);
}

Future<void> loadHomePage() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.home);
}

Future<void> loadQuestionPage(Question question) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.question, arguments: question);
}

Future<void> loadSubSection(List<SubSection> subsections, Section section) async {
  ({List<SubSection> subsections, Section section}) listParts;
  listParts = (subsections: section.subsections, section: section);
  await globalNav.appNavigation.pushNamed(NavigationPaths.subSection, arguments: listParts);
}

Future<void> loadSubSectionQuestions(List<Question> questions) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.subSectionQuestion, arguments: questions);
}

Future<void> loadTestStart(List<Question> questions) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.testStart, arguments: questions);
}

// int count = 0;
void tickleMe(Function toTickle) {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    // count++;
    // toTickle(count);
    // if (count == 1111111) timer.cancel();
  });
}

List<Question> filterQuestions(List<Question> questions) {
  NotLearnt? answer;
  List<Question> result = [];
  for (var question in questions) {
    answer = globalNav.notLearts.firstWhereOrNull((element) => element.id == question.id);
    if (answer == null) {
      result.add(question);
    }
  }
  return result;
}
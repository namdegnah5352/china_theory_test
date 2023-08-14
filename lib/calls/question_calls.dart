import '../domain/entities/question.dart';
import 'dart:math';
import '../config/navigation/global_nav.dart';
import '../config/navigation/navigation_paths.dart';
import '../domain/entities/sub_section.dart';

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

Future<void> loadSubSection(List<SubSection> subSections) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.subSection, arguments: subSections);
}

Future<void> loadSubSectionQuestions(List<Question> questions) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.subSectionQuestion, arguments: questions);
}

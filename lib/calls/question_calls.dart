import '../data/question.dart';
import 'dart:math';
import '../config/navigation/global_nav.dart';
import '../config/navigation/navigation_paths.dart';

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

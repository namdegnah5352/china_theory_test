import '../data/question.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../screens/question_search_screen.dart';
import '../screens/settings.dart';
import '../screens/special_screen.dart';
import '../config/navigation/global_nav.dart';

GlobalNav globalNav = GlobalNav.instance;

Question getRandomQuestion() {
  int i = globalNav.questions!.length;
  var random = Random();
  int r = random.nextInt(i);
  return  globalNav.questions![r];
}

Future<void> loadSearchPage(BuildContext context) async {
  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuestionSearchScreen()));
}

Future<void> loadSettinsPage(BuildContext context) async {
  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Settings()));
}

Future<void> loadSpecialPage(BuildContext context) async {
  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SpecialScreen()));
}

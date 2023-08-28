import 'package:flutter/material.dart';
import 'navigation_paths.dart';
import '../../screens/settings.dart';
import '../../screens/special_screen.dart';
import '../../screens/question_search_screen.dart';
import '../../screens/read_config.dart';
import '../../screens/question_screen.dart';
import '../../domain/entities/question.dart';
import '../../screens/sub_section_screen.dart';
import '../../domain/entities/sub_section.dart';
import '../../screens/sub_section_questions.dart';
import '../../screens/test/test_screen.dart';
import '../../domain/entities/section.dart';
import '../../screens/test/test_go.dart';
import '../../screens/test/test_result.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    var arg = settings.arguments;

    switch (settings.name) {
      case NavigationPaths.settings:
        return MaterialPageRoute(
          builder: (_) => const Settings(),
        );
      case NavigationPaths.special:
        return MaterialPageRoute(
          builder: (_) => const SpecialScreen(),
        );
      case NavigationPaths.search:
        return MaterialPageRoute(
          builder: (_) => const QuestionSearchScreen(),
        );
      case NavigationPaths.question:
        return MaterialPageRoute(
          builder: (_) => QuestionScreen(arg as Question),
        );
      case NavigationPaths.home:
        return MaterialPageRoute(
          builder: (_) => const ReadConfig(),
        );
      case NavigationPaths.subSection:
        ({List<SubSection> subsections, Section section}) listParts;
        listParts = arg as ({List<SubSection> subsections, Section section});
        return MaterialPageRoute(
          builder: (_) => SubSectionScreen(listParts.subsections, listParts.section),
        );
      case NavigationPaths.subSectionQuestion:
        return MaterialPageRoute(
          builder: (_) => SubSectionQuestions(arg as List<Question>),
        );
      case NavigationPaths.testStart:
        return MaterialPageRoute(
          builder: (_) => TestScreen(arg as List<Question>),
        );
      case NavigationPaths.testResults:
        return MaterialPageRoute(
          builder: (_) => const TestResult(),
        );
      case NavigationPaths.testGo:
        ({List<Question> questions, int noSeconds, Function popMaster}) listParts;
        listParts = arg as ({List<Question> questions, int noSeconds, Function popMaster});
        return MaterialPageRoute(
          builder: (_) => TestGo(listParts.questions, listParts.noSeconds, listParts.popMaster),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ReadConfig(),
        );
    }
  }
}

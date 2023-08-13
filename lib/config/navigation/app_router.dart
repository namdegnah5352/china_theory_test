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
        return MaterialPageRoute(
          builder: (_) => SubSectionScreen(arg as List<SubSection>),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ReadConfig(),
        );
    }
  }
}

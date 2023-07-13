import 'package:flutter/material.dart';
import 'navigation_paths.dart';
import '../../screens/settings.dart';
import '../../screens/special_screen.dart';
import '../../screens/question_search_screen.dart';
import '../../data/read_config.dart';

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
      default:
        return MaterialPageRoute(
          builder: (_) => const ReadConfig(),
        );
    }
  }
}

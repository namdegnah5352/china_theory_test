import '../config/constants.dart';
import '../domain/entities/question.dart';
import '../config/navigation/global_nav.dart';
import '../domain/entities/not_learnt.dart';

GlobalNav globalNav = GlobalNav.instance;

late String showValue;
late String learntValue;
late List<Question> _fulldata;
late List<Question> _results;
List<Question> get results => _results;
List<Question> get fulldata => _fulldata;
set fulldata(List<Question> data) => _results = _fulldata = data;
void initialise() {}

void userInput(String criteria) {
  if (criteria.isEmpty) {
    _results = _fulldata;
  } else {
    _results = _fulldata.where((data) => _getSearchResult(data, criteria)).toList();
  }
}

void showQuestionInput() {
  showValue = globalNav.sharedPreferences!.getString(AppConstants.notLeartSettingsKey)!;
  _results = _fulldata.where((question) => _getShowResult(question, showValue)).toList();
}

bool _getShowResult(Question question, String match) {
  learntValue = globalNav.notLearts.find(question.id)!.code;
  return learntValue == showValue;
}

void specialInput() {
  _results = _fulldata.where((question) => _getSpecialResult(question)).toList();
}

bool _getSpecialResult(Question question) {
  return question.special != null && _getSearchResult(question, '');
}

bool _getSearchResult(Question question, String criteria) {
  bool result = false;
  var answers = switch (question.answer) {
    'A' => question.a,
    'B' => question.b,
    'C' => question.c,
    'D' => question.d,
    _ => '',
  };
  var criteriaPartsPassed = true;
  var parts = criteria.split(' ');
  var searchString = '${answers.toLowerCase()} ${question.questionText.toLowerCase()}';
  for (var criteriaPart in parts) {
    RegExp regExp = RegExp(r"\b" + criteriaPart + r"\b");
    if (!regExp.hasMatch(searchString)) criteriaPartsPassed = false;
  }
  bool includeQuestion = switch (GlobalNav.instance.sharedPreferences!.getBool(AppConstants.truthSettingsKey)!) {
    false => true,
    true => question.answer.toLowerCase() == 'true' || question.answer.toLowerCase() != 'false' ? true : false,
  };
  result = criteriaPartsPassed || searchString.contains(criteria.toLowerCase());
  result = result && includeQuestion;
  return result;
}

int noItemsToShow() {
  return _results.length;
}

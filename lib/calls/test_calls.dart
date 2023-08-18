import 'app_calls.dart' as appcalls;
import '../config/constants.dart';

int _mark;

set mark(int mark) => _mark = mark;
int get mark => _mark;

void finishTest(bool method, int? mark) async {
  if (method == AppConstants.questionsFinished) {
    //appcalls.resetCounter();
    print('Test Finished Questions done');
  }
}

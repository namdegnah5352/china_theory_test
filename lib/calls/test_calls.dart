import '../config/constants.dart';

int _mark = 0;

set mark(int mark) => _mark = mark;
int get mark => _mark;

void finishTest(bool method, int? mark) async {
  if (method == AppConstants.questionsFinished) {
    //appcalls.resetCounter();
    print('Test Finished Questions done');
  }
}

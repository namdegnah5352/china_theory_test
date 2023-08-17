import 'app_calls.dart' as appcalls;
import '../config/constants.dart';

void finishTest(bool method, int? mark) async {
  if (method == AppConstants.questionsFinished) {
    //appcalls.resetCounter();
    print('Test Finished Questions done');
  }
}

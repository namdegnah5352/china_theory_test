import 'package:flutter/material.dart';

class AppConstants {
  //specials
  static const specialKey = 'specialKey';

  static const specialStart = '{"special": []}';
  static const specialCode = 'S';
  //notLearnt
  static const notLearntKey = 'notLearntKey';
  static const notLearntStart = '{"notLearnt": []}';
  static const notLearnt = 'NotLearnt';
  static const stashed = 'Stashed';
  static const learnt = 'Learnt';
  static const notLeartSettingsKey = 'notLeartSettingsKey';
  static const notLearntSettingDefault = false;
  static const notLearntSettingsAll = false;
  static const notLearntSettingsOnlyNotLearnt = true;
  //truth
  static const truthSettingsKey = 'truthSettingsKey';
  static const truthSettings = false;
  //sounds
  static const soundsKey = 'soundsKey';
  static const sounds = false;
  static const volumeSetting = 0.05;
  //visual
  static const appBarOpacity = 0.4;
  static const questionsFinished = true;
  static const timerFinished = false;
  //random answers
  static const randomAnswersKey = 'randomAnswersKey';
  static const randomAnswersDefault = false;
  //layout options
  static const questionLineMax = 8;
  static const questionAnswerLineMax = 3;
  //big final test
  static const finalTestTrue = true;
  static const finalTestFalse = false;
}

List<DropdownMenuItem<String>> get quantities {
  List<DropdownMenuItem<String>> quantities = const [
    DropdownMenuItem(
      value: AppConstants.learnt,
      child: Text(AppConstants.learnt),
    ),
    DropdownMenuItem(
      value: AppConstants.notLearnt,
      child: Text(AppConstants.notLearnt),
    ),
    DropdownMenuItem(
      value: AppConstants.stashed,
      child: Text(AppConstants.stashed),
    ),
  ];
  return quantities;
}

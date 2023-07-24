import 'dart:convert';
import 'package:flutter/material.dart';

List<LogicQuestion> logicQuestionModelFromJson(String str) =>
    List<LogicQuestion>.from(json.decode(str)["logic"].map((x) => LogicQuestion.fromJson(x)));
String logicQuestionModelToJson(List<LogicQuestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogicQuestion {
  LogicQuestion({
    required this.questionText,
    required this.id,
    required this.answer,
  });
  late final String questionText;
  late final String id;
  late final String answer;
  Image? picture;

  LogicQuestion.fromJson(Map<String, dynamic> json) {
    questionText = json['Q'];
    id = json['Id'];
    answer = json['Answer'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Q'] = questionText;
    data['Id'] = id;
    data['Answer'] = answer;
    return data;
  }

  Image? getPicture(double size) {
    var file = 'assets/images/$id.png';
    return switch (questionText) {
      'Picture' || 'PictureV' || 'PictureO' => getImage(file, size),
      _ => null,
    };
  }

  Image getImage(String file, double size) {
    return Image.asset(
      file,
      fit: BoxFit.fitHeight,
      height: size,
    );
  }
}

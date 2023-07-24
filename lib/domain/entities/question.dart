import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'special.dart';

List<Question> questionModelFromJson(String str) =>
    List<Question>.from(json.decode(str)["question"].map((x) => Question.fromJson(x)));
String questionModelToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    required this.questionText,
    required this.id,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.answer,
    required this.type,
  });
  late final String questionText;
  late final String id;
  late final String a;
  late final String b;
  late final String c;
  late final String d;
  late final String answer;
  late final String type;
  Widget? picture;
  Special? special;

  Question.fromJson(Map<String, dynamic> json) {
    questionText = json['Q'];
    id = json['Id'];
    a = json['A'] ??= '';
    b = json['B'] ??= '';
    c = json['C'] ??= '';
    d = json['D'] ??= '';
    answer = json['Answer'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Q'] = questionText;
    data['Id'] = id;
    data['A'] = a;
    data['B'] = b;
    data['C'] = c;
    data['D'] = d;
    data['Answer'] = answer;
    data['Type'] = type;
    return data;
  }

  Widget? getPicture(double size, bool pinchable, BuildContext? context) {
    var file = 'assets/images/questions/$id.png';
    return switch (type[0]) {
      'P' => getImage(file, size, pinchable, context),
      _ => null,
    };
  }

  Widget getImage(String file, double size, bool pinchable, BuildContext? context) {
    Image image = Image.asset(file, fit: BoxFit.fitHeight, height: size);

    return switch (pinchable) {
      false => image,
      true => LimitedBox(
          maxHeight: size,
          maxWidth: MediaQuery.of(context!).size.width - 40,
          child: PhotoView(
            imageProvider: AssetImage(file),
            backgroundDecoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
    };
  }
}

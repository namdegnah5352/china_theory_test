import 'dart:convert';
import 'question.dart';

List<SubSection> subSectionModelFromJson(String str, int id) =>
    List<SubSection>.from(json.decode(str)['subsection$id'].map((x) => SubSection.fromJson(x)));
// SubSection subsectionFromJson(String str, int id) => SubSection.fromJson(json.decode(str)['subsection$id']);
String subSectionModelToJson(List<SubSection> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubSection {
  SubSection({
    required this.id,
    required this.value,
    required this.mcnoq,
    required this.jqnoq,
  });
  late final String id;
  late final String value;
  late final int mcnoq;
  late final int jqnoq;
  List<Question> questions = [];

  SubSection.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    value = json['value'];
    mcnoq = json['mcnoq'];
    jqnoq = json['jqnoq'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = id;
    data['value'] = value;
    data['mcnoq'] = mcnoq;
    data['jqnoq'] = jqnoq;
    return data;
  }

  void loadQuestions(List<Question> questions) {
    //multiple choice questions
    for (var i = 1; i <= mcnoq; i++) {
      String questionId = '$id.1.$i';
      this.questions.add(questions.firstWhere((element) => element.id == questionId));
    }
    //judegment questions
    for (var i = 1; i <= jqnoq; i++) {
      String questionId = '$id.2.$i';
      this.questions.add(questions.firstWhere((element) => element.id == questionId));
    }
  }
}

import 'dart:convert';
import 'package:collection/collection.dart';
import '../../config/constants.dart';
import 'question.dart';
import '../../config/navigation/global_nav.dart';

List<NotLearnt> notLearntModelFromJson(String str) =>
    List<NotLearnt>.from(json.decode(str)["notLearnt"].map((x) => NotLearnt.fromJson(x)));
String notLearntModelToJson(List<NotLearnt> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotLearnt {
  NotLearnt({
    required this.id,
    required this.code,
  });
  late final String id;
  late final String code;

  NotLearnt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['"id"'] = '"$id"';
    data['"code"'] = '"$code"';
    return data;
  }
}

extension NotLearnts on List<NotLearnt> {
  void addNotLearnt(String id) {
    NotLearnt notLearnt = NotLearnt(id: id, code: AppConstants.notLeartCode);
    add(notLearnt);
    save();
  }

  void removeNotLearnt(String id) {
    NotLearnt toRemove = firstWhere((element) => element.id == id);
    remove(toRemove);
    save();
  }

  void save() {
    String ans = '{"notLearnt": [';
    for (var notLearnt in this) {
      ans += notLearnt.toJson().toString();
      ans += ',';
    }
    ans = ans.substring(0, ans.length - 1);
    ans += ']}';
    GlobalNav.instance.sharedPreferences!.setString(AppConstants.notLearntKey, ans);
  }

  void addAllAsNotLearnt(List<Question> questions) {
    String ans = '{"notLearnt": [';
    for (var question in questions) {
      ans += question.getNotLearnt().toString();
      ans += ',';
    }
    ans = ans.substring(0, ans.length - 1);
    ans += ']}';
    GlobalNav.instance.sharedPreferences!.setString(AppConstants.notLearntKey, ans);
  }

  bool isNotLearnt(String id) {
    NotLearnt? ans = firstWhereOrNull((element) => element.id == id);
    if (ans == null) return false;
    return true;
  }
}

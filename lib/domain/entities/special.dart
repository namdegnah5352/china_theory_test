import 'dart:convert';
import '../../config/constants.dart';

import '../../config/navigation/global_nav.dart';

List<Special> specialModelFromJson(String str) => List<Special>.from(json.decode(str)["special"].map((x) => Special.fromJson(x)));
String questionModelToJson(List<Special> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Special {
  Special({
    required this.id,
    required this.code,
  });
  late final String id;
  late final String code;

  Special.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['"id"'] = '"$id"';
    _data['"code"'] = '"$code"';
    return _data;
  }
}

extension Specials on List<Special> {
  void addSpecial(Special special) {
    add(special);
    save();
  }

  void removeSpecial(Special special) {
    Special toRemove = firstWhere((element) => element.id == special.id);
    remove(toRemove);
    save();
  }

  void save() {
    String ans = '{"special": [';
    for (var special in this) {
      ans += special.toJson().toString();
      ans += ',';
    }
    ans = ans.substring(0, ans.length - 1);
    ans += ']}';
    GlobalNav.instance.sharedPreferences!.setString(AppConstants.specialKey, ans);
  }
}

import 'dart:convert';

List<Section> sectionModelFromJson(String str) => List<Section>.from(json.decode(str)["section"].map((x) => Section.fromJson(x)));
String sectionModelToJson(List<Section> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Section {
  Section({
    required this.id,
    required this.value,
    required this.percent,
  });
  late final String id;
  late final String value;
  late final int percent;

  Section.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    value = json['value'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = id;
    data['value'] = value;
    data['percent'] = percent;
    return data;
  }
}

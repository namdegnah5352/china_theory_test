import 'dart:convert';

List<SubSection> subSectionModelFromJson(String str, int id) =>
    List<SubSection>.from(json.decode(str)['subsection$id'].map((x) => SubSection.fromJson(x)));
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
}

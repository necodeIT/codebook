import 'package:codebook/db/db.dart';

class Ingredient {
  Ingredient({required language, required String code, required List<String> tags, required String desc}) {
    _language = language;
    _code = code;
    _tags = List.from(tags);
    _desc = desc;
  }

  Ingredient.fromJson(Map<String, dynamic> model) {
    language = model["language"];
    code = model["code"];
    desc = model["desc"];
    _tags = [];
    for (var tag in model["tags"]) {
      tags.add(tag);
    }
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "desc": desc,
        "code": code,
        "tags": tags,
      };

  late String _language;
  late String _code;
  late String _desc;
  late List<String> _tags;

  String get language => _language;
  String get desc => _desc;
  String get code => _code;
  List<String> get tags => _tags;

  set language(String value) {
    _language = value;
    DB.update();
  }

  set code(String value) {
    _code = value;
    DB.update();
  }

  set desc(String value) {
    _desc = value;
    DB.update();
  }

  void addTag(String tag) {
    if (_tags.contains(tag)) return;
    _tags.add(tag);
    DB.update();
  }

  void rmTag(String tag) {
    if (!_tags.contains(tag)) return;
    _tags.remove(tag);
    DB.update();
  }
}

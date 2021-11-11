class Ingredient {
  Ingredient({required this.language, required this.code, required List<String> tags, required this.desc}) {
    _tags = List.from(tags);
  }

  Ingredient.fromJson(Map<String, dynamic> model) {
    language = model["language"];
    code = model["code"];
    desc = model["desc"];
    _tags = List.from(model["tags"]);
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "desc": desc,
        "code": code,
        "tags": tags,
      };

  late String language;
  late String code;
  late String desc;
  late List<String> _tags;

  List<String> get tags => _tags;

  void addTag(String tag) {
    if (_tags.contains(tag)) return;
    _tags.add(tag);
  }

  void rmTag(String tag) {
    if (!_tags.contains(tag)) return;
    _tags.remove(tag);
  }
}

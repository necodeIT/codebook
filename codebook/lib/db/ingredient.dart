import 'dart:convert';

import 'package:codebook/db/sync/sync.dart';
import 'package:crypto/crypto.dart';

class Ingredient {
  Ingredient({required String language, required String code, required List<String> tags, required String desc}) {
    _tags = List.from(tags);
    _code = code;
    _language = language;
    _desc = desc;
  }

  Ingredient.fromJson(Map<String, dynamic> model) {
    _language = model["language"];
    _code = model["code"];
    _desc = model["desc"];
    _tags = List.from(model["tags"], growable: true);
  }

  /// returns a sha256 hash of the ingredient (all attributes)
  /// this is used to uniquely identify an ingredient
  String get hash {
    String hash = '';
    hash += language;
    hash += code;
    for (String tag in tags) {
      hash += tag;
    }
    hash += desc;

    return sha256.convert(utf8.encode(hash)).toString();
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

  List<String> get tags => _tags;
  String get code => _code;
  String get desc => _desc;
  String get language => _language;

  set language(String value) {
    if (value == language) return;

    Sync.reportChange(this, () => _language = value);
  }

  set code(String value) {
    if (value == code) return;

    Sync.reportChange(this, () => _code = value);
  }

  set desc(String value) {
    if (value == desc) return;

    Sync.reportChange(this, () => _desc = value);
  }

  void addTag(String tag) {
    if (_tags.contains(tag)) return;

    Sync.reportChange(this, () => _tags.add(tag));
  }

  void rmTag(String tag) {
    if (!_tags.contains(tag)) return;

    Sync.reportChange(this, () => _tags.remove(tag));
  }

  void update({required String desc, required String lang, required List<String> tags, required String code}) {
    if (desc != this.desc && lang != language && tags.toSet().containsAll(_tags.toSet()) && code != this.code) return;
    Sync.reportChange(this, () {
      _desc = desc;
      _language = lang;
      _tags = tags;
      _code = code;
    });
  }
}

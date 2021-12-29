import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/sync/action_type.dart';
export 'action_type.dart';

class ActionLog {
  final Map<String, ActionType> _actionLog = {};
  Map<String, ActionType> get actionLog => _actionLog;

  /// takes in an ingredient and a action type (DEL/ADD)
  /// and hashes the ingredient and sotres the hash in a map together with the action type
  void write(Ingredient ingredient, ActionType action) {
    _actionLog[ingredient.hash] = action;
    save();
  }

  /// save the log to disk
  Future save() async {
    var f = await DB.logFile;

    await f.writeAsString(jsonEncode(_actionLog));
  }

  /// load the log from disk
  Future load() async {
    var f = await DB.logFile;

    if (!f.existsSync()) return;

    var json = await f.readAsString();

    _actionLog.addAll(jsonDecode(json));
  }

  void clear() {
    _actionLog.clear();
    save();
  }
}

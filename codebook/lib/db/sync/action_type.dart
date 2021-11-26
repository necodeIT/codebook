// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ActionType {
  static const String actionKey = 'action';

  ActionType(String action) {
    _action = action;
  }

  ActionType.fromJson(Map<String, dynamic> json) {
    _action = json[actionKey];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ActionType) {
      return _action == other._action;
    }
    return false;
  }

  @override
  int get hashCode => _action.hashCode;

  late final String _action;

  toJson() {
    return {actionKey: _action};
  }
}

final ADD = ActionType("ADD");
final DEL = ActionType("DEL");

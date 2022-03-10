import 'dart:math';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nekolib_ui/core.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showThemedSnackbar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: NcBodyText(message),
      backgroundColor: NcThemes.current.tertiaryColor,
    ),
  );
}

final connectivity = Connectivity();

final Client client = Client();

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final Random _rnd = Random();
String generateRndmString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

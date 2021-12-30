import 'dart:io';

import 'package:codebook/db/db.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Logger {
  static final logFileName = "session_${formatter.format(DateTime.now())}.log";
  static final DateFormat formatter = DateFormat('yyyy-MM-dd--HH-mm-ss');

  static Future log(String msg) async {
    if (kDebugMode) {
      print(msg);
    } else {
      var f = await logFile;
      f.writeAsStringSync("${formatter.format(DateTime.now())}:    $msg\n", mode: FileMode.append);
    }
  }

  static Future<Directory> get logDir async {
    var app = await DB.appDir;
    return Directory("${app.path}/logs").create();
  }

  static Future<File> get logFile async {
    var dir = await logDir;
    return File('${dir.path}/$logFileName');
  }
}

void log(Object msg) => Logger.log(msg.toString());

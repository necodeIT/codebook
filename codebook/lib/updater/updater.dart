import 'dart:convert';
import 'package:codebook/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:io';

class Updater {
  static const githubApiUrl = 'https://api.github.com/repos';
  static const repoOwner = "necodeIT";
  static const repoName = "codebook";
  static const repoUrl = "$githubApiUrl/$repoOwner/$repoName";

  static const appName = "CodeBook";
  static const version = "2.0.1";

  static var _latestVersion = "";
  static var _latestReleaseName = "";
  static var _updateAvailable = false;
  static var _setupDownloadUrl = "";
  static var _errorMessage = "";

  static String get latestVersion => _latestVersion;
  static String get latestVersionName => _latestReleaseName;
  static bool get updateAvailable => _updateAvailable;
  static String get setupDownloadUrl => _setupDownloadUrl;

  static Future init() async {
    _updateAvailable = await checkForUpdate();
  }

  /// Check for newer release on github https://api.github.com/repos/necodeIT/code-book/releases/latest
  static Future<bool> checkForUpdate() async {
    if (!await connectivity.checkConnection()) {
      _errorMessage = "Could not check for updates automatically, you may be using an outadet version! Please check your internet connection";
      return false;
    }

    var client = Client();

    try {
      var response = await client.get(Uri.parse("$repoUrl/releases/latest"));
      var json = jsonDecode(response.body);
      _latestVersion = json["tag_name"];
      _latestReleaseName = json["name"];
      // get asset download url with name WindowsSetup.exe
      var asset = json["assets"].firstWhere((asset) => asset["name"] == "WindowsSetup.exe");
      _setupDownloadUrl = asset["browser_download_url"];

      return latestVersion != version;
    } catch (e) {
      _errorMessage = "Error checking for upates: $e! If this error persists, please let us know by opening an issue on GitHub";

      return false;
    }
  }

  static void showErrorMessage(BuildContext context) {
    if (_errorMessage.isEmpty) return;

    showThemedSnackbar(context, _errorMessage);

    _errorMessage = "";
  }

  /// Download the setup file to temp folder
  static Future<String> upgrade(Function(int, int)? onReceiveProgress) async {
    var dio = Dio();
    var path = "${Directory.systemTemp.path}/$appName - $latestVersionName Setup.exe";
    await dio.download(_setupDownloadUrl, path, onReceiveProgress: onReceiveProgress);

    return path;
  }
}

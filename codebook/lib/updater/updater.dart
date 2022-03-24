import 'dart:convert';
import 'package:codebook/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:io';

/// A class that handles the update process.
class Updater {
  /// The url of the github api.
  static const githubApiUrl = 'https://api.github.com/repos';

  /// The repo owner of the app.
  static const repoOwner = "necodeIT";

  /// The repo name of the app.
  static const repoName = "codebook";

  /// The api url of the github repo.
  static const repoUrl = "$githubApiUrl/$repoOwner/$repoName";

  /// The name of the app.
  static const appName = "CodeBook";

  /// The current version of the app.
  static const version = "2.1.3";

  static var _latestVersion = "";
  static var _latestReleaseName = "";
  static var _updateAvailable = false;
  static var _setupDownloadUrl = "";
  static var _errorMessage = "";

  /// The latest version available on github of the app.
  static String get latestVersion => _latestVersion;

  /// The latest release name available on github of the app.
  static String get latestVersionName => _latestReleaseName;

  /// Whether a new update is available.
  static bool get updateAvailable => _updateAvailable;

  /// The url to download the update from.
  static String get setupDownloadUrl => _setupDownloadUrl;

  /// Initializes the updater.
  static Future init() async {
    _updateAvailable = await checkForUpdate();
  }

  /// Checks for newer release on github https://api.github.com/repos/necodeIT/code-book/releases/latest
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

  /// Shows a snackbar containing the error message.
  static void showErrorMessage(BuildContext context) {
    if (_errorMessage.isEmpty) return;

    showThemedSnackbar(context, _errorMessage);

    _errorMessage = "";
  }

  /// Downloads the setup file to temp folder
  static Future<String> upgrade(Function(int, int)? onReceiveProgress) async {
    var dio = Dio();
    var path = "${Directory.systemTemp.path}/$appName - $latestVersionName Setup.exe";
    await dio.download(_setupDownloadUrl, path, onReceiveProgress: onReceiveProgress);

    return path;
  }
}

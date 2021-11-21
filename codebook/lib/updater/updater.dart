import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart';
import 'dart:io';

class Updater {
  static const githubApiUrl = 'https://api.github.com/repos';
  static const repoOwner = "necodeIT";
  static const repoName = "code-book";
  static const repoUrl = "$githubApiUrl/$repoOwner/$repoName";

  static var _appName = "";
  static var _packageName = "";
  static var _version = "";
  static var _buildNumber = "";
  static var _latestVersion = "";
  static var _latestReleaseName = "";
  static var _updateAvailable = false;
  static var _setupDownloadUrl = "";

  static String get currentVersion => _version;
  static String get packageName => _packageName;
  static String get appName => _appName;
  static String get buildNumber => _buildNumber;
  static String get latestVersion => _latestVersion;
  static String get latestReleaseName => _latestReleaseName;
  static bool get updateAvailable => _updateAvailable;
  static String get setupDownloadUrl => _setupDownloadUrl;

  static Future init() {
    return Future(() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      _appName = packageInfo.appName;
      _packageName = packageInfo.packageName;
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
      _updateAvailable = await checkForUpdate();
    });
  }

  /// Check for newer release on github https://api.github.com/repos/necodeIT/code-book/releases/latest
  static Future<bool> checkForUpdate() async {
    var client = Client();
    var response = await client.get(Uri.parse("$repoUrl/releases/latest"));
    var json = jsonDecode(response.body);
    _latestVersion = json["tag_name"];
    _latestReleaseName = json["name"];
    // get asset download url with name WindowsSetup.exe
    var asset = json["assets"].firstWhere((asset) => asset["name"] == "WindowsSetup.exe");
    _setupDownloadUrl = asset["browser_download_url"];

    return latestVersion != _version;
  }

  /// Download the setup file to temp folder
  static Future<String> upgrade(Function(int, int)? onReceiveProgress) async {
    var dio = Dio();
    var path = "${Directory.systemTemp.path}/$_appName - $latestReleaseName Setup.exe";
    await dio.download(_setupDownloadUrl, path, onReceiveProgress: onReceiveProgress);

    return path;
  }
}

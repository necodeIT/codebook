import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class CloudFile {
  CloudFile({required this.name, required this.content});

  final String name;
  final String content;
}

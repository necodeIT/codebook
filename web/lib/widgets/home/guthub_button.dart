// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/widgets/home/home.dart';
import 'package:web/widgets/themed_button.dart';

class GitHubButton extends StatelessWidget {
  GitHubButton({Key? key}) : super(key: key);

  static openRepo() {
    launch(Home.repo);
  }

  static const icon = Feather.github;

  @override
  Widget build(BuildContext context) {
    return ThemedButton(
      label: "GitHub",
      onPressed: openRepo,
      outlined: true,
      icon: icon,
    );
  }
}

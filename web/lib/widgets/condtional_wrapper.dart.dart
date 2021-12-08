import 'package:flutter/material.dart';

class ConditionalWrapper extends StatelessWidget {
  const ConditionalWrapper({Key? key, required this.builder, required this.child, required this.condition}) : super(key: key);

  final Widget Function(BuildContext, Widget) builder;
  final Widget child;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return condition ? builder(context, child) : child;
  }
}

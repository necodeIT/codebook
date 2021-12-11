import 'package:flutter/material.dart';

class ConditionalWrapper extends StatelessWidget {
  ConditionalWrapper({Key? key, required this.builder, required this.child, required this.condition, Widget Function(BuildContext, Widget)? falseBuilder}) : super(key: key) {
    this.falseBuilder = falseBuilder ?? (_, __) => null;
  }

  final Widget Function(BuildContext, Widget) builder;
  late final Widget? Function(BuildContext, Widget) falseBuilder;
  final Widget child;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return condition ? builder(context, child) : falseBuilder(context, child) ?? child;
  }
}

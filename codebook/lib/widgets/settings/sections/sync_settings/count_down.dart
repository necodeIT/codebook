// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:codebook/db/sync/sync.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui/widgets/widgets.dart';

class CountDown extends StatefulWidget {
  CountDown({Key? key, this.fontSize}) : super(key: key);

  final double? fontSize;

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late Timer _timer;
  late int _seconds;

  _onTimer(_) {
    setState(() {
      _seconds--;
    });
    if (_seconds == 0) {
      _timer.cancel();
    }
  }

  @override
  void initState() {
    _seconds = Sync.lockedTimestamp.add(Sync.currentLockCooldown).difference(DateTime.now()).inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimer);

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NcBodyText(
      "Please wait $_seconds seconds.",
      fontSize: widget.fontSize,
    );
  }
}

// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

import 'dart:async';

class CountTimer extends StatefulWidget {
  final int timeDuration;
  final Color backgroundColor;
  final bool isVisible;

  const CountTimer({
    super.key,
    required this.timeDuration,
    required this.isVisible,
    this.backgroundColor = ThemeColors.success,
  });

  @override
  State<CountTimer> createState() => _CounterState();
}

class _CounterState extends State<CountTimer> {
  late int timeDuration;
  late Timer _timer;
  int second = -1;

  @override
  void initState() {
    super.initState();
    if (widget.timeDuration == 0) second = 1;
    ticker();
  }

  void ticker() {
    setState(() {
      timeDuration = widget.timeDuration;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeDuration += second;
        if (timeDuration < 0) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits((timeDuration / 60).floor());
    final seconds = strDigits(timeDuration % 60);
    return Container(
        width: 92,
        margin: const EdgeInsets.only(top: 8, bottom: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: widget.isVisible ? ThemeColors.success : ThemeColors.label),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.alarm_sharp,
              color: ThemeColors.label,
              size: 20,
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('$minutes : $seconds',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.DescText(
                        ThemeColors.label, 18, FontWeight.w400))),
          ],
        ));
  }
}
